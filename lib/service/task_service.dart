import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TaskService {
  CollectionReference taskCollection;

  String userUid;

  TaskService() {
    FirebaseAuth.instance.currentUser().then(
      (user) {
        userUid = user.uid;
        taskCollection = Firestore.instance.collection('user/$userUid/tasks');
      },
    );
  }

  Future<void> addTask(bool is_complete, String text) async {
    return await taskCollection.add({'is_complete': is_complete, 'text': text});
  }

  Stream<QuerySnapshot> getTaskList() {
    return taskCollection.snapshots();
  }
}
