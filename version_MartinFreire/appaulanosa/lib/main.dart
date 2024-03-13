import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'pages/login.dart';

void main() {
  runApp(AulaNosa());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
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
