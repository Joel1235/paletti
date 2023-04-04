
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 40),
        TextField(
          controller: emailController,
          cursorColor: Colors.white,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(labelText: 'Enter your Email'),
        ),
        SizedBox(height: 4),
        TextField(
          controller: passwordController,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(labelText: 'Enter your Email'),
          obscureText: true,
        ),
        SizedBox(height: 20),
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(50)
            ),
            icon: Icon(Icons.lock_open, size: 32),
            label: Text(
              'Sign In',
              style: TextStyle(fontSize: 24),
            ),
            onPressed: signIn,
        )
      ],
    ),
  );

  Future signIn() async{
    //await FirebaseAuth instance.signInWi
  }
}