// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'package:proj/principal.dart';
import 'package:proj/utils/conexion_api.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<Login> {
  bool contrasenaNoVisible = true;
  String usuario = "";
  String contrasena = "";
  final usuarioController = TextEditingController();
  final contrasenaController = TextEditingController();

  bool usuarioCorrecto = false;
  bool contrasenaCorrecta = false;

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    contrasenaController.dispose();
    usuarioController.dispose();
    super.dispose();
  }

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
                    'assets/logoAulaNosa.png',
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
              child: Form(
                key: formKey,
                child: login(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget login() {
    return Column(
      children: [
        //CAMPO USUARIO
        Container(
          margin: EdgeInsets.only(left: 50, right: 50),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Color(0xFF0750d8),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            controller: usuarioController,
            decoration: InputDecoration(
              hintText: 'Usuario',
              prefixIcon: Icon(Icons.person),
              filled: true,
              fillColor: Colors.grey[400],
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF0750d8), width: 5),
                  borderRadius: BorderRadius.circular(10)),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF0750d8), width: 5),
                  borderRadius: BorderRadius.circular(10)),
              errorStyle: TextStyle(
                  color: Color.fromARGB(255, 255, 0, 0), fontSize: 13),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Campo Vacio";
              } else {
                setState(() {
                  usuarioCorrecto = true;
                });
              }
              return null;
            },
          ),
        ),
        SizedBox(height: 10),
        //CAMPO CONTRASEÑA
        Container(
          margin: EdgeInsets.only(left: 50, right: 50),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Color(0xFF0750d8),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            controller: contrasenaController,
            obscureText: contrasenaNoVisible,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[400],
              hintText: 'Clave',
              prefixIcon: Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(contrasenaNoVisible
                    ? Icons.visibility_off
                    : Icons.visibility),
                onPressed: () {
                  setState(() {
                    contrasenaNoVisible = !contrasenaNoVisible;
                  });
                },
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF0750d8), width: 5),
                  borderRadius: BorderRadius.circular(10)),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF0750d8), width: 5),
                  borderRadius: BorderRadius.circular(10)),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return "Campo Vacio";
              } else {
                setState(() {
                  contrasenaCorrecta = true;
                });
              }
              return null;
            },
          ),
        ),
        SizedBox(height: 50),
        Container(
          margin: EdgeInsets.only(left: 50, right: 50),
          decoration: BoxDecoration(
            color: Color(0xFF0750d8),
          ),
          child: ElevatedButton(
            onPressed: () async {
              formKey.currentState!.validate();
              switch (await ConexionApi.login(usuarioController.text,
                  hashPassword(contrasenaController.text))) {
                case 1:
                  print("comprobación correcta");

                  break;
                case 2:
                  print("muerte");
                  break;
                case 0:
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Principal()),
                  );
                  break;
              }
              // if(usuarioCorrecto && contrasenaCorrecta) {
              //   formKey.currentState!.save();
              //   hashPassword(contrasenaController.text);
              //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Principal()),);
              // }
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
                Icon(Icons.login_outlined,
                    color: Colors.white), // Icono después del texto
              ],
            ),
          ),
        ),
      ],
    );
  }

  String hashPassword(String password) {
    var pass = utf8.encode(password);
    var passHex = sha256.convert(pass);
    return passHex.toString();
  }
}
