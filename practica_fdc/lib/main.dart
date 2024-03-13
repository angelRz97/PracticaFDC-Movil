// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "AulaNosa",
      initialRoute: "/login",
      routes: {
        "/login": (BuildContext context) => Login(),
      },
    );
  }
}
