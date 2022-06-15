import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/ui_provider.dart';

class CustomNavigatorBottom extends StatelessWidget {
  const CustomNavigatorBottom({Key? key}) : super(key: key);

  final currentIndex = 0;
  @override
  Widget build(BuildContext context) {
// Obtenemos el SelectedMenuOpt de UiProvider
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.getselectedMenuOpt;

    return BottomNavigationBar(
        onTap: (int index) => uiProvider.setselectedMenuOpt = index,
        elevation: 0,
        currentIndex: currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Mapa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.compass_calibration),
            label: 'Direcciones',
          ),
        ]);
  }
}
