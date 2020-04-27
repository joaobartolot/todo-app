import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_firebase/helper/user_helper.dart';

class TaskService {
  CollectionReference taskCollection;

  String userUid;

  TaskService() {
    UserHelper.getUserUid().then(
      (value) {
        userUid = value;
        taskCollection = Firestore.instance.collection('user/$userUid/tasks');
      },
    );
  }

  Future<void> addTask(bool isDone, String text) async {
    return await taskCollection.add({'isDone': isDone, 'text': text});
  }

  Stream<QuerySnapshot> getTaskList() {
    return taskCollection.snapshots();
  }
}
