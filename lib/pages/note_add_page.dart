import 'package:flutter/material.dart';
import 'package:notebook/databasehelper/databaseHelper.dart';
import 'package:notebook/models/note_book.dart';

class NoteAddPage extends StatefulWidget {
  const NoteAddPage({Key? key}) : super(key: key);

  @override
  State<NoteAddPage> createState() => _NoteAddPageState();
}

class _NoteAddPageState extends State<NoteAddPage> {
  TextEditingController? _titleCtl;
  TextEditingController? _contentCtl;
  String? _mDate;
  DatabaseHelper? _databaseHelper;
  bool? _isLoading;

  @override
  void initState() {
    // TODO: implement initState
    _isLoading = false;
    _titleCtl = TextEditingController();
    _contentCtl = TextEditingController();
    _mDate = DateTime.now().toString().substring(0, 10);
    _databaseHelper = DatabaseHelper();
  }

  void addNoteHelper() async {
    NoteBook noteBook = NoteBook(
        title: _titleCtl!.text, content: _contentCtl!.text, date: _mDate);
    int isAdded = await _databaseHelper!.insertNote(noteBook);
    if (isAdded > 0) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Note has been successfully added")));
      Navigator.pop(context, true);
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Note cann't be added right now")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Add Note"),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                color: Colors.grey.shade50,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Text(
                    "Note Title*",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32, right: 32),
                child: TextField(
                  controller: _titleCtl,
                  maxLength: 100,
                  decoration: InputDecoration(
                    //hintText: "Title",
                    fillColor: Colors.grey.shade400,
                    filled: true,

                    //border: InputBorder.none,
                  ),
                  style: const TextStyle(fontSize: 15, color: Colors.black),
                  cursorColor: Colors.red,
                  cursorWidth: 1,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                color: Colors.grey.shade50,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Text(
                    "Note Content*",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32, right: 32),
                child: TextField(
                  controller: _contentCtl,
                  maxLines: 5,
                  decoration: InputDecoration(
                    //hintText: "Title",
                    fillColor: Colors.grey.shade400,
                    filled: true,

                    //border: InputBorder.none,
                  ),
                  style: const TextStyle(fontSize: 15, color: Colors.black),
                  cursorColor: Colors.red,
                  cursorWidth: 1,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                color: Colors.grey.shade50,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Text(
                    "Note Date*",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32, right: 32),
                child: Container(
                  color: Colors.grey.shade400,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: Text(_mDate!),
                    onTap: () {
                      showDatePicker(
                              context: (context),
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2030))
                          .then((DateTime? newDate) {
                        if (newDate != null) {
                          setState(() {
                            _mDate = newDate.toString().substring(0, 10);
                          });
                        }
                      });
                    },
                    trailing: const Icon(
                      Icons.calendar_month_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (_titleCtl!.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Enter your title")));
                  } else if (_contentCtl!.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Enter your content")));
                  } else {
                    setState(() {
                      _isLoading = true;
                    });
                    addNoteHelper();
                  }
                },
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, bottom: 10, top: 10),
                  margin: const EdgeInsets.only(bottom: 25, top: 25),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(8)),
                  child: const Text(
                    "Submit Note Button",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
