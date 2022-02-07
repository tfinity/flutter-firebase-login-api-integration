import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_app/Dashboard.dart';
import 'package:web_app/global.dart';
import 'Register.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Signin extends StatefulWidget {
  const Signin({Key key}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  Color color = Colors.orange;
  CollectionReference ref = FirebaseFirestore.instance.collection('Users');
  TextEditingController userName = new TextEditingController();
  TextEditingController password = new TextEditingController();
  userLogin() {
    ref.doc(userName.text).get().then((value) {
      if (value.exists && value.get('password') == password.text) {
        globalUserName = userName.text;
        Navigator.pushNamed(context, '/dashboard');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'icon.png',
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.2,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.4,
            color: Colors.grey[850],
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: userName,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: color,
                        ),
                      ),
                      labelText: 'UserName',
                      labelStyle: TextStyle(
                        fontSize: 20,
                        color: color,
                      ),
                      hintText: 'Enter Username ',
                      prefixIcon: Icon(
                        Icons.person,
                        color: color,
                        size: 40,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: password,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: color,
                        ),
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        fontSize: 20,
                        color: color,
                      ),
                      hintText: 'Enter Password ',
                      prefixIcon: Icon(
                        Icons.lock,
                        color: color,
                        size: 40,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                      onPrimary: Colors.white,
                      shadowColor: color,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                      minimumSize: Size(120, 50),
                    ),
                    onPressed: () => userLogin(),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Text(
                      'Create New Account?',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
