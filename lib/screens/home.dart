import 'package:flutter/material.dart';
import 'package:noteskeeper/buttons.dart';
import 'package:noteskeeper/screens/registration.dart';
import 'login.dart';

class HomeScreen extends StatefulWidget {

  static const String id = "home_screen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Buttons(
              text: 'Log In',
              textColor: Colors.white,
              color: Colors.lightBlueAccent,
              callback: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            SizedBox(
              height: 30.0,
            ),
            Buttons(
              text: 'Register',
              textColor: Colors.white,
              color: Colors.blueAccent,
              callback: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
