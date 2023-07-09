import 'package:flutter/material.dart';
import 'package:paletti_1/models/Palettenkonto.dart';
import 'package:provider/provider.dart';
import '../../provider/palettenkonto.provider.dart';
import '../../utils/constants.dart';
import '../../utils/responsive.dart';
import '../newEntry/newEntry.dart';
import 'fileInfoCard.dart';

class MyFiles extends StatelessWidget {
  const MyFiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Palettenkonto",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding * 1.5,
                  vertical:
                      defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                ),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => NewEntry())));
              },
              icon: Icon(Icons.add),
              label: Text("Eintrag hinzufügen"),
            ),
          ],
        ),
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: FileInfoCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
          ),
          tablet: FileInfoCardGridView(),
          desktop: FileInfoCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
          ),
        ),
      ],
    );
  }
}

class FileInfoCardGridView extends StatelessWidget {
  const FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    Palettenkonto? tmp = context.watch<PalettenkontoProvider>().palettenkonto;
    print(tmp);
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) {
        List<FileInfoCard> fileInfoCards = [
          FileInfoCard(
            amount: tmp!.europaletten,
            title: 'Europaletten',
            color: primaryColor,
            svgSrc: "assets/icons/Documents.svg",
            total: tmp.gesamtpaletten,
          ),
          FileInfoCard(
            amount: tmp!.chemiepaletten,
            title: 'Chemiepaletten',
            color: Color(0xFFA4CDFF),
            svgSrc: "assets/icons/one_drive.svg",
            total: tmp.gesamtpaletten,
          ),
          FileInfoCard(
            amount: tmp!.industriepaletten,
            title: 'Industriepaletten',
            color: Color(0xFFFFA113),
            svgSrc: "assets/icons/google_drive.svg",
            total: tmp.gesamtpaletten,
          ),
          FileInfoCard(
            amount: tmp!.restpaletten,
            title: 'Restpaletten',
            color: Color(0xFF007EE5),
            svgSrc: "assets/icons/drop_box.svg",
            total: tmp.gesamtpaletten,
          ),
        ];

        return fileInfoCards[index];
      },
    );
  }
}
