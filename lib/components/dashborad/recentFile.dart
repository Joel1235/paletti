import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/PalEntry.dart';
import '../../utils/constants.dart';

class RecentFiles extends StatefulWidget {
  @override
  _RecentFiles createState() => _RecentFiles();
}

class _RecentFiles extends State<RecentFiles> {
  @override
  void initState() {
    super.initState();
  }

  final Stream<QuerySnapshot> _entryStream =
      FirebaseFirestore.instance.collection('palettenkonto1').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _entryStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          List<PalEntry> pallist = [];
          PalEntry palEntry;
          snapshot.data!.docs.forEach((document) => {
                if (document.id != 'account')
                  {
                    palEntry = PalEntry.fromSnapshot(document),
                    pallist.add(palEntry)
                  },
              });

          return Container(
            padding: EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recent Changes",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(
                  width: double.infinity,
                  child: DataTable(
                    columnSpacing: defaultPadding,
                    showCheckboxColumn: false,
                    //minWidth: 600,
                    columns: [
                      DataColumn(
                        label: Text("User"),
                      ),
                      DataColumn(
                        label: Text("Date"),
                      ),
                      DataColumn(
                        label: Text("Change"),
                      ),
                    ],
                    rows: List.generate(
                      pallist.length,
                      (index) => recentFileDataRow(pallist[index], context),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<List<PalEntry>> getRecentChanges() {
    /*_stream =
        FirebaseFirestore.instance.collection('palettenkonto1').snapshots();

    DatabaseReference ref = FirebaseDatabase.instance.ref();*/
    throw new UnimplementedError();
  }
}

DataRow recentFileDataRow(PalEntry palEntry, BuildContext context) {
  var amount = palEntry.gesamtPal.abs();
  return DataRow(
    onSelectChanged: (newValue) {
      print("selected $palEntry");
      detailsDialog(context, palEntry);
    },
    cells: [
      DataCell(
        Row(
          children: [
            CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTC-9Xm5dvI6hqtVo9MDNjTBfVxgJgCULLTbmJ9pUaCcN7nV5O_CKIJrSeXgdXjLo_GgjI&usqp=CAU',
                  width: 30,
                  height: 30,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(palEntry.userMail),
            ),
          ],
        ),
      ),
      DataCell(Text(palEntry.date)),
      palEntry.gesamtPal < 0
          ? DataCell(Text("- $amount"))
          : DataCell(Text("+ $amount")),
    ],
  );
}

void detailsDialog(BuildContext context, PalEntry palEntry) {
 showDialog(
  context: context,
  builder: (BuildContext context) {
    return SimpleDialog(
      title: Text("Details zum Eintrag"),
      children: [
        //weitere Widgets
        ListTile(title: Text("Erstellt von: \t ${palEntry.userMail}"),),
        ListTile(title: Text("Erstellt am: \t ${palEntry.date}"),),
        ListTile(title: Text("Änderung Europaletten:  \t ${palEntry.euroPal}"),),
        ListTile(title: Text("Änderung Industriepaletten:  \t ${palEntry.industriePal}"),),
        ListTile(title: Text("Änderung Chemiepaletten:  \t ${palEntry.chemiePal}"),),
        ListTile(title: Text("Änderung Restpaletten:  \t ${palEntry.restPal}"),),
        ListTile(title: Text("Gesamtänderung:  \t ${palEntry.gesamtPal}"),),
      ],
    );
  });
   
}
