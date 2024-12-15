import 'package:flutter/material.dart';
import 'package:todolist/sign_in.dart';
import 'package:todolist/sign_up.dart';
import 'package:todolist/sign_up.dart';

void main() {
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