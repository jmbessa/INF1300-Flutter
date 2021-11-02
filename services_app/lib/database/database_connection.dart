import 'package:flutter/cupertino.dart';
import 'package:services_app/workers.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class WorkersDatabase {
  static final WorkersDatabase instance = WorkersDatabase._init();

  static Database? _database;

  WorkersDatabase._init();

  WorkersDatabase();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('workersA.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final stringType = 'VARCHAR(40) NULL';
    final decimalType = 'DECIMAL(5, 2) NULL';
    final descriptionType = 'VARCHAR(500) NULL';


    print("OI");
    await db.execute('''
    CREATE TABLE $tableWorkers (
      ${WorkersFields.id} $idType,
      ${WorkersFields.name} $stringType,
      ${WorkersFields.price} $decimalType,
      ${WorkersFields.turn} $descriptionType,
      ${WorkersFields.description} $descriptionType,
      ${WorkersFields.evaluation} $decimalType,
      ${WorkersFields.category} $descriptionType,
      ${WorkersFields.previousEvaluations} $decimalType,
      ${WorkersFields.previousWorks} $stringType
    )
    ''');
  }

  Future<Worker> create(Worker worker) async {
    final db = await instance.database;
    print("123ADOU");
    final id = await db.insert(tableWorkers, worker.toMap());
    print("356ADOU");
    return worker.copy(id: id, name: '');
  }

  Future<Worker> readWorker(int id) async {
    final db = await instance.database;

    final maps = await db.query(tableWorkers,
        columns: WorkersFields.values, where: '$WorkersFields.id = $id');

    if (maps.isNotEmpty) {
      return Worker.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Worker>> readAllNotes() async {
    final db = await instance.database;

    final orderBy = '${WorkersFields.id} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableWorkers, orderBy: orderBy);

    return result.map((json) => Worker.fromJson(json)).toList();
  }

  Future<int> update(Worker note) async {
    final db = await instance.database;

    return db.update(
      tableWorkers,
      note.toMap(),
      where: '${WorkersFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableWorkers,
      where: '${WorkersFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
