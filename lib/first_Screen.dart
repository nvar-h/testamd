import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:webapp/login_Screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  List<String> users = ['Admin', "User"];
  String selectedUserType = "User";
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> createUser() async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: _email.text.trim(),
        password: _password.text.trim(),
      );

      User user = auth.currentUser!;

      FirebaseFirestore.instance.collection("Users").doc(user.uid).set({
        "Email": _email.text.trim(),
        "isAdmin": selectedUserType == "Admin" ? true : false
      });
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => LoginPage(),
      ));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 82, 82, 82),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: 200,
              width: double.infinity,
              child: Column(
                children: [
                  Text("Email"),
                  TextField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ],
              )),
          const SizedBox(
            height: 30,
          ),
          Container(
              height: 200,
              width: double.infinity,
              child: Column(
                children: [
                  Text("Password"),
                  TextField(
                    controller: _password,
                    obscureText: true,
                  ),
                ],
              )),
          const SizedBox(
            height: 10,
          ),
          DropdownButton(
              value: selectedUserType,
              items: users
                  .map((String users) =>
                      DropdownMenuItem(value: users, child: Text(users)))
                  .toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedUserType = newValue!;
                });
              }),
          ElevatedButton(
              onPressed: () {
                createUser();
              },
              child: Text("Create User"))
        ],
      ),
    );
  }
}
