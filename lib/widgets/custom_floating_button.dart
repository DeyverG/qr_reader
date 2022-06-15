import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/utils/utils.dart';

class CustomFloatingButton extends StatelessWidget {
  const CustomFloatingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: const Icon(Icons.qr_code_scanner_rounded),
      onPressed: () async {
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            "#ff6666", "Cancelar", false, ScanMode.QR);
        if(barcodeScanRes == '-1') return;
        // ignore: use_build_context_synchronously
        final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);
        final nuevo = await scanListProvider.nuevoScan(barcodeScanRes);

        // ignore: use_build_context_synchronously
        fnlaunchUrl(context, nuevo);
      },
    );
  }
}
