import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled/model/user.dart';

class UserDatabase {
  static final UserDatabase instance = UserDatabase._init();

  static Database? _database;

  UserDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('user.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(join(await getDatabasesPath(), 'user_database.db'),
      onCreate: (db, version) {return db.execute('CREATE TABLE user(username TEXT PRIMARY KEY)',);},
      version: 1,
    );

  }

  // Define a function that inserts dogs into the database
  Future<void> insertUser(User user) async {
    // Get a reference to the database.
    final db = await database;
    await db.insert(
      'user',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the dogs from the dogs table.
  Future<List<User>> getUser() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('user');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) { return User(username: maps[i]['username']); });
  }

  Future<void> DropTableWhenLogOut() async {
    Database db = await openDatabase(join(await getDatabasesPath(), 'user_database.db'),
      onCreate: (db, version) {return db.execute('CREATE TABLE user(username TEXT PRIMARY KEY)',);},

      version: 1,
    );
    await db.execute("DROP TABLE IF EXISTS user");
  }
  Future<String> CheckExist() async {
    final db = await database;
    final count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM user'));
    String Count = count.toString();
    return Count;
  }
  Future close() async {
    final db = await instance.database;

    db.close();
  }
}