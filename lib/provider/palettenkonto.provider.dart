import 'package:flutter/material.dart';

import '../models/Palettenkonto.dart';

class PalettenkontoProvider extends ChangeNotifier {
  Palettenkonto? _palettenkonto;

  Palettenkonto? get palettenkonto => _palettenkonto;

  void setPalettenkonto(Palettenkonto palettenkonto) {
    _palettenkonto = palettenkonto;
    notifyListeners();
  }
}
