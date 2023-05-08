import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:paletti_1/utils/responsive.dart';
import 'package:provider/provider.dart';
import '../../models/Palettenkonto.dart';
import '../../provider/palettenkonto.provider.dart';
import '../../utils/constants.dart';
import 'header.dart';
import 'myFields.dart';
import 'recentFile.dart';
import 'storageDetails.dart';

class DashoardContent extends StatefulWidget {
  @override
  _DashboardContetnState createState() => _DashboardContetnState();
}

class _DashboardContetnState extends State<DashoardContent> {
  Stream<QuerySnapshot<Map<String, dynamic>>>? _stream;
  late Palettenkonto palettenkonto;
 PalettenkontoProvider _palettenkontoProvider = new PalettenkontoProvider();

  @override
  void initState() {
    super.initState();
    _stream = FirebaseFirestore.instance
        .collection('palettenkonto1')
        .snapshots() as Stream<QuerySnapshot<Map<String, dynamic>>>?;
    //_palettenkontoProvider.setPalettenkonto(_getData());
    _getData().then((value) => {
      //_palettenkontoProvider.setPalettenkonto(value),
      context.read<PalettenkontoProvider>().setPalettenkonto(value),
      this.palettenkonto = value
      //print('HEEEERE VALUE $value')
      });

    
    // _stream?.listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
    //   List<DocumentSnapshot<Map<String, dynamic>>> documents = snapshot.docs;
    //   Palettenkonto palettenkonto = Palettenkonto.fromSnapshot(documents[0]);
    //   _palettenkontoProvider.setPalettenkonto(palettenkonto);
    // });
  }

  Future<Palettenkonto> _getData() async {
    // Hier holen Sie die Daten von Firebase
    _stream = FirebaseFirestore.instance
        .collection('palettenkonto1')
        .snapshots();
    QuerySnapshot<Map<String, dynamic>>? snapshot = await _stream?.first;
    //var _documents = snapshot?.docs;
    // Hier können Sie die Daten verwenden
    //print(_documents);
     List<DocumentSnapshot<Map<String, dynamic>>> documents =
                   snapshot?.docs as List<DocumentSnapshot<Map<String, dynamic>>>;
      Palettenkonto palettenkonto = Palettenkonto.fromSnapshot(documents[0]);
      context.read<PalettenkontoProvider>().setPalettenkonto(palettenkonto);
      print(context.read<PalettenkontoProvider>().palettenkonto?.europaletten);
    return palettenkonto;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PalettenkontoProvider>(
    create: (context) => PalettenkontoProvider(),
    //return SafeArea(
      child: Column(
        children: [
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: _stream,
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              List<DocumentSnapshot<Map<String, dynamic>>> documents =
                  snapshot.data!.docs;
              Palettenkonto palettenkonto =
                  Palettenkonto.fromSnapshot(documents[0]);
              //_palettenkontoProvider.setPalettenkonto(documents[0])
              _getData().then((value) => {
      //_palettenkontoProvider.setPalettenkonto(value),
      context.read<PalettenkontoProvider>().setPalettenkonto(value),
      this.palettenkonto = value
      //print('HEEEERE VALUE $value')
      });

              //var palettenKonto2 =
                //Provider.of<PalettenkontoProvider>(context).setPalettenkonto(palettenkonto);
              //context.read<PalettenkontoProvider>().setPalettenkonto(palettenkonto);
              //print(context.read<PalettenkontoProvider>().palettenkonto.toString());
              //print('\n \n look above');
              //rint('Konto from provider: ' + palettenKonto2.toString());
              //print('Konto \n ' + palettenkonto.toString());
              //print('runtype ' + palettenkonto.runtimeType.toString());
              // hier können Sie die Daten verwenden
              return Expanded(
                child: SingleChildScrollView(
                  primary: false,
                  padding: EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [
                      Header(),
                      SizedBox(height: defaultPadding),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Column(
                              children: [
                                MyFiles(),
                                SizedBox(height: defaultPadding),
                                RecentFiles(),
                                if (Responsive.isMobile(context))
                                  SizedBox(height: defaultPadding),
                                if (Responsive.isMobile(context))
                                  StorageDetails(),
                              ],
                            ),
                          ),
                          if (!Responsive.isMobile(context))
                            SizedBox(width: defaultPadding),
                          // On Mobile means if the screen is less than 850 we dont want to show it
                          if (!Responsive.isMobile(context))
                            Expanded(
                              flex: 2,
                              child:
                                  StorageDetails(),
                            ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
