import 'package:flutter/material.dart';

import 'pages/login.dart';

void main() {
  runApp(AulaNosa());
}

class AulaNosa extends StatefulWidget {
  @override
  AulaNosaState createState() => AulaNosaState();
}

class AulaNosaState extends State<AulaNosa> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "AulaNosa",
      debugShowCheckedModeBanner: false,
      initialRoute: "/login",
      routes: {
        "/login": (BuildContext context) => Login(),
      },
    );
  }
}
