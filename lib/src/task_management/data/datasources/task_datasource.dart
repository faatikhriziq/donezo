import 'package:cloud_firestore/cloud_firestore.dart';

class TaskDatasource {
  final FirebaseFirestore _firestore;
  TaskDatasource({required FirebaseFirestore firestore}) : _firestore = firestore;

  Future<void> addCategory(String name) async {
    try {
      final collection = _firestore.collection('categories');
      await collection.add({'name': name});
    } catch (e) {
      throw Exception('Failed to add category : $e');
    }
  }
}
