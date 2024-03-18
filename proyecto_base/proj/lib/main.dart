import 'package:flutter/material.dart';
import 'paginas/login.dart';
import 'paginas/principal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        routes: {
          "/login": (BuildContext context) => Login(),
          '/principal': (BuildContext context) => Principal(),
        });
  }
}
