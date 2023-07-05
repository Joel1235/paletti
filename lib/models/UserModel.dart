import 'package:cloud_firestore/cloud_firestore.dart';

enum Role { director, dispatcher, employee }


class UserModel {

  final String id;
  String? fullname;
  String mail;
  Role role;

  UserModel(
      {required this.id,
      required this.mail,
      required this.role,
      this.fullname});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      fullname: json['fullname'],
      mail: json['mail'],
      role: json['role'],
    );
  }

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map data = snapshot.data() as Map<String, dynamic>;
    return UserModel(id: data['id'], mail: data['mail'], role: data['role']);
  }

  Map<String, Object?> toJson() {
    return {'id': id, 'fullname': fullname, 'mail': mail, 'role': role.toString()};
  }
}
