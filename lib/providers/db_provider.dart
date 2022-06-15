import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class DBProvider {
  static Database? _database;

  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get getDatabase async {
    if (_database != null) return _database!;

    _database = await initDB();

    return _database!;
  }

  Future<Database> initDB() async {
    // Path de donde almacenaremos la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = p.join(documentsDirectory.path, 'ScanDB.db');

    // Crear la base de datos
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE Scans (
          id INTEGER PRIMARY KEY,
          tipo TEXT,
          valor TEXT
          )
          ''');
    });
  }

  // Insertar los datos de una manera
  Future<int> nuevoScanRaw(ScanModel scan) async {
    final id = scan.id;
    final tipo = scan.tipo;
    final valor = scan.valor;

    //Verificar la DB
    final db = await getDatabase;

    final response = await db.rawInsert('''
      INSERT INTO Scans (id, tipo, valor)
      VALUES ($id, '$tipo', '$valor')
    ''');

    return response;
  }

  // Insertar los datos de una manera mas corta
  Future<int> nuevoScan(ScanModel scan) async {
    //Verificar la DB
    if (scan.tipo != 'desconocido') {
      final db = await getDatabase;

      final response = await db.insert('Scans', scan.toJson());

      //Es el ID que se genera automaticamente
      return response;
    }
    return 0;
  }

  //Funcion para obtener un registro por el ID
  Future<ScanModel?> getScanById(int id) async {
    //Verificar la Base de Datos
    final db = await getDatabase;

    final response = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    return response.isNotEmpty ? ScanModel.fromJson(response.first) : null;
  }

  //Funcion para obtener todos los Registros
  Future<List<ScanModel>?> getScanAll() async {
    //Verificar la Base de Datos
    final db = await getDatabase;

    final response = await db.query('Scans');

    return response.isNotEmpty
        ? response.map((e) => ScanModel.fromJson(e)).toList()
        : [];
  }

  //Funcion para obtener Registros por el Tipo
  Future<List<ScanModel>?> getScanByType(String type) async {
    //Verificar la Base de Datos
    final db = await getDatabase;

    final response =
        await db.query('Scans', where: 'tipo = ?', whereArgs: [type]);

    return response.isNotEmpty
        ? response.map((e) => ScanModel.fromJson(e)).toList()
        : [];
  }

  //Funcion para Actualizar un Registro
  Future<int> updateScan(ScanModel scanUpdate) async {
    //Verificar la Base de Datos
    final db = await getDatabase;

    // Se le envia el scanUpdate para que todos los que esten y el ID concuerde sean actualizados
    final response = await db.update('Scans', scanUpdate.toJson(),
        where: 'id = ?', whereArgs: [scanUpdate.id]);

    return response;
  }

  // Funcion para eliminar un Registro por ID
  Future<int> deleteScanById(int id) async {
    //Verificar la Base de Datos
    final db = await getDatabase;

    final response = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);

    return response;
  }

  //Funcion para eliminar todos los Registros
  Future<int> deleteAllScans() async {
    //Verificar la DB
    final db = await getDatabase;

    final response = db.delete('Scans');

    //Envia la cantidad de Registros borrados
    return response;
  }

  //Funcion para eliminar todos los Registros
  Future<int> deleteAllByType(String tipo) async {
    //Verificar la DB
    final db = await getDatabase;

    final response = db.delete('Scans', where: 'tipo = ?', whereArgs: [tipo]);

    //Envia la cantidad de Registros borrados
    return response;
  }
}
