import 'dart:io';

import 'package:notebook/models/note_book.dart';
import 'package:notebook/models/user.dart';
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:notebook/constants/appconstans.dart';

class DatabaseHelper {
  Future<Database> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'notebook.db');
    return openDatabase(
      path,
      version: 2,
      onCreate: (
        db,
        version,
      ) async {
        await db.execute(
            'CREATE TABLE ${AppConstants.tableName} (id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,content TEXT, date TEXT)');
        await db.execute(
            'CREATE TABLE ${AppConstants.userTableName} (id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,username TEXT, password TEXT)');
      },
    );
  }

//notebook insert od add
  Future<int> insertNote(NoteBook noteBook) async {
    Database db = await initDatabase();
    return db.insert(AppConstants.tableName, noteBook.toMap());
  }

//Notebook List fetch
  Future<List<NoteBook>> fetchNoteBookList() async {
    Database db = await initDatabase();
    List<Map<String, dynamic>> noteBookMapList =
        await db.query(AppConstants.tableName);
    return List.generate(noteBookMapList.length, (index) {
      Map<String, dynamic> mNoteBook = noteBookMapList[index];
      return NoteBook(
          id: mNoteBook['id'],
          title: mNoteBook['title'],
          content: mNoteBook['content'],
          date: mNoteBook['date']);
    });
  }

  //user registration
  Future<int> userRegistration(User user) async {
    Database db = await initDatabase();
    return db.insert(AppConstants.userTableName, user.toMap());
  }

  //user fetch username, password

  Future<List<User>> fetchUserList(String userName, String password) async {
    Database db = await initDatabase();
    List<Map<String, dynamic>> userMapList = await db.rawQuery(
        " SELECT * FROM user WHERE username='$userName' AND password='$password'");
    return List.generate(userMapList.length, (index) {
      Map<String, dynamic> mUser = userMapList[index];
      return User(
        id: mUser['id'],
        name: mUser['name'],
        username: mUser['username'],
        password: mUser['password'],
      );
    });
  }

  //User isExisted
  Future<bool> isExist(String username) async {
    Database db = await initDatabase();
    List<Map<String, dynamic>> userMapList =
        await db.rawQuery("SELECT * FROM user WHERE username='$username'");
    List.generate(userMapList.length, (index) {
      Map<String, dynamic> mUser = userMapList[index];
      return User(
        id: mUser['id'],
        name: mUser['name'],
        username: mUser['username'],
        password: mUser['password'],
      );
    });

    if (userMapList.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<int> updateNote(NoteBook noteBook) async {
    Database db = await initDatabase();
    return db.update(AppConstants.tableName, noteBook.toMap(),
        where: ' id = ?', whereArgs: [noteBook.id]);
  }

  Future<int> deleteNote(NoteBook noteBook) async {
    Database db = await initDatabase();
    return db.delete(AppConstants.tableName,
        where: ' id = ?', whereArgs: [noteBook.id]);
  }

  Future<int> deleteTable(String tableName) async {
    Database db = await initDatabase();
    return db.delete(tableName);
  }
}
