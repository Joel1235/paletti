import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paletti_1/components/dashborad/dashboardContent.dart';
import '../../controllers/MenuAppController.dart';
import '../../navBar.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text('Dashboard'),
      ),*/
      key: context.read<MenuAppController>().scaffoldKey,
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
