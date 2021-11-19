// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login11/src/views/screens/signin_screen.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // Firebase Auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //keys
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//TextEditing controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void onClose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Signup Screen"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 24.0,
              ),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,

                controller: _emailController,
                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                  hintText: 'Enter email',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 24.0,
              ),
              child: TextFormField(
                keyboardType: TextInputType.text,
                obscureText: true,
                controller: _passwordController,
                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                  hintText: 'Enter password',
                ),
              ),
            ),
            RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                color: Colors.orange,
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await _auth.createUserWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text,
                    );
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SigninScreen(),
                    ));
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => Text("Incorrect Details"),
                    );
                  }

                  //sign up functionality
                }),
          ],
        ),
      ),
    );
  }
}
