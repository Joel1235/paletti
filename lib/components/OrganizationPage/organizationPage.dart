// ignore_for_file: camel_case_types

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paletti_1/components/dashborad/dashboardContent.dart';
import 'package:paletti_1/models/Organization.dart';
import 'package:paletti_1/models/UserModel.dart';
import 'package:paletti_1/provider/palettenkonto.provider.dart';
import 'package:provider/provider.dart';
import '../../models/Palettenkonto.dart';
import '../../navBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prompt_dialog/prompt_dialog.dart';
import 'package:uuid/uuid.dart';

class OrganizationPage extends StatefulWidget {
  const OrganizationPage({super.key});

  @override
  _OrganizationPage createState() => _OrganizationPage();
}

class _OrganizationPage extends State<OrganizationPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final Stream<QuerySnapshot> _pallettenStream =
      FirebaseFirestore.instance.collection('Palettenkonto').snapshots();
  bool _isDrawerOpen = true; // Standardmäßig geöffnet in der Webansicht
  String orgaId = '';
  String? mail = FirebaseAuth.instance.currentUser?.email;
  UserModel? currUser;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('user')
        .doc(mail)
        .get()
        .then((DocumentSnapshot snap) {
      if (snap.exists) {
        currUser = UserModel.fromSnapshot(snap);
        setState(() {
          orgaId = currUser!.orgaId;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (orgaId == '') {
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
                child: Column(children: [
                  Text(
                    "Verwalte deine Organisation",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    child: const Text('Erstelle eine Organisation'),
                    onPressed: () async {
                      return print(await openOrgaDialog(context));
                    },
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    child: const Text('Organisation beitreten'),
                    onPressed: () async {
                      return print(await joinOrgaDialog(context));
                    },
                  ),
                ]),
              )
            ],
          ),
        ),
      );
    } else {
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
                child: Column(children: [
                  Text(
                    "\n Verwalte deine Organisation",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    "\n Andere User können deiner Organisation mit deiner OrganisationsId beitreten \n \n Organisation ID: $orgaId",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ]),
              )
            ],
          ),
        ),
      );
    }
  }

  Future<String?> openOrgaDialog(BuildContext context) {
    return prompt(
      context,
      title: const Text("Erstelle deine Organisation"),
      isSelectedInitialValue: false,
      textOK: const Text("Erstellen"),
      textCancel: const Text("Zurück"),
      hintText: 'Name deiner Organisation',
      validator: (String? value) {
        if (value == null || value.isEmpty) {
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
    //update Users OrgaId
    var uuid = Uuid();
    String orgaId = uuid.v1().toString();
    currUser!.orgaId = orgaId;
    FirebaseFirestore.instance
        .collection('user')
        .doc(mail)
        .update(currUser!.toJson())
        .catchError((error) => throw error);
    //create PalAccount
    FirebaseFirestore.instance
        .collection('palettenkonto$orgaId')
        .doc('account')
        .set({
      'chemiepaletten': 0,
      'europaletten': 0,
      'chemiePaletten': 0,
      'restpaletten': 0,
      'industriepaletten': 0,
      'gesamtpaletten': 0,
      'unternehmenId': orgaId,
    });
    setState(() {
      this.orgaId = orgaId;
    });

    //create Organization
    CollectionReference organizations =
        FirebaseFirestore.instance.collection('organizations');
    Organization organization = Organization(
        orgaId: orgaId,
        owner: FirebaseAuth.instance.currentUser!.email.toString(),
        name: value,
        userList: []);
    return organizations
        //.add(organization.toJson())
        .doc(orgaId)
        .set(organization.toJson())
        .then((value) => print("orga added"))
        .catchError((error) => print("Failed to add orga: $error"));
  }

  void createPalAccount() {}

  Future<String?> joinOrgaDialog(BuildContext context) {
    return prompt(context,
        title: const Text("Gebe die Id der gewünschten Organisation ein"),
        validator: (String? value) {
      if (value == null || value.isEmpty) {
        return 'Gebe einen gültigen Wert ein';
      } else {
        //first get the right User

        //then get the current organization
      }
    });
  }
}
