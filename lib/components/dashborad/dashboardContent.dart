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

  @override
  void initState() {
    super.initState();
    _stream = FirebaseFirestore.instance
        .collection('palettenkonto1')
        .snapshots() as Stream<QuerySnapshot<Map<String, dynamic>>>?;
    _getData();
  }

  void _getData() async {
    var _stream = FirebaseFirestore.instance
        .collection('palettenkonto1')
        .doc('account')
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        Palettenkonto palettenkonto = Palettenkonto.fromSnapshot(snapshot);
        context.read<PalettenkontoProvider>().setPalettenkonto(palettenkonto);
      } else {
        //TODO: handling if palettenkonto does not exist
        print("Palettenkonto does not exist");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _stream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return Row(
          children: [
            Expanded(
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
                            child: StorageDetails(),
                          ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
