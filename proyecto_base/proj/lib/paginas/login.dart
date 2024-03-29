// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:proj/paginas/principal.dart';
import 'package:proj/utils/controlador.dart';
import 'package:proj/utils/controlador_encriptacion.dart';

import '../utils/conexion_api.dart';

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
  bool errorLogin = false;
  bool campoVacio = false;
  bool compruebaLogin = false;
  bool etiquetas = false;
  bool novedades = false;
  bool etiquetasUsuario = false;
  bool formacionesConInteres = false;

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
          margin: const EdgeInsets.only(left: 50, right: 50),
          child: TextFormField(
              controller: usuarioController,
              onChanged: (text) {
                if (text.characters.isEmpty) {
                  usuarioCorrecto = false;
                } else {
                  usuarioCorrecto = true;
                }
              },
              decoration: InputDecoration(
                hintText: 'Email',
                prefixIcon: const Icon(
                  Icons.person,
                  color: Color.fromRGBO(120, 120, 120, 1),
                ),
                filled: true,
                fillColor: const Color.fromRGBO(217, 217, 217, 1),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(120, 120, 120, 1), width: 2)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(237, 67, 55, 1), width: 1)),
                errorStyle: const TextStyle(
                    color: Color.fromRGBO(237, 67, 55, 1),
                    fontFamily: 'InriaSans',
                    fontWeight: FontWeight.bold),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  setState(() {
                    campoVacio = true;
                  });
                  return "";
                } else {
                  setState(() {
                    campoVacio = false;
                  });
                }
                if (errorLogin) {
                  return "";
                }
                return null;
              }),
        ),
        const SizedBox(height: 10),
        //CAMPO CONTRASEÑA
        Container(
          margin: const EdgeInsets.only(left: 50, right: 50),
          child: TextFormField(
              controller: contrasenaController,
              obscureText: contrasenaNoVisible,
              onChanged: (text) {
                if (text.characters.isEmpty) {
                  contrasenaCorrecta = false;
                } else {
                  contrasenaCorrecta = true;
                }
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromRGBO(217, 217, 217, 1),
                hintText: 'Contraseña',
                prefixIcon: const Icon(
                  Icons.lock,
                  color: Color.fromRGBO(120, 120, 120, 1),
                ),
                suffixIcon: IconButton(
                  icon: Icon(contrasenaNoVisible
                      ? Icons.visibility_off
                      : Icons.visibility),
                  color: const Color.fromRGBO(120, 120, 120, 1),
                  onPressed: () {
                    setState(() {
                      contrasenaNoVisible = !contrasenaNoVisible;
                    });
                  },
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(120, 120, 120, 1), width: 2)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(237, 67, 55, 1), width: 1)),
                errorStyle: const TextStyle(
                    color: Color.fromRGBO(237, 67, 55, 1),
                    fontFamily: 'InriaSans',
                    fontWeight: FontWeight.bold),
              ),
              validator: (value) {
                if (campoVacio) {
                  return "No debe haber campos vacíos.";
                }
                if (value!.isEmpty) {
                  setState(() {
                    campoVacio = true;
                  });
                  return "No debe haber campos vacíos.";
                } else if (errorLogin) {
                  return "Email o contraseña incorrectos.";
                }
                return null;
              }),
        ),

        const SizedBox(height: 50),
        Container(
          margin: const EdgeInsets.only(left: 50, right: 50),
          decoration: const BoxDecoration(
            color: Color(0xFF0750d8),
          ),
          child: ElevatedButton(
            onPressed: () async {
              formKey.currentState!.validate();
              if (contrasenaController.text.isNotEmpty ||
                  usuarioController.text.isNotEmpty) {
                switch (await ConexionApi.login(
                    usuarioController.text,
                    ControladorEncriptacion.hashPassword(
                        contrasenaController.text))) {
                  case 1:
                    //print("comprobación correcta");
                    setState(() {
                      errorLogin = true;
                      compruebaLogin = false;
                    });
                    formKey.currentState!.validate();
                    break;
                  case 2:
                    print("Error conexión usuario.");
                    setState(() {
                      compruebaLogin = false;
                    });
                    break;
                  case 0:
                    setState(() {
                      compruebaLogin = true;
                    });
                    break;
                }

                if (compruebaLogin) {
                  switch (await ConexionApi.recuperaIntereses()) {
                    case 1:
                      print("Error api etiquetas.");
                      setState(() {
                        etiquetas = false;
                      });
                      break;
                    case 2:
                      print("Error al recuperar etiquetas.");
                      setState(() {
                        etiquetas = false;
                      });
                      break;
                    case 0:
                      setState(() {
                        etiquetas = true;
                      });
                      break;
                  }

                  if (etiquetas) {
                    switch (await ConexionApi.recuperaNovedades()) {
                      case 2:
                        setState(() {
                          novedades = false;
                        });
                        break;
                      case 0:
                        setState(() {
                          novedades = true;
                        });
                        break;
                    }
                  }
                }

                if (novedades) {
                  switch (await ConexionApi.interesesUsuario(
                      Controlador.usuario.id)) {
                    case 0:
                      setState(() {
                        etiquetasUsuario = true;
                      });
                      break;
                    case 1:
                      setState(() {
                        etiquetasUsuario = false;
                      });
                      break;
                    case 2:
                      setState(() {
                        etiquetasUsuario = false;
                      });
                      break;
                  }
                }

                if (etiquetasUsuario) {
                  switch (await ConexionApi.formacionesConInteres(
                      Controlador.usuario.id)) {
                    case 1:
                      setState(() {
                        formacionesConInteres = false;
                      });
                      break;
                    case 2:
                      setState(() {
                        formacionesConInteres = false;
                      });
                      break;
                    case 0:
                      setState(() {
                        formacionesConInteres = true;
                      });
                      break;
                  }
                }

                if (compruebaLogin &&
                    etiquetas &&
                    novedades &&
                    etiquetasUsuario &&
                    formacionesConInteres) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Principal()),
                  );
                }
              }
              // if (usuarioCorrecto && contrasenaCorrecta) {
              //   formKey.currentState!.save();
              //   hashPassword(contrasenaController.text);
              //   Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) =>
              //             Principal(usuario: usuarioController.text)),
              //   );
              // }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0750d8),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    'ACCEDER ',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      height: 2,
                    ),
                  ),
                ),

                Icon(Icons.login_outlined, color: Colors.white),

                // Icono después del texto
              ],
            ),
          ),
        ),
      ],
    );
  }
}
