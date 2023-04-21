import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'navBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Signed In as: ',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              user.email!,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton.icon(
              //style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
              icon: Icon(Icons.arrow_back, size: 32),
              label: Text('Sign Out', style: TextStyle(fontSize: 24)),
              onPressed: () => FirebaseAuth.instance.signOut(),
            )
          ],
        ),
      ),
      drawer: NavBar(),
      appBar: AppBar(
        title: Text(widget.title),
      ),
    );
  }
}
