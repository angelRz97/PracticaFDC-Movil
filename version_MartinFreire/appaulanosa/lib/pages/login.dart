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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/img/logoAulaNosa.png',
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
