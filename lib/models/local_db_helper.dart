import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rc_rtc_tolotanana/models/patient.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE Patient(id INTEGER PRIMARY KEY, year TEXT, nom TEXT, prenoms TEXT, age INTEGER, genre TEXT, typeOperation TEXT, anesthesie TEXT, telephone TEXT, observation TEXT, commentaire TEXT, adresse TEXT, dateNaissance TEXT)");
  }

  Future<int> savePatient(Patient patient) async {
    var dbClient = await db;
    int res = await dbClient.insert("Patient", patient.toMap());
    return res;
  }

  Future<List<Patient>> getPatients() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM Patient');
    List<Patient> patients = [];

    for (var patient in list) {
      patients.add(Patient(
          id: patient['id'],
          year: patient['year'],
          lastname: patient['lastname'],
          firstname: patient['firstname'],
          age: patient['age'],
          sex: patient['sex'],
          operationType: patient['operationType'],
          anesthesiaType: patient['anesthesiaType'],
          telephone: patient['telephone'],
          observation: patient['observation'],
          comment: patient['comment'],
          address: patient['address'],
          birthDate: DateTime.parse(patient['birthDate'])));
    }
    return patients;
  }

  Future<int> updatePatient(Patient patient) async {
    var dbClient = await db;
    return await dbClient.update(
      'Patient',
      patient.toMap(),
      where: 'id = ?',
      whereArgs: [patient.id],
    );
  }

  Future<int> deletePatient(int id) async {
    var dbClient = await db;
    return await dbClient.delete(
      'Patient',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Future<List<Patient>> getPatients() async {
  //   var dbClient = await db;
  //   List<Map> maps = await dbClient.query('Patient', orderBy: 'id');
  //   return maps.map((map) => Patient.fromMap(map)).toList();
  // }
}
