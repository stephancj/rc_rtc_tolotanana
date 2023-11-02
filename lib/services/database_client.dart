import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rc_rtc_tolotanana/models/operation.dart';
import 'package:rc_rtc_tolotanana/models/patient.dart';
import 'package:sqflite/sqflite.dart';

import '../models/edition.dart';

class DatabaseClient {
  //2 tables
  //1. liste de souhaits table. ex: liste informatique, liste de cadeaux (nom, id)
  //2. liste de souhaits items table. ex: ps5, clavier (nom, prix, magasin, image, id de la liste, id de l'item)
  //INTEGER, TEXT, REAL
  //INTEGER PRIMARY KEY pour id unique
  //TEXT NOT NULL

  // acceder a la DB
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return database;
    } else {
      return await createDatabase();
    }
  }

  Future<Database> createDatabase() async {
    //recuperer les dossiers dans l'application
    Directory directory = await getApplicationDocumentsDirectory();
    //Creer un chemin pour la DB
    final path = join(directory.path, "tolotanana.db");
    return await openDatabase(path, version: 1, onCreate: onCreate);
  }

  onCreate(Database database, int version) async {
    await database.execute('''
        CREATE TABLE edition (
          id INTEGER PRIMARY KEY,
          year INTEGER NOT NULL,
          city TEXT NOT NULL
        )
      ''');
    await database.execute('''
        CREATE TABLE patient (
          id INTEGER PRIMARY KEY,
          lastName TEXT NOT NULL,
          firstName TEXT NOT NULL,
          age INTEGER NOT NULL,
          sex INTEGER NOT NULL,
          anesthesiaType TEXT NOT NULL,
          telephone TEXT NOT NULL,
          observation INTEGER NOT NULL,
          comment TEXT,
          address TEXT,
          birthDate TEXT NOT NULL,
          edition INTEGER,
          FOREIGN KEY(edition) REFERENCES edition(id)
        )
      ''');
    await database.execute('''
        CREATE TABLE operation (
          id INTEGER PRIMARY KEY,
          name TEXT NOT NULL
        )
      ''');
    await database.execute('''
        CREATE TABLE patient_operation (
          id INTEGER PRIMARY KEY,
          patient INTEGER,
          operation INTEGER,
          FOREIGN KEY(patient) REFERENCES patient(id),
          FOREIGN KEY(operation) REFERENCES operation(id)
        )
      ''');
    //insert each operationType in the table operation
    for (var operation in OperationType.values) {
      await database.rawInsert(
          'INSERT INTO operation (name) VALUES (?)', [operation.toString()]);
    }
  }

  //list of all operations
  Future<List<Operation>> allOperations() async {
    List<Operation> operations = [];
    //recuperer le DB
    Database db = await database;
    //faire une query ou demande
    const query = 'SELECT * FROM operation';
    //recuperer les resultats
    List<Map<String, dynamic>> results = await db.rawQuery(query);
    //List<Map<String, dynamic>> results = await db.query("list");

    for (var map in results) {
      operations.add(Operation.fromMap(map));
    }
    //ou return results.map((map) => WishList.fromMap(map)).toList();
    return operations;
  }

  //Obtenir données
  Future<List<Edition>> allEditions() async {
    List<Edition> lists = [];
    //recuperer le DB
    Database db = await database;
    //faire une query ou demande
    const query = 'SELECT * FROM edition ORDER BY year DESC';
    //recuperer les resultats
    List<Map<String, dynamic>> results = await db.rawQuery(query);
    //List<Map<String, dynamic>> results = await db.query("list");

    for (var map in results) {
      lists.add(Edition.fromMap(map));
    }
    //ou return results.map((map) => WishList.fromMap(map)).toList();
    return lists;
  }

  //Ajouter données
  Future<bool> addEdition(int year, String city) async {
    //recuperer le DB
    Database db = await database;
    // inserer dans la DB
    await db.insert("edition", {"year": year, "city": city});
    //notifier le changement terminé
    return true;
  }

  //Upsert patient
  Future<bool> upsert(Patient patient) async {
    //recuperer le DB
    Database db = await database;
    if (patient.id == null) {
      patient.id = await db.insert('patient', patient.toMap());
    } else {
      await db.update('patient', patient.toMap(),
          where: 'id = ?', whereArgs: [patient.id]);
    }
    return true;
  }

  //supprimer wishlist
  Future<bool> deleteEdition(Edition edition) async {
    //recuperer le DB
    Database db = await database;
    //supprimer dans la DB
    await db.delete("edition", where: "id = ?", whereArgs: [edition.id]);
    //supprimer aussi les items de la liste
    await db.delete("patient", where: "edition = ?", whereArgs: [edition.id]);
    //notifier le changement terminé
    return true;
  }

  //Obtenir les items
  Future<List<Patient>> patientFromEdition(int id) async {
    //recuperer le DB
    Database db = await database;

    List<Map<String, dynamic>> results =
        await db.query("patient", where: "edition = ?", whereArgs: [id]);

    // ou const query = 'SELECT * FROM item WHERE list = ?';
    // List<Map<String, dynamic>> results = await db.rawQuery(query, [id]);

    return results.map((map) => Patient.fromMap(map)).toList();
  }

  //get patient id from lastname
  Future<int> getPatientId(String lastname) async {
    //recuperer le DB
    Database db = await database;
    //faire une query ou demande
    const query = 'SELECT id FROM patient WHERE lastName = ?';
    //recuperer les resultats
    List<Map<String, dynamic>> results = await db.rawQuery(query, [lastname]);
    //List<Map<String, dynamic>> results = await db.query("list");

    return results[0]['id'];
  }

  //add patient_operation
  Future<bool> addPatientOperation(int patientId, int operationId) async {
    //recuperer le DB
    Database db = await database;
    // inserer dans la DB
    await db.insert(
        "patient_operation", {"patient": patientId, "operation": operationId});
    //notifier le changement terminé
    return true;
  }

  //get operation id from name
  Future<int> getOperationId(String name) async {
    //recuperer le DB
    Database db = await database;
    //faire une query ou demande
    const query = 'SELECT id FROM operation WHERE name = ?';
    //recuperer les resultats
    List<Map<String, dynamic>> results = await db.rawQuery(query, [name]);
    //List<Map<String, dynamic>> results = await db.query("list");

    return results[0]['id'];
  }
}
