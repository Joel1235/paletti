// ignore_for_file: camel_case_types

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paletti_1/models/PalEntry.dart';
import 'package:paletti_1/provider/palettenkonto.provider.dart';
import 'package:provider/provider.dart';
import '../../controllers/MenuAppController.dart';
import '../../models/Palettenkonto.dart';
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

  int chemiePal = 0;
  int euroPal = 0;
  int gesamtPal = 0;
  int industriePal = 0;
  int restPal = 0;
  String imagePath = '';
  String location = '';

  Widget build(BuildContext context) {
    return Consumer<PalettenkontoProvider>(
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
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Funktion zum Hochladen des Bildes implementieren
                },
                child: Text('Bild hochladen'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Funktion zum Festlegen des Standorts implementieren
                },
                child: Text('Standort festlegen'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Funktion zum Bestätigen der Eingabe implementieren
                  submitPallets(chemiePal, euroPal, industriePal, restPal,
                      palKonto.palettenkonto);
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      );
    }));
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
    PalEntry palEntry = PalEntry(
      id: '1',
      chemiePal: chemie,
      euroPal: euro,
      gesamtPal: 100,
      industriePal: industrie,
      restPal: rest,
      location: 'location',
      userMail: '$email',
    );
    plaKonto1
        .add(palEntry.toJson())
        .then((value) => print("Created Entry"))
        .catchError((error) => print("Failed to create Entry"));
  }
}
