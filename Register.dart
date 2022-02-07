import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'global.dart';

class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Color color = Colors.orange;
  TextEditingController userName = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  CollectionReference ref = FirebaseFirestore.instance.collection('Users');
  registerUser() {
    ref.doc(userName.text).set({
      'userName': userName.text,
      'email': email.text,
      'password': password.text,
    });
    globalUserName = userName.text;
    Navigator.pushNamed(context, '/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Movies Mafia',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.black,
      body: Center(
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
              height: MediaQuery.of(context).size.height * 0.55,
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
                      cursorColor: color,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: email,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: color,
                          ),
                        ),
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          fontSize: 20,
                          color: color,
                        ),
                        hintText: 'example@gmail.com ',
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
                        onPrimary: Colors.black,
                        shadowColor: color,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                        minimumSize: Size(120, 50),
                      ),
                      onPressed: () => registerUser(),
                      child: Text('Register'),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
