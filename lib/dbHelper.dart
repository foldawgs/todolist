import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todolist/auth.dart';

class DBHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Auth _auth = Auth();

  // Menyimpan catatan ke Firestore
  Future<void> addTodolist(String name, String description, String date, String time, String category) async {
    // Mendapatkan user ID yang sedang login dari Auth
    String userId = _auth.currentUser?.uid ?? '';

    if (userId.isNotEmpty) {
      // Menyimpan data catatan ke dalam sub-koleksi 'todolist' berdasarkan user ID
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
      }
    } else {
      print('User tidak ditemukan');
    }
  }
}
