// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proj/models/usuario.dart';
import 'package:proj/utils/conexion_api.dart';

import '../models/interes.dart';
import '../utils/controlador.dart';
import '../construirPerfil.dart';
import 'editarperfil.dart';

class Perfil extends StatefulWidget {
  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
  void initState() {
    if (Controlador.usuario.email == 'admin') {
      ConexionApi.recuperaUsuarios();
    }
    super.initState();
  }

  final nombreController =
      TextEditingController(text: Controlador.usuario.nombre);
  final apellidosController =
      TextEditingController(text: Controlador.usuario.apellidos);
  final emailController =
      TextEditingController(text: Controlador.usuario.email);
  final telefonoController =
      TextEditingController(text: Controlador.usuario.telefono);

  /// Controlador de introducción de texto
  final controller = TextEditingController();

  /// Lista general de intereses
  List<Interes> intereses = Controlador.listaIntereses;
  List<Usuario> usuarios = Controlador.listaUsuarios;

  /// Lista de intereses que has seleccionado
  List<Interes> interesesSeleccionados = Controlador.listaInteresesUsuario;

  @override
  Widget build(BuildContext context) {
    if (Controlador.usuario.email == "admin") {
      return Column(
        children: [
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(217, 217, 217, 1)),
                  child: const Icon(Icons.cases_rounded),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('/crearOferta');
                },
              ),
              const SizedBox(width: 40),
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(217, 217, 217, 1)),
                child: const Icon(Icons.school),
              ),
              const SizedBox(width: 40),
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(217, 217, 217, 1)),
                child: const Icon(Icons.person),
              )
            ],
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Buscar',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.red))),
              onChanged: searchInteres,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.person),
                  title: Text(Controlador.usuario.usuario),
                );
              },
            ),
          ),
        ],
      );
    } else {
      return ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 30),

          /// Funcion para construir la imagen y poder editar la imagen
          construirPerfil(),
          const SizedBox(height: 24),

          /// Funcion para construir el apartado de estado e intereses
          construirNombre(
              Controlador.usuario.nombre,
              Controlador.usuario.apellidos,
              Controlador.usuario.email,
              Controlador.usuario.telefono),
        ],
      );
    }
  }

  Widget construirNombre(nombre, apellidos, email, telefono) => Column(
        children: [
          Text(
            nombre + " " + apellidos,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            email,
            style: const TextStyle(color: Colors.grey, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              children: [
                const WidgetSpan(
                  child: Icon(Icons.phone, size: 19),
                ),
                TextSpan(
                  text: ' ' + telefono,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
              width: 200,
              child: ElevatedButton(
                  onPressed: () => Get.to(() => EditarPerfil()),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0750d8),
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  child: const Text(
                    'Editar Perfil',
                    style: TextStyle(color: Colors.white),
                  ))),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.only(
                left: 120, right: 120, top: 10, bottom: 10),
            decoration: const BoxDecoration(
                color: Color.fromRGBO(25, 5, 255, 1),
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: const Text(
              'ESTADO',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding:
                const EdgeInsets.only(left: 48, right: 48, top: 10, bottom: 10),
            decoration: const BoxDecoration(
                color: Color.fromRGBO(255, 0, 0, 1),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Text(
              Controlador.usuario.estado.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Container(
            padding:
                const EdgeInsets.only(left: 48, right: 48, top: 10, bottom: 10),
            decoration: const BoxDecoration(
                color: Color.fromRGBO(25, 5, 255, 1),
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: const Text(
              'LISTA DE INTERESES',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
              height: 40,
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromRGBO(217, 217, 217, 1),
                  style: BorderStyle.solid,
                  width: 1.0,
                ),

                /// Setear color de la barra
                color: const Color.fromRGBO(217, 217, 217, 1),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: TextField(
                /// Llamar al controlador
                controller: controller,

                /// Setear icono, texto y forma de la barra
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),

                /// Setear función de la barra
                onChanged: searchInteres,
              )),
          const SizedBox(height: 10),
          Container(
              margin: const EdgeInsets.fromLTRB(30, 0, 30, 10),

              /// Setear color de fondo de la lista
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromRGBO(217, 217, 217, 1),
                  style: BorderStyle.solid,
                  width: 1.0,
                ),
                color: const Color.fromRGBO(217, 217, 217, 1),
                borderRadius: BorderRadius.circular(20.0),
              ),

              /// Limitar tamaño de la lista
              child: LimitedBox(
                maxHeight: 170,
                child: ListView.builder(
                  /// Cambiar efecto del overscroll en la lista
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: intereses.length,
                  itemBuilder: (context, index) {
                    final interes = intereses[index];
                    return ListTile(
                      leading: const Icon(Icons.add_circle_outline_sharp),
                      title: Text(interes.nombre),
                      onTap: () async {
                        bool incluido = false;
                        for (int i = 0;
                            i < interesesSeleccionados.length;
                            i++) {
                          if (interes.id == interesesSeleccionados[i].id) {
                            incluido = true;
                            break;
                          }
                        }
                        if (!incluido) {
                          switch (await ConexionApi.insertarInteresUsuario(
                              Controlador.usuario.id, interes)) {
                            case 0:
                              setState(() {
                                Controlador.listaInteresesUsuario.add(interes);
                              });
                              break;
                            case 1:
                              break;
                            case 2:
                              break;
                          }
                        }
                      },
                    );
                  },
                ),
              )),
          const SizedBox(height: 20),
          if (interesesSeleccionados.isNotEmpty)
            Container(
              padding: const EdgeInsets.only(
                  left: 48, right: 48, top: 10, bottom: 10),
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(25, 5, 255, 1),
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: const Text(
                'INTERÉS EN',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
          const SizedBox(height: 20),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            spacing: 10.0,
            runSpacing: 8.0,
            children: interesesSeleccionados.map((interest) {
              bool seleccionado = interesesSeleccionados.contains(interest);
              return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (seleccionado) {
                        interesesSeleccionados.remove(interest);
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0750d8),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Text(
                      interest.nombre,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ));
            }).toList(),
          ),
          const SizedBox(height: 20),
        ],
      );

  /// Método searchInteres(String) para buscar un elemento en la lista general de intereses
  void searchInteres(String query) {
    if (query.isEmpty) {
      setState(() {
        intereses = Controlador.listaIntereses;
      });
    } else {
      final sugerencias = intereses.where((interes) {
        final nombreInteres = interes.nombre.toLowerCase();
        final input = query.toLowerCase();

        return nombreInteres.contains(input);
      }).toList();
      setState(() => intereses = sugerencias);
    }
  }

  void searchUsuarios(String query) {
    if (query.isEmpty) {
      setState(() {
        usuarios = Controlador.listaUsuarios;
      });
    } else {
      final sugerenciasUsuario = usuarios.where((usuario) {
        final nombreUsuario = usuario.nombre.toLowerCase();
        final input = query.toLowerCase();

        return nombreUsuario.contains(input);
      }).toList();
      setState(() => usuarios = sugerenciasUsuario);
    }
  }
}
