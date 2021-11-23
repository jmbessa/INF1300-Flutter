import 'package:flutter/cupertino.dart';
import 'package:services_app/workers.dart';
import 'package:services_app/turn.dart';
import 'package:services_app/category.dart';
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

    _database = await _initDB('workersB.db');
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

    await db.execute('''
    CREATE TABLE $tableTurn (
      ${TurnFields.id} $idType,
      ${TurnFields.description} $stringType
    )
    ''');

    await db.execute('''
    CREATE TABLE $tableCategory (
      ${CategoryFields.id} $idType,
      ${CategoryFields.description} $stringType,
      ${CategoryFields.imagePath} $stringType
    )
    ''');
  }

  Future<Worker> create(Worker worker) async {
    final db = await instance.database;

    final id = await db.insert(tableWorkers, worker.toMap());

    return worker.copy(id: id, name: '');
  }

  Future<Turn> createTurn(Turn turn) async {
    final db = await instance.database;

    final id = await db.insert(tableTurn, turn.toMap());

    return turn.copy(id: id, description: '');
  }

  Future<CategoryObj> createCategory(CategoryObj category) async {
    final db = await instance.database;

    final id = await db.insert(tableCategory, category.toMap());

    return category.copy(id: id, description: '', imagePath: '');
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

  Future<List<Worker>> readWorkerByCategory(String categoryName) async {
    final db = await instance.database;

    //final maps = await db.query(tableWorkers,
    //    columns: WorkersFields.values, where: '${WorkersFields.category} = $categoryName');
    final maps = await db.rawQuery("SELECT * FROM workers WHERE category = '$categoryName'");

    if (maps.isNotEmpty) {
      return maps.map((json) => Worker.fromJson(json)).toList();
    } else {
      throw Exception('Category $categoryName not found');
    }
  }

  Future<List<Worker>> readWorkerByFilter(String categoryName, String turn) async {
    final db = await instance.database;
    final maps = await db.rawQuery("SELECT * FROM workers WHERE category = '$categoryName' & turn = '$turn'" );

    return maps.map((json) => Worker.fromJson(json)).toList();
  }

  Future<Turn> readTurn(int id) async {
    final db = await instance.database;

    final maps = await db.query(tableTurn,
        columns: TurnFields.values, where: '$TurnFields.id = $id');

    if (maps.isNotEmpty) {
      return Turn.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<CategoryObj> readCategory(int id) async {
    final db = await instance.database;

    final maps = await db.query(tableCategory,
        columns: CategoryFields.values, where: '$CategoryFields.id = $id');

    if (maps.isNotEmpty) {
      return CategoryObj.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Turn>> readAllTurns() async {
    final db = await instance.database;

    final orderBy = '${TurnFields.id} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableTurn, orderBy: orderBy);

    return result.map((json) => Turn.fromJson(json)).toList();
  }

  Future<List<CategoryObj>> readAllCategories() async {
    final db = await instance.database;

    final orderBy = '${CategoryFields.id} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableCategory, orderBy: orderBy);

    return result.map((json) => CategoryObj.fromJson(json)).toList();
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
