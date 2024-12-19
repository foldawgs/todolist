import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('Login berhasil untuk: $email');
    } catch (e) {
      print('Login gagal: $e');
      rethrow;
    }
  }

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('Registrasi berhasil untuk: $email');
    } catch (e) {
      print('Registrasi gagal: $e');
      rethrow; // Agar kesalahan dapat dilihat lebih jelas saat debugging
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
