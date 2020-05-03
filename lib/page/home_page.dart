import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/model/task_model.dart';
import 'package:todo_firebase/provider/home_provider.dart';
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
                            child: FutureBuilder(
                              future: provider.taskList(),
                              builder: (context, stream) => stream.hasData
                                  ? StreamBuilder(
                                      stream: stream.data,
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
                                        if (snapshot.data.documents.length == 0)
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
                                              Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                60.0,
                                            child: Row(
                                              children: <Widget>[
                                                Checkbox(
                                                  value: taskList[index]
                                                      .data['isDone'],
                                                  onChanged: (value) {
                                                    print('implement');
                                                    // provider.toggleTodo(
                                                    //     taskList[index].data);
                                                  },
                                                ),
                                                Text(
                                                  taskList[index].data['text'],
                                                  style: taskList[index]
                                                          .data['isDone']
                                                      ? TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough)
                                                      : null,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  : null,
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
                      child: StreamBuilder(
                        stream: FirebaseAuth.instance.currentUser().asStream(),
                        builder: (context, snapshot) => snapshot.hasData &&
                                snapshot.data != null
                            ? Column(
                                children: <Widget>[
                                  TaskAppBar(
                                    controller: _controller,
                                    photoUrl: '',
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

class NewTask extends StatelessWidget {
  const NewTask({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HomeProvider>(context);
    return Opacity(
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
                provider.addTask(
                  TaskModel(
                    isDone: provider.newTaskChecked,
                    text: provider.newTaskText,
                  ),
                );
                provider.newTaskChecked = false;
                provider.newTaskText = '';
                provider.isAdding = false;
              },
            )
          ],
        ),
      ),
    );
  }
}
