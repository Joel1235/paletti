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

  PalEntry({
    required this.id,
    required this.chemiePal,
    required this.euroPal,
    required this.gesamtPal,
    required this.industriePal,
    required this.restPal,
    required this.location,
    required this.userMail,
  });

  factory PalEntry.fromJson(Map<String, dynamic> json){
    return PalEntry(
      id: json['entryId'], 
      chemiePal: json['chemiePal'], 
      euroPal: json['euroPal'], 
      gesamtPal: json['gesamtPal'], 
      industriePal: json['industriePal'], 
      restPal: json['restPal'],
      location: json['location'],
      userMail: json['userMail'],
      );
  }

  factory PalEntry.fromSnapshot(DocumentSnapshot snapshot){
    Map data = snapshot.data() as Map<String, dynamic>;
    return PalEntry(
      id: data['entryId'], 
      chemiePal: data['chemiePal'], 
      euroPal: data['euroPal'], 
      gesamtPal: data['gesamtPal'], 
      industriePal: data['industriePal'], 
      restPal: data['restPal'],
      location: data['location'],
      userMail: data['userMail'],
      );
  }

  Map<String, Object?> toJson(){
    return {
      'id': id,
      'chemiePal': chemiePal,
      'euroPal': euroPal,
      'gesamtPal': gesamtPal,
      'industriePal': industriePal,
      'restPal': restPal,
      'location': location,
      'userMail': userMail,
    };
  }
}