import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/breed.dart';

class DatabaseService {
  static final DatabaseService _databaseService = DatabaseService._internal();
  factory DatabaseService() => _databaseService;
  DatabaseService._internal();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    //initialize the DB first time it is accessed

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();

    //setup path to database
    //use join to ensure path is correctly constructed
    final path = join(databasePath, 'flutter_sqflite_database.db');

    //set version. This execute the onCreate and provides a path
    //to perform database upgrades and downgrades.
    return await openDatabase(path, onCreate: _onCreate, version: 1);
  }

  //When database if first created, create table to store breeds
  //and one to store dogs

  Future<void> _onCreate(Database db, int version) async {
    //use CREATE {breeds} TABLE
    await db.execute(
      'CREATE TABLE breeds(id INTEGER PRIMARY KEY, name TEXT, description TEXT)',
    );

    //use CREATE {dogs} TABLE
    await db.execute(
      'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER, color INTEGER, breedId INTEGER, FOREIGN KEY (breedId) REFERENCES breeds(id) ON DELETE SET NULL)',
    );
  }

  //insert breeds into DB
  Future<void> insertBreed(Breed breed) async {
    //Get ref to DB
    final db = await _databaseService.database;

    //insert Breed into correct table
    //"conflictAlgorithm" in case same breed is inserted twice
    //in that case replace any previous data.
    await db.insert(
      'breeds',
      breed.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //Retrieve breeds from breeds table
  Future<List<Breed>> breeds() async {
    //Get ref to DB
    final db = await _databaseService.database;

    //Query table for all breeds
    final List<Map<String, dynamic>> maps = await db.query("breeds");

    //Convert List<Map<String, dynamic> into a List<Breed>.
    return List.generate(maps.length, (index) => Breed.fromMap(maps[index]));
  }

  //Update breed data from table
  Future<void> updateBreed(Breed breed) async {
    //Getref to DB
    final db = await _databaseService.database;

    //Update the breed
    await db.update(
      'breeeds', breed.toMap(),
      //Endure matchng id of breed
      where: 'id = ?',
      //pass breed id as whereArg to prevent sql injection.
      whereArgs: [breed.id],
    );
  }

  //Dalete a breed data from table
  Future<void> deleteBreed(int id) async {
    //Get ref to DB
    final db = await _databaseService.database;

    //remove breed from DB
    await db.delete('breeds',
        //use where to delete specific breed
        where: 'id = ?',

        //pass breed id as whereArg to prevent SQL injection
        whereArgs: [id]);
  }
}
