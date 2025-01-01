import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todolist/auth.dart';

class DBHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Auth _auth = Auth();

  Future<void> addTodolist(
      String name, String description, String date, String time, String category) async {
    String userId = _auth.currentUser?.uid ?? '';

    if (userId.isNotEmpty) {
      try {
        // Menggabungkan date dan time menjadi DateTime
        List<String> dateParts = date.split('-');
        List<String> timeParts = time.split(':');
        DateTime dateTime = DateTime(
          int.parse(dateParts[2]), // year
          int.parse(dateParts[1]), // month
          int.parse(dateParts[0]), // day
          int.parse(timeParts[0]), // hour
          int.parse(timeParts[1]), // minute
        );

        // Menyimpan data ke Firestore
        await _firestore.collection('users').doc(userId).collection('todolist').add({
          'name': name,
          'description': description,
          'date': dateTime, // Simpan sebagai Timestamp
          'category': category,
          'selesai': false, // Field baru dengan default false
          'created_at': FieldValue.serverTimestamp(), // Menyimpan timestamp server
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
