import 'package:flutter/material.dart';

import '../models/MyFiles.dart';
import '../models/Palettenkonto.dart';
import '../utils/constants.dart';

class PalettenkontoProvider extends ChangeNotifier {
  Palettenkonto? _palettenkonto;

  Palettenkonto? get palettenkonto => _palettenkonto;

  PalettenkontoProvider() {
    //_palettenkonto = palettenkonto;
  }

  void setPalettenkonto(Palettenkonto palettenkonto) {
    _palettenkonto = palettenkonto;
    notifyListeners();
  }

  List<CloudStorageInfo> getDataList() {
    List<CloudStorageInfo> demoMyFiles = [
      CloudStorageInfo(
        title: "Europaletten",
        numOfFiles: 1328,
        svgSrc: "assets/icons/Documents.svg",
        totalStorage: _palettenkonto?.europaletten.toString(),
        color: primaryColor,
        percentage: 35,
      ),
      CloudStorageInfo(
        title: "Industriepaletten",
        numOfFiles: 1328,
        svgSrc: "assets/icons/google_drive.svg",
        totalStorage: _palettenkonto?.industriepaletten.toString(),
        color: Color(0xFFFFA113),
        percentage: 35,
      ),
      CloudStorageInfo(
        title: "Chemiepaletten",
        numOfFiles: 1328,
        svgSrc: "assets/icons/one_drive.svg",
        totalStorage: _palettenkonto?.chemiepaletten.toString(),
        color: Color(0xFFA4CDFF),
        percentage: 10,
      ),
      CloudStorageInfo(
        title: "Restpaletten",
        numOfFiles: 5328,
        svgSrc: "assets/icons/drop_box.svg",
        totalStorage: _palettenkonto?.restpaletten.toString(),
        color: Color(0xFF007EE5),
        percentage: 78,
      ),
    ];
    return demoMyFiles;
  }
}
