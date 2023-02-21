import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notebook/pages/homePage.dart';
import 'package:notebook/pages/login_page.dart';
import 'package:notebook/pages/util/memory-management.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({Key? key}) : super(key: key);

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  @override
  void initState() {
    super.initState();
    //Duration duration= Duration(seconds: 5);
    initSharedPref();
  }

  void initSharedPref() async {
    await MemoryManagement.init();
    Timer(const Duration(seconds: 3), () {
      try {
        if (MemoryManagement.getLoggedIn() == true) {
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) {
            return HomePage();
          }), (route) => false);
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LogInPage()),
              (route) => false);
        }
      } catch (error) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LogInPage()),
            (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Text(
              "NoteBook",
              style: TextStyle(color: Colors.white, fontSize: 35),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
                height: 3, width: 200, child: LinearProgressIndicator())
          ],
        ),
      ),
    );
  }
}
