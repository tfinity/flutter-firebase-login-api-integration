import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'global.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final Stream<QuerySnapshot> dataStream = FirebaseFirestore.instance
      .collection('Records')
      .doc(globalUserName)
      .collection('data')
      .snapshots();
  CollectionReference ref = FirebaseFirestore.instance
      .collection('Records')
      .doc(globalUserName)
      .collection('data');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'DashBoard',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add'),
        tooltip: 'Add new Movie',
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Colors.orange,
      ),
      body: StreamBuilder(
        stream: dataStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('error');
            return Text("something Wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            print('waiting');
            return CircularProgressIndicator();
          }

          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (_, index) {
              return Container(
                height: 300,
                child: Card(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Container(
                        height: 250,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                              'https://image.tmdb.org/t/p/w500' +
                                  snapshot.data.docs[index].data()['picture'],
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Container(
                              width: 130,
                              child: Text(
                                snapshot.data.docs[index].data()['title'],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.orange,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              ref.doc(snapshot.data.docs[index].id).delete();
                              //snapshot.data.docs[index].id.reference.delete();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
