import 'package:cloud_firestore/cloud_firestore.dart';

class Palettenkonto {
  final String unternehmenId;
  final int gesamtpaletten;
  final int restpaletten;
  final int europaletten;
  final int industriepaletten;
  final int chemiepaletten;

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

  // Map<Palettenkonto, dynamic> toJson() {
  //   return {
  //     unternehmenId: 'unternehmenId',
  //     'gesamtpaletten': gesamtpaletten,
  //     'restpaletten': restpaletten,
  //     'europaletten': europaletten,
  //     'industiepaletten': industriepaletten,
  //     'chmiepaletten': chemiepaletten,
  //   };
  // }

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

  @override
  String toString() {
    return 'Palettenkonto{unternehmenId: $unternehmenId, gesamtpaletten: $gesamtpaletten, restpaletten: $restpaletten, europaletten: $europaletten, industriepaletten: $industriepaletten, chemiepaletten: $chemiepaletten}';
  }
}
