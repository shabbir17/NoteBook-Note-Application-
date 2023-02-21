// ignore: file_names
import 'package:flutter/material.dart';

import 'package:notebook/databasehelper/databaseHelper.dart';
import 'package:notebook/models/note_book.dart';
import 'package:notebook/pages/drawerPage.dart';
import 'package:notebook/pages/note_add_page.dart';
import 'package:notebook/pages/util/util.dart';

class HomePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseHelper? _databaseHelper;
  List<NoteBook>? noteList;
  List<NoteBook>? noteListContainer;

  @override
  void initState() {
    super.initState();
    noteList = [];
    noteListContainer = [];
    _databaseHelper = DatabaseHelper();
    fetchNoteList();
  }

  void fetchNoteList() async {
    try {
      noteListContainer!.clear();
      noteListContainer = await _databaseHelper!.fetchNoteBookList();
      if (noteListContainer!.isNotEmpty) {
        setState(() {
          noteList = noteListContainer;
        });
      }
    } catch (error) {}
  }

  void filterSearchResult(String? query) {
    if (query!.isEmpty) {
      setState(() {
        noteList = noteListContainer;
      });
    } else {
      List<NoteBook> mList = [];
      for (NoteBook book in noteListContainer!) {
        if (book.title!.toLowerCase().contains(query.toLowerCase())) {
          mList.add(book);
        }
      }
      setState(() {
        noteList = mList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Container(
          margin: const EdgeInsets.only(bottom: 20, right: 20),
          child: FloatingActionButton(
            onPressed: () async {
              bool? isAdded = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                return const NoteAddPage();
              }));
              if (isAdded != null) {
                if (isAdded == true) {
                  noteList!.clear();
                  fetchNoteList();
                }
              }
            },
            elevation: 5,
            child: const Icon(Icons.add),
          ),
        ),
        appBar: AppBar(
          title: Text(
            "NoteBook (${noteList!.length})",
            style: const TextStyle(fontSize: 25),
          ),
          centerTitle: true,
        ),
        drawer: const DrawerPage(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Row(
                children: [
                  const Icon(
                    Icons.menu_book,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Hello",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Habib",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    Util.greeting(),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: TextField(
                  onChanged: (String newchar) {
                    filterSearchResult(newchar);
                  },
                  decoration: InputDecoration(
                      hintText: "Search by name",
                      hintStyle: const TextStyle(color: Colors.grey),
                      // prefix: Icon(Icons.search,color: Colors.grey,)
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      ),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)))),
                ),
              ),
              Expanded(
                child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: noteList!.length,
                    itemBuilder: (context, index) {
                      NoteBook noteBook = noteList![index];
                      return Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                              border: Border.all(
                                  width: 2.0, color: Colors.blueAccent)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        noteBook.title!,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      Text(
                                        noteBook.content!,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 18),
                                      ),
                                      Text(
                                        noteBook.date!,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                                PopupMenuButton<String>(
                                    padding: EdgeInsets.zero,
                                    onSelected: (value) {},
                                    icon: const Icon(Icons.more_vert),
                                    itemBuilder: (context) {
                                      return <PopupMenuEntry<String>>[
                                        const PopupMenuItem(
                                          value: "edit",
                                          child: ListTile(
                                            leading: Icon(Icons.edit),
                                            title: Text("Update"),
                                          ),
                                        ),
                                        const PopupMenuItem(
                                          value: "delete",
                                          child: ListTile(
                                            leading: Icon(Icons.delete),
                                            title: Text("Delete"),
                                          ),
                                        )
                                      ];
                                    })
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
