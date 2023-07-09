import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paletti_1/components/dashborad/dashboardContent.dart';
import '../../provider/MenuAppController.dart';
import '../../navBar.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              //default flex = 1, takes 1/6 of screen
              child: NavBar(),
            ),
            Expanded(
              flex: 5, //takes 5/6 of screen
              child: DashoardContent(),
            )
          ],
        ),
      ),
    );
  }
}
