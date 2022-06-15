import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/pages/direcciones_page.dart';
import 'package:qr_reader/pages/mapas_page.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/widgets/custom_floating_button.dart';
import 'package:qr_reader/widgets/custom_navigator_bottom.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Historial'),
        centerTitle: true,
        actions: [
          Container(
              margin: const EdgeInsets.only(right: 16),
              child: IconButton(
                  icon: const Icon(Icons.delete_forever),
                  onPressed: () => scanListProvider.borrarTodosPorTipo())),
        ],
      ),
      body: const _HomePageBody(),
      bottomNavigationBar: const CustomNavigatorBottom(),
      floatingActionButton: const CustomFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtenemos el SelectedMenuOpt de UiProvider
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.getselectedMenuOpt;

    // Obtenemos el Provider de los Scans, Listen en False para que no se redibuje
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        scanListProvider.cargarScansPorTipo('geo');
        return const MapasPage();
      case 1:
        scanListProvider.cargarScansPorTipo('http');
        return const DireccionesPage();
      default:
        return const MapasPage();
    }
  }
}
