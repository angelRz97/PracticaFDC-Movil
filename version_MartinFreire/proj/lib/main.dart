import 'package:flutter/material.dart';
import 'paginas/login.dart';
import 'paginas/principal.dart';

void main() {
  runApp(const MyApp(usuario: '',));
}

class MyApp extends StatelessWidget {
  final String usuario;
  const MyApp({Key? key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        "/login": (BuildContext context) => Login(),
        '/principal': (BuildContext context) => Principal(usuario: usuario),
      }
    );
  }
}
