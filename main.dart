import 'package:flutter/material.dart';
import 'package:web_app/Register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:web_app/SelectMovies.dart';

import 'Dashboard.dart';
import 'Signin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyB1tqUcsnrrd3EYJqvDfqTozIWm-V7RNNI",
        authDomain: "webapp-3cf21.firebaseapp.com",
        projectId: "webapp-3cf21",
        storageBucket: "webapp-3cf21.appspot.com",
        messagingSenderId: "646903682499",
        appId: "1:646903682499:web:b943a4ab9111a487b21976",
        measurementId: "G-J941N3JKFG"),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies Mafia',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      routes: {
        '/register': (context) => Register(),
        '/dashboard': (context) => Dashboard(),
        '/add': (context) => AddMovie(),
      },
      home: MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Movies Mafia',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.black,
      body: Signin(),
    );
  }
}
