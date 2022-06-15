import 'package:flutter/material.dart';
import 'package:qr_reader/widgets/listview_register.dart';

class DireccionesPage extends StatelessWidget {
  const DireccionesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: ListViewRegister(icon: Icons.home_outlined),
    );
  }
}
