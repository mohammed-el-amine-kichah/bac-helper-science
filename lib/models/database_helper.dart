import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../components/flash_card.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('flashcards.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE flashcards(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        moduleId TEXT,
        question TEXT,
        answer TEXT,
        user_added INTEGER NOT NULL DEFAULT 1
      )
    ''');
  }

  // Insert a user-added flashcard into the database
  Future<int> insertFlashCard(FlashCard card, String moduleId) async {
    final db = await instance.database;
    final data = {
      'moduleId': moduleId,
      'question': card.question,
      'answer': card.answer,
      'user_added': 1,  // Only user-added cards are stored in the database
    };
    // Insert the data and get the generated ID
    final id = await db.insert('flashcards', data);

    return id;
  }


  // Update a user-added flashcard in the database
  Future<int> updateFlashCard(int? id, String question, String answer) async {
    final db = await instance.database;
    return await db.update(
      'flashcards',
      {'question': question, 'answer': answer},
      where: 'id = ? ',  // Ensure only user-added cards are updated
      whereArgs: [id],
    );
  }

  // Delete a user-added flashcard from the database
  Future<int> deleteFlashCard(int id) async {
    final db = await instance.database;

    return await db.delete(
      'flashcards',
      where: 'id = ? ' ,  // Ensure only user-added cards are deleted
      whereArgs: [id],
    );
  }

  // Retrieve all user-added flashcards from the database for a specific module
  Future<List<FlashCard>> getUserAddedFlashCards(String moduleId) async {
    final db = await instance.database;
    final result = await db.query(
      'flashcards',
      where: 'moduleId = ?',
      whereArgs: [moduleId],
    );
    return result.map((json) => FlashCard.fromJson(json)).toList();
  }
}
