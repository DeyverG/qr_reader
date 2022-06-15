

import 'package:flutter/material.dart';

// Extiende de ChangeNotifier para que se pueda notificar de cambios
class UiProvider extends ChangeNotifier {
  int _selectedMenuOpt = 0;

  int get getselectedMenuOpt {
    return _selectedMenuOpt;
  }

  set setselectedMenuOpt(int value) {
    _selectedMenuOpt = value;
    //Notifica al resto de la aplicación que se ha cambiado el valor
    notifyListeners();
  }
}
