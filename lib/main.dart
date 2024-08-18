import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:webapp/first_Screen.dart';
import 'package:webapp/login_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyCAB2A3Eu-mo-3yiufRwSCkPuXz35J0h1c",
    projectId: "webproject-e47c8",
    messagingSenderId: "30173382874",
    appId: "1:30173382874:web:b4f806f186450a014c3de3",
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
    );
  }
}
