import 'package:flutter/material.dart';
import 'package:notebook/pages/splashpage.dart';
import 'package:notebook/provider/notebook_provider.dart';
import 'package:notebook/provider/user_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<UserProvider>(create: (context) {
        return UserProvider();
      }),
      ChangeNotifierProvider<NotebookProvider>(create: (context) {
        return NotebookProvider();
      })
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SpalshScreen(),
    );
  }
}
