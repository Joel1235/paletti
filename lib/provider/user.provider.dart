import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:paletti_1/models/UserModel.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _userModel;

  UserModel? get userModel => _userModel;

  UserProvider() {
    String? mail = FirebaseAuth.instance.currentUser?.email;

    FirebaseFirestore.instance
        .collection('user')
        .doc(mail)
        .get()
        .then((DocumentSnapshot snap) {
      if (snap.exists) {
        _userModel = UserModel.fromSnapshot(snap);
      }
    });
  }

  void setUser(UserModel uM) {
    _userModel = uM;
    notifyListeners();
  }
}
