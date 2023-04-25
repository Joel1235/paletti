import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:paletti_1/utils/responsive.dart';
import '../../models/Palettenkonto.dart';
import '../../utils/constants.dart';
import 'header.dart';
import 'myFields.dart';
import 'recentFile.dart';
import 'storageDetails.dart';

class DashoardContent extends StatefulWidget {
  @override
  _DashboardContetnState createState() => _DashboardContetnState();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      MyFiles(),
                      SizedBox(height: defaultPadding),
                      RecentFiles(),
                      if (Responsive.isMobile(context))
                        SizedBox(height: defaultPadding),
                      if (Responsive.isMobile(context)) StorageDetails(),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  SizedBox(width: defaultPadding),
                // On Mobile means if the screen is less than 850 we dont want to show it
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: StorageDetails(),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _DashboardContetnState extends State<DashoardContent> {
  Stream<QuerySnapshot<Map<String, dynamic>>>? _stream;

  @override
  void initState() {
    super.initState();
    _stream = FirebaseFirestore.instance
        .collection('palettenkonto1')
        .snapshots() as Stream<QuerySnapshot<Map<String, dynamic>>>?;
    print(_stream);

    // Hier kannst du den Code schreiben, der ausgeführt wird, wenn das Widget erstellt wird.
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      // //child: Column(
      children: [
        StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: _stream,
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            List<DocumentSnapshot<Map<String, dynamic>>> documents =
                snapshot.data!.docs;
            Palettenkonto palettenkonto =
                Palettenkonto.fromSnapshot(documents[0]);
            print('Konto \n ' + palettenkonto.toString());
            print('runtype ' + palettenkonto.runtimeType.toString());
            // hier können Sie die Daten verwenden
            return Column(
              children: [
                //Text('Hallo'),
                //MyFiles(palettenkonto: palettenkonto),
                SizedBox(height: defaultPadding),
                //RecentFiles(palettenkonto: palettenkonto),
                // fügen Sie hier die Widgets hinzu, die auf die Daten zugreifen
              ],
            );
          },
        )
      ],
    );
  }
}
