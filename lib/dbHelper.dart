import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todolist/auth.dart';

class DBHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Auth _auth = Auth();

  Future<void> addTodolist(String name, String description, String date, String time, String category) async {
    String userId = _auth.currentUser?.uid ?? '';

    if (userId.isNotEmpty) {
      try {
        await _firestore.collection('users').doc(userId).collection('todolist').add({
          'name': name,
          'description': description,
          'date': date,
          'time': time,
          'category': category,
          'created_at': FieldValue.serverTimestamp(),
        });
        print('Catatan berhasil disimpan');
      } catch (e) {
        print('Error saving note: $e');
        rethrow;
      }
    } else {
      print('User tidak ditemukan');
      throw Exception('User ID tidak valid.');
    }
  }
}
