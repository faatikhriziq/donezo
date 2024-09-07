import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donezo/core/shared/local_storage/auth_local_storage.dart';

class TaskDatasource {
  final FirebaseFirestore _firestore;
  TaskDatasource({required FirebaseFirestore firestore})
      : _firestore = firestore;

  Future<void> addCategory(String name) async {
    try {
      final collection = _firestore.collection('categories');
      final userId = await getUserId();

      await collection.add({'name': name, 'user_id': userId});
    } catch (e) {
      throw Exception('Failed to add category : $e');
    }
  }
}
