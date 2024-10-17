import 'dart:async';

import 'package:flutter_author_app/model/book.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

String fileName = "author.db";

class LocalDatabase {
  LocalDatabase._privateConstructor();

  static final LocalDatabase _object = LocalDatabase._privateConstructor();

  factory LocalDatabase() {
    return _object;
  }

  Database? _dataBase;

  Future<Database?> _initializeDB() async {
    if (_dataBase == null) {
      String dbPath = await getDatabasesPath();
      String path = join(dbPath, fileName);
      _dataBase = await openDatabase(path, version: 1, onCreate: _createTable);
    }
    return _dataBase;
  }

  FutureOr<void> _createTable(Database db, int version) async {
    await db.execute('''
CREATE TABLE $bookTableName (
	$idField	INTEGER NOT NULL UNIQUE PRIMARY KEY AUTOINCREMENT,
	$nameField	TEXT NOT NULL,
	$dueDateField	INTEGER
);     
''');
  }

  Future<int> createBook(Book book) async {
    Database? db = await _initializeDB();
    if (db != null) {
      return await db.insert(bookTableName, book.toMap());
    } else {
      return -1;
    }
  }

  Future<List<Book>> readAllBooks() async {
    Database? db = await _initializeDB();
    List<Book> books = [];

    if (db != null) {
      List<Map<String, dynamic>> booksMap = await db.query(bookTableName);
      for (Map<String, dynamic> m in booksMap) {
        Book b = Book.fromMap(m);
        books.add(b);
      }
    }
    return books;
  }
}
