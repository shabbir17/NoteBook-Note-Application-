import 'package:notebook/repository/notebook_repository.dart';
import 'package:flutter/material.dart';
import 'package:notebook/models/note_book.dart';
import 'package:flutter/cupertino.dart';

class NotebookProvider with ChangeNotifier {
  final noteRepo = NoteRepository();
  bool? _isLoading = false;

  List<NoteBook>? _noteList;
  List<NoteBook>? _noteListContainer;
  get isLoading => _isLoading;

  set isLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  get noteList => _noteList;

  set noteList(value) {
    _noteList = value;
    notifyListeners();
  }

  get noteListContainer => _noteListContainer;

  set noteListContainer(value) {
    _noteListContainer = value;
  }

  Future<String> insertNote(NoteBook noteBook) async {
    String status = "loading";
    isLoading = true;
    int isAdded = await noteRepo.insertNote(noteBook);
    if (isAdded > 0) {
      status = "success";
    } else {
      status = 'error';
    }
    isLoading = false;
    return status;
  }

  Future<void> fetchNote() async {
    isLoading = true;
    noteList = await noteRepo.fetchNote();
    noteListContainer = noteList;
    isLoading = false;
  }

  Future<String> deleteNote(NoteBook noteBook) async {
    String status = "loading";
    isLoading = true;
    int isAdded = await noteRepo.deleteNote(noteBook);
    if (isAdded > 0) {
      status = "success";
    } else {
      status = 'error';
    }
    isLoading = false;
    notifyListeners();
    return status;
  }

  Future<String> updateNote(NoteBook noteBook) async {
    String status = "loading";
    isLoading = true;
    int isAdded = await noteRepo.updateNote(noteBook);
    if (isAdded > 0) {
      status = "success";
    } else {
      status = 'error';
    }
    isLoading = false;
    notifyListeners();
    return status;
  }

  Future<String> deleteNoteTable(String tableName) async {
    String status = "loading";
    isLoading = true;
    int isAdded = await noteRepo.deleteNoteTable(tableName);
    if (isAdded > 0) {
      status = "success";
    } else {
      status = 'error';
    }
    isLoading = false;
    notifyListeners();
    return status;
  }

  void filterSearchResult(String? query) {
    if (query!.isEmpty) {
      noteList = noteListContainer;
    } else {
      List<NoteBook> mList = [];
      for (NoteBook book in noteListContainer!) {
        if (book.title!.toLowerCase().contains(query.toLowerCase())) {
          mList.add(book);
        }
      }

      noteList = mList;
      notifyListeners();
    }
  }
}
