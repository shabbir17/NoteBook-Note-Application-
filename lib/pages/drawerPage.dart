// ignore: file_names
import 'package:flutter/material.dart';
import 'package:notebook/constants/appconstans.dart';
import 'package:notebook/databasehelper/databaseHelper.dart';
import 'package:notebook/pages/login_page.dart';
import 'package:notebook/provider/notebook_provider.dart';
import 'package:notebook/pages/util/memory-management.dart';
import 'package:provider/provider.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  DatabaseHelper? db;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NotebookProvider>(builder: (_, provider, ___) {
      return Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Center(
                child: Text(
                  'NoteBook',
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
              ),
            ),
            ListTile(
              title: const Text(' Help'),
              onTap: () {
                Navigator.pop(context);
                // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //     action: SnackBarAction(
                //       label: "yes",
                //       onPressed: () {},
                //     ),
                //     content: Text("Help")));

                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Alert"),
                        content: const Text("you need help"),
                        actions: <Widget>[
                          ElevatedButton(
                              onPressed: () {}, child: const Text("Yes"))
                        ],
                      );
                    });
              },
            ),
            ListTile(
              title: const Text(' Delete Account'),
              onTap: () async {
                await provider.deleteNoteTable(AppConstants.tableName);
                MemoryManagement.setLoggedIn(false);
                // ignore: use_build_context_synchronously
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) {
                  return const LogInPage();
                }), (route) => false);
              },
            ),
            ListTile(
              title: const Text('LogOut'),
              onTap: () {
                MemoryManagement.setLoggedIn(false);
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) {
                  return const LogInPage();
                }), (route) => false);
              },
            ),
          ],
        ),
      );
    });
  }
}
