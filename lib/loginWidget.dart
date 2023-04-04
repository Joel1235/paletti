
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:paletti_1/main.dart';
//import 'package:firebase_auth/firebase_auth_email/main.dart';

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }

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
        SizedBox(height: 24),
        RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.grey, ),
            text: 'No account ?  ',
            children: [
              TextSpan(
                //recognizer: TabGestureRecognizer()..onTab,
                text: 'Sign Up',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  //color: Theme.of(context).colorScheme()
                )
              )
            ]
          ),
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
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()),
    );

    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e){
      print(e);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}