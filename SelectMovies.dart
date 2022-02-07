import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:web_app/global.dart';

class AddMovie extends StatefulWidget {
  const AddMovie({Key key}) : super(key: key);

  @override
  _AddMovieState createState() => _AddMovieState();
}

class _AddMovieState extends State<AddMovie> {
  void initState() {
    getResults();
  }

  Future getResults() async {
    var result = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=f79853684e5304bcc8de22d03b62a015&language=en-US&page=1'));
    var data = jsonDecode(result.body);
    return data['results'];
  }

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
          'Add Movie',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getResults(),
                builder: (builder, snapshot) {
                  if (!snapshot.hasData)
                    return CircularProgressIndicator();
                  else
                    return GridView.builder(
                        itemCount: snapshot.data.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                        itemBuilder: (context, index) {
                          return Container(
                            height: 350,
                            child: Card(
                              color: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                children: [
                                  Container(
                                    height: 280,
                                    width: 280,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                            'https://image.tmdb.org/t/p/w500' +
                                                snapshot.data[index]
                                                    ['poster_path']),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Container(
                                          width: 130,
                                          child: Text(
                                            snapshot.data[index]['title'],
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.orange),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.favorite_border,
                                          color: Colors.orange,
                                        ),
                                        onPressed: () {
                                          print(globalUserName);
                                          ref
                                              .doc(
                                                  snapshot.data[index]['title'])
                                              .set({
                                            'title': snapshot.data[index]
                                                ['title'],
                                            'picture': snapshot.data[index]
                                                ['poster_path'],
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                }),
          ),
        ],
      ),
    );
  }
}
