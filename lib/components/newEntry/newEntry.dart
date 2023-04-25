// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/MenuAppController.dart';
import '../../navBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewEntry extends StatefulWidget {
  const NewEntry({super.key});

  @override
  _newEntry createState() => _newEntry();
}

class _newEntry extends State<NewEntry> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final Stream<QuerySnapshot> _pallettenStream =
      FirebaseFirestore.instance.collection('Palettenkonto').snapshots();
  bool _isDrawerOpen = true; // Standardmäßig geöffnet in der Webansicht

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return StreamBuilder<QuerySnapshot>(
      stream: _pallettenStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong' + snapshot.error.toString());
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        snapshot.data!.docs.forEach((doc) {
          print(doc.data());
        });
        /*return Row(
      children: [
        ListView(
          prototypeItem: const Text("loading succenssful"),
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                    //debugPrint('movieTitle: ' + snapshot.data!);

            return Column(
              children: [
                Text(data['EuroPaletten'].toString()),
                Text(data['UnternehmensId'].toString())
              ],
            );
            /*return ListTile(
              title: Text(data['EuroPaletten'].toString()),
              subtitle: Text(data['UnternehmensId'].toString()),
            );*/
          }).toList(),
        ),
      ],
    );*/
        return Text('data ist displayed in console');

        /*return ListView(
          prototypeItem: const Text("loading succenssful"),
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                    //debugPrint('movieTitle: ' + snapshot.data!);

            return ListTile(
              title: Text(data['EuroPaletten'].toString()),
              subtitle: Text(data['UnternehmensId'].toString()),
            );
          }).toList(),
        );*/
      },
    );
  }

  Future submitPallets() {
    throw UnimplementedError();
  }
}
