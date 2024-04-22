import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference tasks =
      FirebaseFirestore.instance.collection('tasks');

  Future addTask(String task) {
    return tasks.add({
      'task': task,
      'value': false,
      'time_stamp': Timestamp.now(),
    });
  }

  Stream get getTasks {
    return tasks.orderBy('time_stamp', descending: true).snapshots();
  }

  Future updateTask(String docID, String newTask) {
    return tasks.doc(docID).update({
      'task': newTask,
      'time_stamp': Timestamp.now(),
    });
  }

  Future updateTaskValue(String docID, bool? value) {
    return tasks.doc(docID).update({
      'value': value,
      'time_stamp': Timestamp.now(),
    });
  }

  Future deleteTask(String docID) {
    return tasks.doc(docID).delete();
  }
}
