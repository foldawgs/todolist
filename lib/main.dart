import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Tambahkan ini
import 'package:todolist/pages/sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Pastikan binding Flutter sudah diinisialisasi
  await Firebase.initializeApp(); // Inisialisasi Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF043D6A)),
        useMaterial3: true,
      ),
      home: SignInApp(),
    );
  }
}
