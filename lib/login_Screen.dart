import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:webapp/Pages/Admin.dart';
import 'package:webapp/Pages/User.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _signIn(BuildContext context) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      checkUserNav(context);
    } on FirebaseAuthException catch (e) {
      // Handle authentication errors
      print(e);
      // Show error message to user
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void checkUserNav(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String uid = user.uid!;

      CollectionReference users =
          FirebaseFirestore.instance.collection("Users");

      DocumentSnapshot userDoc = await users.doc(uid).get();

      if (userDoc.exists) {
        bool isAdmin = userDoc.get('isAdmin') as bool;

        if (isAdmin) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AdminPage(),
              ));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserPage(),
              ));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
                onPressed: () async {
                  _signIn(context);
                },
                child: Text("Sign In"))
          ],
        ),
      ),
    );
  }
}
