import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:noteskeeper/screens/home.dart';
import 'package:noteskeeper/screens/login.dart';
import 'package:noteskeeper/screens/notes.dart';
import 'package:noteskeeper/screens/registration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        Notes.id: (context) => Notes(),
      },
    );
  }
}


