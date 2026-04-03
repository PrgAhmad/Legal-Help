import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Law {
  static String tableName = "law_data";
  static String id = "id";
  static String secArtNo = "secArtNo";
  static String secArtTitle = "secArtTitle";
  static String secArtContent = "secArtContent";
  static String actName = "actName";
}

class LocalDatabase {
  Future<Database> getDB() async {
    final dbDirPath = await getDatabasesPath();
    final dbPath = join(dbDirPath, "legal_help.db");
    final db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
      CREATE TABLE ${Law.tableName}(
        ${Law.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${Law.secArtNo} TEXT,
        ${Law.secArtTitle} TEXT,
        ${Law.secArtContent} TEXT UNIQUE,
        ${Law.actName} TEXT
      );
      ''');
        await db.execute('''
      CREATE TABLE chatbot(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        chat TEXT
      );
      ''');
      },
    );
    return db;
  }
}

class LawBookmark extends LocalDatabase {
  Future<int> add({number, title, content, actName}) async {
    Database db = await getDB();
    int res = await db.insert(Law.tableName, {
      Law.secArtNo: number,
      Law.secArtTitle: title,
      Law.secArtContent: content,
      Law.actName: actName,
    });
    return res;
  }

  Future<List<Map<String, Object?>>> get() async {
    Database db = await getDB();
    return db.query(Law.tableName);
  }

  Future<int> delete(number, actName) async {
    Database db = await getDB();
    int res = await db.delete(
      Law.tableName,
      where: '${Law.secArtNo} = ? AND ${Law.actName} = ?',
      whereArgs: [number, actName],
    );
    print(res);
    return res;
  }
}
