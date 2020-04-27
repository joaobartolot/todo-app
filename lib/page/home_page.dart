import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_firebase/helper/user_helper.dart';
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
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: TaskAppBar(
                      controller: _controller,
                    ),
                  ),
                  Positioned(
                    top: 75.0,
                    width: MediaQuery.of(context).size.width - 60.0,
                    height: MediaQuery.of(context).size.height - 75.0,
                    child: Flex(
                      direction: Axis.vertical,
                      children: <Widget>[
                        SizedBox(height: 50.0),
                        NewTask(),
                        Consumer<HomeProvider>(
                          builder: (context, provider, _) => Expanded(
                            flex: 1,
                            child: FutureBuilder(
                              future: provider.taskList(),
                              builder: (context, stream) => stream.hasData
                                  ? StreamBuilder(
                                      stream: stream.data,
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData)
                                          return Container(
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Theme.of(context)
                                                          .primaryColor),
                                            ),
                                          );

                                        var taskList = snapshot.data.documents;

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
                                      })
                                  : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Consumer<HomeProvider>(
                    builder: (context, provider, _) => Positioned(
                      top: 75.0,
                      child: SizeTransition(
                        sizeFactor: _controller,
                        child: ProfileMenu(),
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
