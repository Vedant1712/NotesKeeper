import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _firestore = FirebaseFirestore.instance;

class Notes extends StatefulWidget {


  static const String id = "notes_screen";

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {

  final _auth = FirebaseAuth.instance;

  final TextEditingController data = new TextEditingController();
  String dataText = "";

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    var userdata = await _firestore.collection('notes').doc(_auth.currentUser!.uid).get();
    data.text = userdata.data()!['text'].toString();
    data.selection = TextSelection.fromPosition(TextPosition(offset: data.text.length));
  }

  @override
  void dispose() {
    data.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Welcome',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 35.0
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                            _firestore.collection('notes').doc(_auth.currentUser!.uid).set({'text': data.text}, SetOptions(merge: true));
                        },
                        icon: Icon(Icons.check, color: Colors.white, size: 35.0),
                      ),
                      IconButton(
                        onPressed: () {
                          _auth.signOut();
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close, color: Colors.white, size: 35.0,),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10.0,
                child: Center(
                  child: Container(
                    margin: EdgeInsetsDirectional.only(start: 0.0, end: 0.0),
                    height: 1.0,
                    color: Colors.white,
                  ),
                ),
              ),
              TextField(
                onChanged: (value) {
                  dataText = value;
                },
                cursorColor: Colors.white,
                controller: data,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0
                ),
                autofocus: true,
                decoration: InputDecoration(
                  hintText: "Enter some text",
                  hintStyle: TextStyle(
                    color: Colors.white
                  ),
                ),
                scrollPadding: EdgeInsets.all(20.0),
                maxLines: 9999,
              )
            ],
          ),
        ),
      ),
    );
  }
}
