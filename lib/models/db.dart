import 'dart:io';

import 'package:flutter/services.dart';
import 'package:garifuna_movil_app/models/word.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();
  static const WORDSTABLE = 'words';
  static const ID = 'id';
  static const DEF = 'def';
  static const GRP = 'grp';
  static const FAV = 'fav';
  
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

   
  Future<int> addWord(Word w) async {
    final db = await getDB();
    var raw = await db.insert(
      WORDSTABLE,
      w.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    db.close();
    
    return raw;
  }

  Future<List<Word>> getAllWords() async {
    
    final db = await getDB();
    List<Map<String, dynamic>> dbWords = await db.query(WORDSTABLE, orderBy: '$DEF ASC');
    List<Word> words = dbWords.map((dbw) => Word.fromMap(dbw)).toList();
    db.close();

    return words;

  }

  Future<List<Word>> getWordsByGroup(String group) async {
    
    final db = await getDB();
    List<Map<String, dynamic>> dbWords = await db.query(WORDSTABLE, where: '$GRP = ?', whereArgs: [group]);
    List<Word> words = dbWords.map((dbw) => Word.fromMap(dbw)).toList();
    db.close();
    
    return words;

  }

  Future<int> setWordFav(int id, int val) async {

    final db = await getDB();
    int result = await db.rawUpdate('UPDATE $WORDSTABLE SET $FAV = ? WHERE $ID = ?',
    [val, id]);
    return result;

  }

  
}