import 'package:flutter/cupertino.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:qr_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String tipoDeScan = 'http';

  Future<ScanModel> nuevoScan(String valor) async {
    //Creamos el modelo y le pasamos el valor que nos llega como parametro
    final nuevoScan = ScanModel(valor: valor);

    //Obtenemos el ID que nos da la DB luego de crear el registro
    final int id = await DBProvider.db.nuevoScan(nuevoScan);

    // Agregamos el ID al modelo ya creado
    nuevoScan.id = id;

    // Ahora lo agregamos al nuevo Array creado para actualizar la vista
    //Pero unicamente si el tipo de Scan es el mismo
    if (tipoDeScan == nuevoScan.tipo) {
      scans.add(nuevoScan);
      // Y notificamos a todos los que lo requieran
      notifyListeners();
    }
    return nuevoScan;
  }

  // Funcion para obtener todos los Scans
  cargarScans() async {
    final scans = await DBProvider.db.getScanAll();
    this.scans = [...scans!];
    notifyListeners();
  }

  // Funcion para obtener los Registros por Tipo
  cargarScansPorTipo(String tipo) async {
    final scans = await DBProvider.db.getScanByType(tipo);
    this.scans = [...scans!];
    tipoDeScan = tipo;
    notifyListeners();
  }

  borrarTodos() async {
    await DBProvider.db.deleteAllScans();
    scans = [];
    notifyListeners();
  }

  borrarTodosPorTipo() async {
    await DBProvider.db.deleteAllByType(tipoDeScan);
    scans = [];
    notifyListeners();
  }

  // Funcion para eliminar por ID, en este caso no se notifica porque se llama
  // La Funcion de CargarScanPorTipo y ya ella tiene su notificacion.
  borrarPorId(int id) async {
    await DBProvider.db.deleteScanById(id);
    cargarScansPorTipo(tipoDeScan);
  }
}
