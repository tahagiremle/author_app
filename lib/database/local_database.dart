import 'dart:async';

import 'package:flutter_author_app/model/book.dart';
import 'package:flutter_author_app/model/chapter.dart';
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
    await db.execute('''
CREATE TABLE $chaptersTableName (
	$chaptersId	INTEGER NOT NULL UNIQUE PRIMARY KEY AUTOINCREMENT,
	$chaptersBookId	INTEGER NOT NULL,
	$chaptersTitle	TEXT NOT NULL,
	$chaptersContent	TEXT,
	$chaptersDueDate	TEXT DEFUALT CURRENT TIMESTAMP,
  FOREIGN KEY ("$chaptersBookId") REFERENCES "$bookTableName"("$idField") ON UPDATE ON DELETE CASCADE
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

  Future<int> updateBook(Book book) async {
    Database? db = await _initializeDB();
    if (db != null) {
      return await db.update(bookTableName, book.toMap(),
          where: "$idField = ?", whereArgs: [book.id]);
    } else {
      return 0;
    }
  }

  Future<int> deleteBook(Book book) async {
    Database? db = await _initializeDB();
    if (db != null) {
      return await db.delete(
        bookTableName,
        where: "$idField = ?",
        whereArgs: [book.id],
      );
    } else {
      return 0;
    }
  }

  Future<int> createChapter(Chapter chapter) async {
    Database? db = await _initializeDB();
    if (db != null) {
      return await db.insert(chaptersTableName, chapter.toMap());
    } else {
      return -1;
    }
  }

  Future<List<Chapter>> readAllChapters(int bookId) async {
    Database? db = await _initializeDB();
    List<Chapter> chapters = [];

    if (db != null) {
      List<Map<String, dynamic>> chapertsMap = await db.query(
        chaptersTableName,
        where: "$chaptersBookId = ?",
        whereArgs: [bookId],
      );
      for (Map<String, dynamic> m in chapertsMap) {
        Chapter c = Chapter.fromMap(m);
        chapters.add(c);
      }
    }
    return chapters;
  }

  Future<int> updateChapter(Chapter chapter) async {
    Database? db = await _initializeDB();
    if (db != null) {
      return await db.update(chaptersTableName, chapter.toMap(),
          where: "$chaptersId = ?", whereArgs: [chapter.id]);
    } else {
      return 0;
    }
  }

  Future<int> deleteChapter(Chapter chapter) async {
    Database? db = await _initializeDB();
    if (db != null) {
      return await db.delete(
        chaptersTableName,
        where: "$chaptersId = ?",
        whereArgs: [chapter.id],
      );
    } else {
      return 0;
    }
  }
}
