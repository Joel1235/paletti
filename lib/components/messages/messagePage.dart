// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:paletti_1/provider/palettenkonto.provider.dart';
import 'package:provider/provider.dart';
import '../../controllers/MenuAppController.dart';
import '../../models/Palettenkonto.dart';
import '../../navBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prompt_dialog/prompt_dialog.dart';


class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  _newEntry createState() => _newEntry();
}

class _newEntry extends State<MessagePage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final Stream<QuerySnapshot> _pallettenStream =
      FirebaseFirestore.instance.collection('Palettenkonto').snapshots();
  bool _isDrawerOpen = true; // Standardmäßig geöffnet in der Webansicht

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text('Dashboard'),
      ),*/
      //key: context.read<MenuAppController>().scaffoldKey,
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
              child: Column(
                children: [
                  Text("Nachrichten", style: Theme.of(context).textTheme.subtitle1,),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    child: const Text('Erstelle eine Organisation'),
                    onPressed: () async {
                      return print(await openOrgaDialog(context));
                    },
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    child: const Text('Teilnehmer hinzufügen'),
                    onPressed: () async {
                      return print(await openAddUserDialog(context));
                    },
                  ),
                ]
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<String?> openOrgaDialog(BuildContext context) {
    return prompt(
            context,
            title: const Text("Erstelle deine Organisation"),
            isSelectedInitialValue: false,
            textOK: const Text("Yes"),
            textCancel: const Text("No"),
            hintText: 'Name deiner Organisation',
            validator: (String? value) {
              if(value == null || value.isEmpty){
                return 'Gebe einen gültigen Namen ein';
              } else {
                createOrganization(value);
                createPalAccount();
                //maybe open another dialog here to invite users
              }
            },
            autoFocus: false,
            barrierDismissible: true,
            textCapitalization: TextCapitalization.words,
            textAlign: TextAlign.center,
            );
  }
  
  Future<void> createOrganization(String value) async {
    CollectionReference organizations = FirebaseFirestore.instance.collection('organizations');
    return organizations.add({
      'name': value,
    })
    .then((value) => print("orga added"))
    .catchError((error) => print("Failed to add orga: $error"));
  }

 
  void createPalAccount() {}
  
  Future<String?> openAddUserDialog(BuildContext context) {
    return prompt(
            context,
            title: const Text("Teilnehmer per ID hinzufügen"),
            );
  }

}
