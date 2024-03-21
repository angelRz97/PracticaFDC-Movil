import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proj/paginas/principal.dart';
import 'package:proj/utils/controlador_encriptacion.dart';

import '../models/usuario.dart';
import '../utils/conexion_api.dart';
import '../utils/controlador.dart';

class EditarPerfil extends StatefulWidget {
  @override
  State<EditarPerfil> createState() => _EditarPerfilState();
}

class _EditarPerfilState extends State<EditarPerfil> {
  final nombreController =
      TextEditingController(text: Controlador.usuario.nombre);
  final apellidosController =
      TextEditingController(text: Controlador.usuario.apellidos);
  final emailController =
      TextEditingController(text: Controlador.usuario.email);
  final telefonoController =
      TextEditingController(text: Controlador.usuario.telefono);
  final contrasenaController =
      TextEditingController();
  final contrasenaController2 =
      TextEditingController();

  bool ocultarContrasena1 = true;
  bool ocultarContrasena2 = true;

  /// Controlador de introducción de texto
  final controller = TextEditingController();
  /// Texto default del estado del perfil
  String estado = Controlador.usuario.estado.name;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.chevron_left),),
        title: const Text('Editar Perfil', style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nombreController,
                      decoration: InputDecoration(
                        labelText: 'Nombre',
                        prefixIcon: const Icon(Icons.person_outline_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Campo Vacio';
                        }
                        return '';
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: apellidosController,
                      decoration: InputDecoration(
                        labelText: 'Apellidos',
                        prefixIcon: const Icon(Icons.person_outline_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Campo Vacio';
                        }
                        return '';
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: telefonoController,
                      decoration: InputDecoration(
                        labelText: 'Teléfono',
                        prefixIcon: const Icon(Icons.numbers),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Campo Vacio';
                        }
                        return '';
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: const Icon(Icons.email_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Campo Vacio';
                        }
                        return '';
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      obscureText: ocultarContrasena1,
                      controller: contrasenaController,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        prefixIcon: const Icon(Icons.fingerprint),
                        suffixIcon: IconButton(
                          icon: Icon(ocultarContrasena1 ? Icons.visibility_off : Icons.visibility),
                          color: const Color.fromRGBO(120, 120, 120, 1),
                          onPressed: () {
                            setState(() {
                              ocultarContrasena1 = !ocultarContrasena1;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Campo Vacio';
                        }
                        return '';
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      obscureText: ocultarContrasena2,
                      controller: contrasenaController2,
                      decoration: InputDecoration(
                        labelText: 'Repetir Contraseña',
                        prefixIcon: const Icon(Icons.fingerprint),
                        suffixIcon: IconButton(
                          icon: Icon(ocultarContrasena2 ? Icons.visibility_off : Icons.visibility),
                          color: const Color.fromRGBO(120, 120, 120, 1),
                          onPressed: () {
                            setState(() {
                              ocultarContrasena2 = !ocultarContrasena2;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Campo Vacio';
                        }
                        return '';
                      },
                    ),
                    const SizedBox(height: 30),
                    DropdownButton<String>(
                      padding: const EdgeInsets.only(right: 50, left: 50),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      value: estado,
                      onChanged: (String? newValue) {
                        setState(() {
                          estado = newValue!;
                        });
                      },
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      icon: const Icon(Icons.arrow_drop_down,
                          color: Color.fromRGBO(25, 5, 255, 1)),
                      iconSize: 50,
                      items: [Estado.DESEMPLEADO.name, Estado.EMPLEADO.name]
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                            formKey.currentState?.validate();
                            if (nombreController.text.isNotEmpty && 
                              apellidosController.text.isNotEmpty && 
                              telefonoController.text.isNotEmpty && 
                              emailController.text.isNotEmpty && 
                              contrasenaController.text.isNotEmpty && 
                              contrasenaController2.text.isNotEmpty) {
                              if (contrasenaController.text == contrasenaController2.text) {
                                setState(() {
                                  formKey.currentState?.save();
                                  Controlador.usuario.nombre = nombreController.text;
                                  Controlador.usuario.apellidos = apellidosController.text;
                                  Controlador.usuario.telefono = telefonoController.text;
                                  Controlador.usuario.email = emailController.text;
                                  Controlador.usuario.contrasena = ControladorEncriptacion.hashPassword(contrasenaController.text);
                                  Controlador.usuario.estado = estado == Estado.DESEMPLEADO.name ? Estado.DESEMPLEADO : Estado.EMPLEADO;
                                  // Controlador.usuario.imagen = 
                                  ConexionApi.actualizar();
                                  Get.to(Principal());
                                });
                              }
                            }
                        }, 
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0750d8), 
                          side: BorderSide.none, 
                          shape: const StadiumBorder()
                        ), 
                        child: const Text('Guardar', 
                          style: TextStyle(color: Colors.white),
                        )
                      )
                    ),
                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}