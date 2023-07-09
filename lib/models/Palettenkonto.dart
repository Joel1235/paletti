import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Palettenkonto extends ChangeNotifier {
  final String unternehmenId;
  int gesamtpaletten;
  int restpaletten;
  int europaletten;
  int industriepaletten;
  int chemiepaletten;

  Palettenkonto({
    required this.unternehmenId,
    required this.gesamtpaletten,
    required this.restpaletten,
    required this.europaletten,
    required this.industriepaletten,
    required this.chemiepaletten,
  });

  factory Palettenkonto.fromJson(Map<String, dynamic> json) {
    return Palettenkonto(
      unternehmenId: json['unternehmenId'],
      gesamtpaletten: json['gesamtpaletten'],
      restpaletten: json['restpaletten'],
      europaletten: json['europaletten'],
      industriepaletten: json['industriepaletten'],
      chemiepaletten: json['chemiepaletten'],
    );
  }

  factory Palettenkonto.fromSnapshot(DocumentSnapshot snapshot) {
    Map data = snapshot.data() as Map<String, dynamic>;
    return Palettenkonto(
      unternehmenId: data['unternehmenId'],
      gesamtpaletten: data['gesamtpaletten'],
      restpaletten: data['restpaletten'],
      europaletten: data['europaletten'],
      chemiepaletten: data['chemiepaletten'],
      industriepaletten: data['industriepaletten'],
    );
  }

  void updateValues(int chemiePal, int euroPal, int industriePal, int restPal) {
    this.chemiepaletten += chemiePal;
    this.europaletten += euroPal;
    this.industriepaletten += industriePal;
    this.restpaletten += restPal;
    this.gesamtpaletten =
        chemiepaletten + europaletten + industriepaletten + restpaletten;
  }

  Map<String, Object?> toJson() {
    return {
      'unternehmenId': unternehmenId,
      'gesamtpaletten': gesamtpaletten,
      'restpaletten': restpaletten,
      'europaletten': europaletten,
      'industriepaletten': industriepaletten,
      'chemiepaletten': chemiepaletten
    };
  }

  @override
  String toString() {
    return 'Palettenkonto{unternehmenId: $unternehmenId, gesamtpaletten: $gesamtpaletten, restpaletten: $restpaletten, europaletten: $europaletten, industriepaletten: $industriepaletten, chemiepaletten: $chemiepaletten}';
  }
}
