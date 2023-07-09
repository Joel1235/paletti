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

List<PieChartSectionData> paiChartSelectionDatas = [
  PieChartSectionData(
    color: primaryColor,
    value: 25,
    showTitle: false,
    radius: 25,
  ),
  PieChartSectionData(
    color: Color(0xFF26E5FF),
    value: 20,
    showTitle: false,
    radius: 22,
  ),
  PieChartSectionData(
    color: Color(0xFFFFCF26),
    value: 10,
    showTitle: false,
    radius: 19,
  ),
  PieChartSectionData(
    color: Color(0xFFEE2727),
    value: 15,
    showTitle: false,
    radius: 16,
  ),
  PieChartSectionData(
    color: primaryColor.withOpacity(0.1),
    value: 25,
    showTitle: false,
    radius: 13,
  ),
];
