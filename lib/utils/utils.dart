import 'package:flutter/cupertino.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

void fnlaunchUrl(BuildContext context, ScanModel scan) async {

  if (scan.tipo == "http") {
    final Uri valorParse = Uri.parse(scan.valor);
    if (!await launchUrl(valorParse)) throw 'Could not launch ${scan.valor}';
  } else {
    if (scan.tipo == "geo") {
      Navigator.pushNamed(context, 'mapa', arguments: scan);
    }
  }
}
