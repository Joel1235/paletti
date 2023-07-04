import 'package:cloud_firestore/cloud_firestore.dart';

class PalEntry {
  final String id;
  int gesamtPal;
  int restPal;
  int euroPal;
  int industriePal;
  int chemiePal;
  String userMail;
  String location;
  String date;

  PalEntry(
      {required this.id,
      required this.chemiePal,
      required this.euroPal,
      required this.gesamtPal,
      required this.industriePal,
      required this.restPal,
      required this.location,
      required this.userMail,
      required this.date});

  factory PalEntry.fromJson(Map<String, dynamic> json) {
    return PalEntry(
        id: json['id'],
        chemiePal: json['chemiePal'],
        euroPal: json['euroPal'],
        gesamtPal: json['gesamtPal'],
        industriePal: json['industriePal'],
        restPal: json['restPal'],
        location: json['location'],
        userMail: json['userMail'],
        date: json['date']);
  }

  factory PalEntry.fromSnapshot(DocumentSnapshot snapshot) {
    Map data = snapshot.data() as Map<String, dynamic>;
    return PalEntry(
        id: data['id'],
        chemiePal: data['chemiePal'],
        euroPal: data['euroPal'],
        gesamtPal: data['gesamtPal'],
        industriePal: data['industriePal'],
        restPal: data['restPal'],
        location: data['location'],
        userMail: data['userMail'],
        date: data['date']);
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'chemiePal': chemiePal,
      'euroPal': euroPal,
      'gesamtPal': gesamtPal,
      'industriePal': industriePal,
      'restPal': restPal,
      'location': location,
      'userMail': userMail,
      'date': date,
    };
  }

  @override
  String toString() {
    return 'PalEntry{id: $id, gesamtpaletten: $gesamtPal, restpaletten: $restPal, europaletten: $euroPal, industriepaletten: $industriePal, chemiepaletten: $chemiePal, userMail: $userMail, location: $location, date: $date}';
  }
}
