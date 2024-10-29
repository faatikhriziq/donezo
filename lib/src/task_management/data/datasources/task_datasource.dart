import 'dart:developer';

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

  Future<void> addTaskWithTodos(
      String title,
      String category,
      String description,
      DateTime dueDate,
      List<Map<String, dynamic>> todo) async {
    try {
      final collection = _firestore.collection('tasks');
      final userId = await getUserId();

      // Tambahkan dokumen task utama ke koleksi 'tasks'
      final taskDocRef = await collection.add({
        'title': title,
        'dueDate': Timestamp.fromDate(dueDate),
        'category': category,
        'description': description,
        'userId': userId,
        'completedPercentage': 0.0,
        'isCompleted': false,
      });

      // Tambahkan masing-masing todo ke subkoleksi 'todos' di dalam dokumen task
      for (var item in todo) {
        log('Adding todo: ${item['title']}');
        await taskDocRef.collection('todos').add(
          {
            'title': item['title'],
            'isCompleted': item['isCompleted'],
          },
        );
      }
    } catch (e) {
      throw Exception('Failed to add task and todos: $e');
    }
  }

  // Get Tasks Data from Firestore
  Future<List<Map<String, dynamic>>> getTasks() async {
    try {
      log("Getting tasks");
      final userId = await getUserId();
      final collection = _firestore.collection('tasks');
      final querySnapshot = await collection
          .where('userId', isEqualTo: userId)
          .orderBy('dueDate', descending: false)
          .get();

      // Prepare list of tasks with todos
      List<Map<String, dynamic>> tasksWithTodos = [];

      // Fetch todos for each task
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> taskData = doc.data();

        // Fetch todos for this task
        final todosSnapshot = await doc.reference.collection('todos').get();
        final todos =
            todosSnapshot.docs.map((todoDoc) => todoDoc.data()).toList();

        // Add todos to task data
        taskData['todos'] = todos;

        // Add task with todos to the list
        tasksWithTodos.add(taskData);
      }

      return tasksWithTodos;
    } catch (e) {
      throw Exception('Failed to get tasks: $e');
    }
  }
}
