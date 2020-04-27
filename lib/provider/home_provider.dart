import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_firebase/helper/user_helper.dart';
import 'package:todo_firebase/model/task_model.dart';
import 'package:todo_firebase/service/task_service.dart';

class HomeProvider with ChangeNotifier {
  TaskService _taskService = TaskService();

  bool _isCollapsed = true;
  bool get isCollapsed => _isCollapsed;
  set isCollapsed(bool value) {
    print(value);
    _isCollapsed = value;
    notifyListeners();
  }

  bool _isAdding = false;
  bool get isAdding => _isAdding;
  set isAdding(bool value) {
    _isAdding = value;
    notifyListeners();
  }

  List<TaskModel> _tasks = <TaskModel>[
    TaskModel(isDone: true, text: 'Buy somethings'),
    TaskModel(isDone: false, text: 'Do the homework')
  ];
  List<TaskModel> get tasks => _tasks;
  set tasks(List<TaskModel> value) {
    _tasks = value;
    notifyListeners();
  }

  void addTask(TaskModel task) {
    tasks.insert(0, task);
    _taskService.addTask(task.isDone, task.text);
    notifyListeners();
  }

  void toggleTodo(TaskModel task) {
    final taskIndex = _tasks.indexOf(task);
    _tasks[taskIndex].isDone = !_tasks[taskIndex].isDone;
    notifyListeners();
  }

  void animateProfileMenu(AnimationController controller) {
    isCollapsed = !isCollapsed;
    _isCollapsed ? controller.reverse() : controller.forward();
  }

  bool _newTaskChecked = false;
  bool get newTaskChecked => _newTaskChecked;
  set newTaskChecked(bool value) {
    _newTaskChecked = value;
    notifyListeners();
  }

  String _newTaskText;
  String get newTaskText => _newTaskText;
  set newTaskText(String value) {
    _newTaskText = value;
    notifyListeners();
  }

  Future<Stream<QuerySnapshot>> taskList() async {
    var uid = await UserHelper.getUserUid();
    return Firestore.instance.collection('user/$uid/tasks').snapshots();
  }
}
