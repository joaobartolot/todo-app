import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_firebase/model/task_model.dart';
import 'package:todo_firebase/service/task_service.dart';

class HomeProvider with ChangeNotifier {
  TaskService _taskService = TaskService();

  bool _isCollapsed = true;
  bool get isCollapsed => _isCollapsed;
  set isCollapsed(bool value) {
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
    TaskModel(is_complete: true, text: 'Buy somethings'),
    TaskModel(is_complete: false, text: 'Do the homework')
  ];
  List<TaskModel> get tasks => _tasks;
  set tasks(List<TaskModel> value) {
    _tasks = value;
    notifyListeners();
  }

  void toggleTodo(String taskId, bool value) {
    Firestore.instance
        .collection('task')
        .document(taskId)
        .updateData({'is_complete': value});
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

  Stream<QuerySnapshot> getTasks(String uid) {
    return Firestore.instance
        .collection('task')
        .where('user', isEqualTo: uid)
        .orderBy('date_creation')
        .snapshots();
  }

  void addTask(String uid) {
    Firestore.instance.collection('task').add(
      {
        'user': uid,
        'is_complete': newTaskChecked,
        'text': newTaskText,
        'date_creation': DateTime.now(),
      },
    );
    newTaskChecked = false;
    newTaskText = '';
    isAdding = false;
  }

  Future<Stream<QuerySnapshot>> taskList() async {
    var user = await FirebaseAuth.instance.currentUser();
    return Firestore.instance.collection('user/${user.uid}/tasks').snapshots();
  }
}
