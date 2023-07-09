import 'package:cloud_firestore/cloud_firestore.dart';

enum Role { director, dispatcher, employee }

class UserModel {
  final String id;
  String orgaId;
  String? fullname;
  String mail;
  Role role;

  UserModel(
      {required this.id,
      required this.mail,
      required this.role,
      required this.orgaId,
      this.fullname});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        fullname: json['fullname'],
        mail: json['mail'],
        role: json['role'],
        orgaId: json['orgaId']);
  }

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map data = snapshot.data() as Map<String, dynamic>;
    return UserModel(
        id: data['id'],
        mail: data['mail'],
        role: getRole(data['role']),
        orgaId: data['orgaId']);
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'fullname': fullname,
      'mail': mail,
      'role': role.toString(),
      'orgaId': orgaId,
    };
  }

  static Role getRole(data) {
    if (data == 'Role.employee') {
      return Role.employee;
    } else if (data == 'Role.dispatcher') {
      return Role.dispatcher;
    } else {
      return Role.director;
    }
  }
}
