import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:paletti_1/models/Palettenkonto.dart';
import 'package:paletti_1/provider/palettenkonto.provider.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';

class Chart extends StatelessWidget {
  const Chart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // = the circular display on the right side of dashboard
    final temp = context.watch<PalettenkontoProvider>().palettenkonto;
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 70,
              startDegreeOffset: -90,
              sections: getSections(temp),
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: defaultPadding),
                Text(
                  temp!.gesamtpaletten.toString(),
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        height: 0.5,
                      ),
                ),
                Text(temp!.gesamtpaletten.toString())
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> getSections(Palettenkonto? pK) {
    //Sections for each Palettentype
    List<PieChartSectionData> pC = [
      PieChartSectionData(
        color: primaryColor,
        value: pK?.europaletten.toDouble(),
        showTitle: false,
        radius: 20,
      ),
      PieChartSectionData(
        color: Color(0xFFFFCF26),
        value: pK?.industriepaletten.toDouble(),
        showTitle: false,
        radius: 20,
      ),
      PieChartSectionData(
        color: Color(0xFF26E5FF),
        value: pK?.chemiepaletten.toDouble(),
        showTitle: false,
        radius: 20,
      ),
      PieChartSectionData(
        color: Color(0xFFEE2727),
        value: pK?.restpaletten.toDouble(),
        showTitle: false,
        radius: 20,
      ),
    ];

    return pC;
  }
}
