import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final CollectionReference taskmateCollection = FirebaseFirestore.instance.collection("taskmates");

  User? user = FirebaseAuth.instance.currentUser;

  Future<DocumentReference> addTask(String title, String description) async {
    return await taskmateCollection.add({
      'uid': user!.uid,
      'title': title,
      'description': description,
      'completed': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Update taskmate
  Future<void> updateTaskmate(String id, String title, String description) async {
    final updatetaskmateCollection = FirebaseFirestore.instance.collection("taskmates").doc(id);
    return await updatetaskmateCollection.update({
      'title': title,
      'description': description,
    });
  }

  // Update taskmate status
  Future<void> updateTaskmateStatus(String id, bool completed) async {
    return await taskmateCollection.doc(id).update({'completed': completed});
  }

  // Delete taskmate
  Future<void> deleteTaskmate(String id) async {
    return await taskmateCollection.doc(id).delete();
  }

  // Get pending tasks
  Stream<List<Taskmate>> get tasks {
    return taskmateCollection
        .where('uid', isEqualTo: user!.uid)
        .where('completed', isEqualTo: false)
        .snapshots()
        .map(_taskmateListFromSnapshot);
  }

  // Get completed tasks
  Stream<List<Taskmate>> get completedTasks {
    return taskmateCollection
        .where('uid', isEqualTo: user!.uid)
        .where('completed', isEqualTo: true)
        .snapshots()
        .map(_taskmateListFromSnapshot);
  }

  List<Taskmate> _taskmateListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Taskmate(
        id: doc.id,
        title: doc['title'] ?? '',
        description: doc['description'] ?? '',
        completed: doc['completed'] ?? false,
        timeStamp: doc['createdAt'] != null ? (doc['createdAt'] as Timestamp).toDate() : DateTime.now(),
      );
    }).toList();
  }
}

class Taskmate {
  final String id;
  final String title;
  final String description;
  final bool completed;
  final DateTime timeStamp;

  Taskmate({
    required this.id,
    required this.title,
    required this.description,
    required this.completed,
    required this.timeStamp,
  });
}
