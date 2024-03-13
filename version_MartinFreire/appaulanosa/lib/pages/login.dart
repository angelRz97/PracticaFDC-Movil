// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<Login> {

  bool passNotVisible = true;

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
              top: 350,
              left: 0,
              right: 0,
              child: login(),
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
          margin: EdgeInsets.only(left: 50, right: 50),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Color(0xFF0750d8),
              width: 2,
            ),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Usuario',
              prefixIcon: Icon(Icons.person),
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.grey[400]
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          margin: EdgeInsets.only(left: 50, right: 50),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Color(0xFF0750d8),
              width: 2,
            ),
          ),
          child: TextField(
            obscureText: passNotVisible,
            decoration: InputDecoration(
              hintText: 'Clave',
              prefixIcon: Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(passNotVisible ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    passNotVisible = !passNotVisible;
                  });
                },
              ),
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.grey[400],
            ),
          ),
        ),
        SizedBox(height: 50),
        Container(
          margin: EdgeInsets.only(left: 50, right: 50),
          decoration: BoxDecoration(
            color: Color(0xFF0750d8),
          ),
          child: ElevatedButton(
            onPressed: () {
              //logica para hacer el login
            },
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF0750d8)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'ACCEDER  ',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            height: 3,
          ),
        ),
        Icon(Icons.login_outlined, color: Colors.white), // Icono después del texto
      ],
    ),
          ),
        ),
      ],
    );
  }

  String hashPassword(String password) {
    var pass = utf8.encode(password);
    String passHex = sha256.convert(pass) as String;
    return passHex;
  }
}

