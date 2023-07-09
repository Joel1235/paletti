// ignore_for_file: camel_case_types

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paletti_1/models/PalEntry.dart';
import 'package:paletti_1/provider/palettenkonto.provider.dart';
import 'package:provider/provider.dart';
import '../../models/Palettenkonto.dart';
import '../../navBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class NewEntry extends StatefulWidget {
  const NewEntry({super.key});

  @override
  _newEntry createState() => _newEntry();
}

class _newEntry extends State<NewEntry> {
  //FirebaseFirestore firestore = FirebaseFirestore.instance;
  PlatformFile? pickedFile;

  int chemiePal = 0;
  int euroPal = 0;
  int gesamtPal = 0;
  int industriePal = 0;
  int restPal = 0;
  String imagePath = '';
  String location = '';

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(child: NavBar()),
          Expanded(
            flex: 5,
            child: Consumer<PalettenkontoProvider>(
                builder: ((context, palKonto, child) {
              return Scaffold(
                appBar: AppBar(
                  title: Text('Eingabeseite'),
                ),
                body: SingleChildScrollView(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            chemiePal = int.parse(value);
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Chemiepaletten',
                        ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^-?\d{0,9}')),
                        ], // Only numbers can be entered
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            euroPal = int.parse(value);
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Europaletten',
                        ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^-?\d{0,9}'))
                        ],
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            gesamtPal = int.parse(value);
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Industriepaletten',
                        ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^-?\d{0,9}'))
                        ],
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            industriePal = int.parse(value);
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Restpaletten',
                        ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^-?\d{0,9}'))
                        ],
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            industriePal = int.parse(value);
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Standort',
                        ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^-?\d{0,9}'))
                        ],
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          selectFile();
                        },
                        child: Text('Bild hochladen'),
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          submitPallets(chemiePal, euroPal, industriePal,
                              restPal, palKonto.palettenkonto);
                        },
                        child: Text('Einreichen'),
                      ),
                    ],
                  ),
                ),
              );
            })),
          ),
        ]),
      ),
    );
  }

  void submitPallets(int chemie, int euro, int industrie, int rest,
      Palettenkonto? curPalKonto) {
    curPalKonto?.updateValues(chemiePal, euroPal, industriePal, restPal);
    //update PalKonto
    final plaKonto1 = FirebaseFirestore.instance.collection("palettenkonto1");
    plaKonto1
        .doc('account')
        .update(curPalKonto!.toJson())
        .then((value) => print("Konto updated"))
        .catchError((error) => print("Failed to update Konto: $error"));
    //create List Entry
    var email = FirebaseAuth.instance.currentUser?.email;
    DateTime now = new DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    PalEntry palEntry = PalEntry(
      id: '1',
      chemiePal: chemie,
      euroPal: euro,
      gesamtPal: euro + chemie + industrie + rest,
      industriePal: industrie,
      restPal: rest,
      location: 'notImplemented',
      userMail: '$email',
      date: formatter.format(now).toString(),
    );
    plaKonto1
        .add(palEntry.toJson())
        .then((value) => print("Created Entry"))
        .catchError((error) => print("Failed to create Entry"));
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
  }
}
