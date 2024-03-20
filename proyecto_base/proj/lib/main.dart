import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:proj/paginas/crearusuario.dart';
import 'paginas/login.dart';
import 'paginas/principal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        routes: {
          "/login": (BuildContext context) => Login(),
          '/principal': (BuildContext context) => Principal(),
          '/crearUsuario': (BuildContext context) =>  CrearUsuario()
        });
  }
}
