import 'package:notebook/databasehelper/databaseHelper.dart';
import 'package:notebook/models/note_book.dart';

class NoteRepository {
  final DatabaseHelper dbHelper = DatabaseHelper();

  Future<int> insertNote(NoteBook noteBook) async {
    return dbHelper.insertNote(noteBook);
  }

  Future<List<NoteBook>> fetchNote() async {
    return dbHelper.fetchNoteBookList();
  }

  Future<int> deleteNote(NoteBook noteBook) async {
    return dbHelper.deleteNote(noteBook);
  }

  Future<int> updateNote(NoteBook noteBook) async {
    return dbHelper.updateNote(noteBook);
  }

  Future<int> deleteNoteTable(String tableName) {
    return dbHelper.deleteTable(tableName);
  }
}
