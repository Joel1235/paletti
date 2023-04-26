import 'package:flutter/material.dart';

import '../models/Palettenkonto.dart';

class PalettenkontoProvider extends ChangeNotifier {
  Palettenkonto? _palettenkonto;

  Palettenkonto? get palettenkonto => _palettenkonto;

  PalettenkontoProvider(this._palettenkonto) {
    _palettenkonto = palettenkonto;
  }

  void setPalettenkonto(Palettenkonto palettenkonto) {
    _palettenkonto = palettenkonto;
    notifyListeners();
  }
}
