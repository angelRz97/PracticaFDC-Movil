// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginState();
}

///Clase empleada para mantener el estado para el widget Login
class LoginState extends State<Login> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
              top: 50,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/img/logoAulaNosa.png',
                    width: 300,
                    height: 300,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 350, // Ajusta la posición vertical según sea necesario
              left: 0,
              right: 0,
              child: login(), // Aquí llamamos a la función que crea el formulario de inicio de sesión
            ),
          ],
        ),
      ),
    );
  }

  Widget login() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          margin: EdgeInsets.only(left: 50, right: 50),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Color.fromRGBO(0, 70, 175, 1),
              width: 2,
            ),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Usuario',
              border: InputBorder.none,
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          margin: EdgeInsets.only(left: 50, right: 50),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Color.fromRGBO(0, 70, 175, 1),
              width: 2,
            ),
          ),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Contraseña',
              border: InputBorder.none,
            ),
          ),
        ),
        SizedBox(height: 50),
        Container(
          margin: EdgeInsets.only(left: 50, right: 50),
          decoration: BoxDecoration(
            color: Color.fromRGBO(0, 70, 175, 1),
          ),
          child: ElevatedButton(
            onPressed: () {
              //logica para hacer el login
            },
            style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(0, 70, 175, 1)),
            child: Center(
              child: Text(
                'ACCESO',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  height: 3
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

