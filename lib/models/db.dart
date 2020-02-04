import 'dart:io';

import 'package:flutter/services.dart';
import 'package:garifuna_movil_app/models/wordDB.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();
  static const WORDSTABLE = 'words';
  static const DEF = 'def';
  static const GRP = 'grp';
  
  Future<Database> getDB() async {
   
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "garifuna.db");
    var exists = await databaseExists(path);
    var fullPath = path;
    Database db;

    if(!exists){
      
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}
      ByteData data = await rootBundle.load(join("assets", "garifuna.db"));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
      db = await openDatabase(fullPath);

    }else{

      db = await openDatabase(fullPath);

    }

    return db;
  }

   
  Future<int> addWord(WordDb w) async {
    final db = await getDB();
    var raw = await db.insert(
      WORDSTABLE,
      w.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    db.close();
    
    return raw;
  }

  Future<List<WordDb>> getAllWords() async {
    
    final db = await getDB();
    List<Map<String, dynamic>> dbWords = await db.query(WORDSTABLE, orderBy: '$DEF ASC');
    List<WordDb> words = dbWords.map((dbw) => WordDb.fromMap(dbw)).toList();
    db.close();

    return words;

  }

  Future<List<WordDb>> getWordsByGroup(String group) async {
    
    final db = await getDB();
    List<Map<String, dynamic>> dbWords = await db.query(WORDSTABLE, where: '$GRP = ?', whereArgs: [group]);
    List<WordDb> words = dbWords.map((dbw) => WordDb.fromMap(dbw)).toList();
    db.close();
    
    return words;

  }
  
}