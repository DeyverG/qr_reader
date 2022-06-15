import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/utils/utils.dart';

import '../providers/scan_list_provider.dart';

class ListViewRegister extends StatelessWidget {
  const ListViewRegister({Key? key, required this.icon}) : super(key: key);

  final IconData icon;
  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;
    return ListView.builder(
        itemCount: scans.length,
        itemBuilder: (_, i) => Dismissible(
              key: UniqueKey(),
              background: Container(
                color: Colors.red[400],
              ),
              onDismissed: (_) => {scanListProvider.borrarPorId(scans[i].id!)},
              child: ListTile(
                leading: Icon(
                  icon,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text(scans[i].valor),
                subtitle: Text(scans[i].id.toString()),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
                onTap: () => fnlaunchUrl(context, scans[i]),
              ),
            ));
  }
}
