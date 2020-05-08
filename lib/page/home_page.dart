import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/model/task_model.dart';
import 'package:todo_firebase/provider/home_provider.dart';
import 'package:todo_firebase/provider/item_task_provider.dart';
import 'package:todo_firebase/widget/profile_menu.dart';
import 'package:todo_firebase/widget/task_app_bar.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
      create: (context) => HomeProvider(),
      child: Consumer<HomeProvider>(
        builder: (context, provider, _) => GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
            if (!provider.isCollapsed) provider.animateProfileMenu(_controller);
          },
          child: Scaffold(
            body: SafeArea(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 75.0,
                    left: 20.0,
                    width: MediaQuery.of(context).size.width - 40.0,
                    height: MediaQuery.of(context).size.height - 75.0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Flex(
                        direction: Axis.vertical,
                        children: <Widget>[
                          SizedBox(height: 50.0),
                          NewTask(),
                          Expanded(
                            flex: 1,
                            child: StreamBuilder<FirebaseUser>(
                              stream: FirebaseAuth.instance
                                  .currentUser()
                                  .asStream(),
                              builder: (context, user) => user.hasData
                                  ? StreamBuilder<QuerySnapshot>(
                                      stream: provider.getTasks(user.data.uid),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData)
                                          return Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                              Color>(
                                                          Theme.of(context)
                                                              .primaryColor),
                                                ),
                                              ],
                                            ),
                                          );

                                        var taskList = snapshot.data.documents;
                                        if (taskList.length == 0)
                                          return Center(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                top: provider.isAdding
                                                    ? 15.0
                                                    : 0.0,
                                              ),
                                              child: Column(
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.info_outline,
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                    size: 40.0,
                                                  ),
                                                  SizedBox(height: 10.0),
                                                  Text(
                                                    "Looks like you don't have any task 😕.",
                                                    style: TextStyle(
                                                        fontSize: 20.0),
                                                  ),
                                                  Text(
                                                      "you can add a new task by taping in the + icon."),
                                                ],
                                              ),
                                            ),
                                          );
                                        return ListView.builder(
                                          itemCount: taskList.length,
                                          itemBuilder: (context, index) =>
                                              ItemTask(item: taskList[index]),
                                        );
                                      },
                                    )
                                  : CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Theme.of(context).primaryColor),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: StreamBuilder<FirebaseUser>(
                        stream: FirebaseAuth.instance.currentUser().asStream(),
                        builder: (context, snapshot) => snapshot.hasData &&
                                snapshot.data != null
                            ? Column(
                                children: <Widget>[
                                  TaskAppBar(
                                    controller: _controller,
                                    photoUrl: snapshot.data.photoUrl,
                                    name: snapshot.data.displayName,
                                  ),
                                  SizeTransition(
                                    sizeFactor: _controller,
                                    child: ProfileMenu(
                                      name: snapshot.data.displayName,
                                      email: snapshot.data.email,
                                    ),
                                  ),
                                ],
                              )
                            : Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Theme.of(context).primaryColor),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ItemTask extends StatelessWidget {
  const ItemTask({
    Key key,
    @required this.item,
  }) : super(key: key);

  final DocumentSnapshot item;

  @override
  Widget build(BuildContext context) {
    final home_provider = Provider.of<HomeProvider>(context);
    return ChangeNotifierProvider(
      create: (context) => ItemTaskProvider(),
      child: Consumer<ItemTaskProvider>(
        builder: (context, provider, _) => InkWell(
          onTap: () => home_provider.toggleTodo(
            item.documentID,
            !item.data['is_complete'],
          ),
          onLongPress: () => provider.isEditing = !provider.isEditing,
          child: Container(
            width: MediaQuery.of(context).size.width - 60.0,
            child: Row(
              children: <Widget>[
                Checkbox(
                  value: item.data['is_complete'],
                  onChanged: (value) {
                    home_provider.toggleTodo(
                      item.documentID,
                      !item.data['is_complete'],
                    );
                  },
                  activeColor: Theme.of(context).primaryColor,
                ),
                Text(
                  item.data['text'],
                  style: item.data['is_complete']
                      ? TextStyle(decoration: TextDecoration.lineThrough)
                      : null,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child:
                      provider.isEditing ? Icon(Icons.more_horiz) : Container(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NewTask extends StatelessWidget {
  const NewTask({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HomeProvider>(context);
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.currentUser().asStream(),
      builder: (context, snapshot) => Opacity(
        opacity: provider.isAdding ? 1.0 : 0.0,
        child: Container(
          height: provider.isAdding ? 40.0 : 0.0,
          width: MediaQuery.of(context).size.width - 60,
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Checkbox(
                value: provider.newTaskChecked,
                onChanged: (value) => provider.newTaskChecked = value,
                activeColor: Theme.of(context).primaryColor,
              ),
              Expanded(
                flex: 1,
                child: TextField(
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 5.0,
                    ),
                  ),
                  onChanged: (value) => provider.newTaskText = value,
                ),
              ),
              IconButton(
                icon: Icon(Icons.check),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  print('save');
                  FocusScope.of(context).requestFocus(FocusNode());

                  provider.addTask(snapshot.data.uid);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
