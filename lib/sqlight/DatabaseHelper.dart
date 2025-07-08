import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import '../model/User.dart';
class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;
  static const String _tableUsers = 'users';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = join(await getDatabasesPath(), 'arsenal_app.db');
    return openDatabase(
      dbPath,
      version: 3,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableUsers (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            firstName TEXT NOT NULL,
            lastName TEXT NOT NULL,
            email TEXT NOT NULL UNIQUE,
            password TEXT NOT NULL,
            country TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<int> insertUser(User user) async {
    final db = await database;
    final userMap = user.toMap();
    userMap['password'] = hashPassword(user.password);
    try {
      return await db.insert(
        _tableUsers,
        userMap,
        conflictAlgorithm: ConflictAlgorithm.fail,
      );
    } on DatabaseException catch (e) {
      if (e.isUniqueConstraintError()) {
        throw Exception('Email already exists');
      } else {
        throw Exception('Insert failed: ${e.toString()}');
      }
    }
  }





  /// Fetch a user by email (for login or validation).
  Future<bool> loginUser(String email, String password) async {
    final db = await database;
    final hashedPassword = hashPassword(password.trim());

    final result = await db.query(
      _tableUsers,
      where: 'email = ? AND password = ?',
      whereArgs: [email.trim(), hashedPassword.trim()],
    );

    return result.isNotEmpty;
  }


  /// Fetch all registered users.
  Future<List<User>> getAllUsers() async {
    final db = await database;
    final maps = await db.query(_tableUsers);
    return maps.map((map) => User.fromMap(map)).toList();
  }

  /// Close the database connection manually.
  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }

  /// Secure password hash using SHA256
  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  String hashPassword(String password) {
    final bytes = utf8.encode(password.trim());
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
