import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:noteskeeper/buttons.dart';
import 'package:noteskeeper/constants.dart';
import 'package:noteskeeper/screens/notes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:noteskeeper/screens/registration.dart';

class LoginScreen extends StatefulWidget {

  static const String id = "login_screen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  void signIn(String email, String password) async {
    if(_formKey.currentState!.validate()) {
      try{
        await _auth.signInWithEmailAndPassword(email: email, password: password).then((uid) => {
          Fluttertoast.showToast(msg: "Login Successful"),
          Navigator.pushNamed(context, Notes.id),
          emailController.clear(),
          passwordController.clear(),
          emailController.selection = TextSelection.fromPosition(TextPosition(offset: emailController.text.length))
        });
      } on FirebaseAuthException catch (error) {
        switch(error.code) {
          case "invalid-email":
            errorMssg = "Your email address in wrong";
            break;
          case "wrong-password":
            errorMssg = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMssg = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMssg = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMssg = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMssg = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMssg = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMssg!);
        print(error.code);
      }
    }
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  final _auth = FirebaseAuth.instance;
  String? errorMssg;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.red,
              Colors.orange
            ]
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        width: 150.0,
                        height: 150.0,
                        child: Image.asset('images/pngegg.png', color: Colors.yellow),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      TextFormField(
                        cursorColor: Colors.red.shade900,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: Colors.grey.shade300, fontSize: 20.0),
                        validator: (value) {
                          if(value == null || value.isEmpty) {
                            return "Please enter some text";
                          }
                          if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
                            return ("Please Enter a valid email");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          emailController.text = value!;
                        },

                        autofocus: false,
                        controller: emailController,
                        decoration: kTextFormFieldDecoration.copyWith(
                          hintText: "Email",
                          hintStyle: TextStyle(
                            color: Colors.grey.shade300
                          ),
                          prefixIcon: Icon(Icons.mail, color: Colors.grey.shade300),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade300,)
                          ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.yellow, width: 2.0),
                                borderRadius: BorderRadius.all(Radius.circular(15.0))
                            ),
                        )
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                          cursorColor: Colors.red.shade900,
                        textInputAction: TextInputAction.done,
                          style: TextStyle(color: Colors.grey.shade300, fontSize: 20.0),
                          validator: (value) {
                            RegExp regex = new RegExp(r'^.{6,}$');
                            if(value == null || value.isEmpty) {
                              return "Please enter some text";
                            }
                            if(!regex.hasMatch(value)) {
                              return ("Please Enter a valid email");
                            }
                          },
                          onSaved: (value) {
                            passwordController.text = value!;
                          },

                          autofocus: false,
                          obscureText: true,
                          controller: passwordController,
                          decoration: kTextFormFieldDecoration.copyWith(
                              hintText: "Password",
                              hintStyle: TextStyle(
                                  color: Colors.grey.shade300
                              ),
                              prefixIcon: Icon(Icons.vpn_key, color: Colors.grey.shade300),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey.shade300)
                              ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.yellow, width: 2.0),
                                borderRadius: BorderRadius.all(Radius.circular(15.0))
                            ),
                          )
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      Buttons(
                        text: 'Log In',
                        textColor: Colors.red,
                        color: Colors.yellow,
                        callback: () {
                          FocusManager.instance.primaryFocus!.unfocus();
                          signIn(emailController.text, passwordController.text);
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, RegistrationScreen.id);
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      )
    );
  }
}

