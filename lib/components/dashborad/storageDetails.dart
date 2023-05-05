import 'package:flutter/material.dart';
import 'package:paletti_1/components/dashborad/storageInfoCard.dart';
import 'package:paletti_1/models/Palettenkonto.dart';
import 'package:provider/provider.dart';
import '../../provider/palettenkonto.provider.dart';
import '../../utils/constants.dart';
import 'chart.dart';

class StorageDetails extends StatelessWidget {

  const StorageDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('------------');
    print(context.read<PalettenkontoProvider>().palettenkonto?.europaletten);
    final palettenkontoProvider = Provider.of<PalettenkontoProvider>(context);
    final palettenkonto = palettenkontoProvider.palettenkonto;
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
            "Storage Details",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
          Chart(),
          StorageInfoCard(
            svgSrc: "icons/Documents.svg",
            title: "Europaletten",
            amount: palettenkonto?.europaletten,
          ),
          StorageInfoCard(
            svgSrc: "icons/media.svg",
            title: "Industriepaletten",
            amount: palettenkonto?.industriepaletten,
          ),
          StorageInfoCard(
            svgSrc: "icons/folder.svg",
            title: "Chemiepaletten",
            amount: palettenkonto?.chemiepaletten,
          ),
          StorageInfoCard(
            svgSrc: "icons/unknown.svg",
            title: "Restpaletten",
            amount: palettenkonto?.restpaletten,
          ),
        ],
      ),
    );
  }
}
