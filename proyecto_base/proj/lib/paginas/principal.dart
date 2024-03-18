// ignore_for_file: use_key_in_widget_constructors, curly_braces_in_flow_control_structures, camel_case_types

import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:proj/models/usuario.dart';
import 'package:proj/paginas/formacion.dart';
import 'package:proj/paginas/ofertas.dart';
import '../construirPerfil.dart';
import '../models/interes.dart';
import '../utils/controlador.dart';

/// Clase contenedora de la pantalla principal de la aplicación
class Principal extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _principal();
}

/// Setear variables
class _principal extends State<Principal> {
  /// Texto que se mostrará en la AppBar
  static String barText = "NOVEDADES";

  /// Página en la que se encuentra el usuario
  static int selectedIndex = 0;

  /// Controlador de introducción de texto
  final controller = TextEditingController();

  /// Lista general de intereses
  List<Interes> intereses = Controlador.listaIntereses;

  /// Lista de intereses que has seleccionado
  List<Interes> interesesSeleccionados = [];

  /// Texto default del estado del perfil
  String estado = Controlador.usuario.estado.name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /// Setear icono de Aula Nosa en la parte izquierda de la AppBar
        /// y el texto de la pestaña en la parte derecha
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/logo.png',
              fit: BoxFit.contain,
              height: 35,
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                barText,
                textAlign: TextAlign.end,
                style: const TextStyle(
                    fontFamily: 'InriaSans', color: Colors.white),
              ),
            )
          ],
        ),
        backgroundColor: const Color.fromRGBO(25, 5, 255, 1),
      ),
      backgroundColor: Colors.white,

      /// Crear la NavigationBar y definir cuatro elementos
      bottomNavigationBar: CurvedNavigationBar(
        animationDuration: Duration.zero,
        height: 60,
        index: selectedIndex,
        items: [
          footerItem(
              "NOVEDADES", const Icon(Icons.new_releases, color: Colors.white)),
          footerItem(
              "OFERTAS", const Icon(Icons.cases_rounded, color: Colors.white)),
          footerItem(
              "FORMACIÓN", const Icon(Icons.school, color: Colors.white)),
          footerItem("USUARIO", const Icon(Icons.person, color: Colors.white))
        ],
        color: const Color.fromRGBO(25, 5, 255, 1),
        buttonBackgroundColor: const Color.fromRGBO(25, 5, 255, 1),
        backgroundColor: const Color.fromRGBO(25, 5, 255, 1),

        /// Setear el texto de la AppBar
        /// y la pestaña en la que se encuentra el usuario cada vez que hace click en un elemento
        onTap: (index) {
          setState(() {});
          if (index == 0) {
            barText = "NOVEDADES";
            selectedIndex = index;
          }
          if (index == 1) {
            barText = "OFERTAS";
            selectedIndex = index;
          }
          if (index == 2) {
            barText = "FORMACIÓN";
            selectedIndex = index;
          }
          if (index == 3) {
            barText = "USUARIO";
            selectedIndex = index;
          }
        },
      ),

      /// Llamar a la función mostrarPag()
      body: mostrarPag(selectedIndex),
    );
  }

  /// Función mostrarPag() para mostrar la página correspondiente
  mostrarPag(index) {
    if (index == 0) {
      return const Center(
          child: Text("pagina 1", style: TextStyle(fontFamily: 'GowunDodum')));
    }
    if (index == 1) {
      return Ofertas();
    }
    if (index == 2) {
      return Formacion();
    }
    if (index == 3) {
      /// Llamar al widget paginaUsuario()
      return paginaUsuario();
    }
  }

  /// Función footerItem(String, Icon) para definir cada elemento de la NavigationBar
  footerItem(String texto, Icon icono) {
    return CurvedNavigationBarItem(
        child: icono,
        label: texto,
        labelStyle: const TextStyle(color: Colors.white));
  }

  /// Widget paginaUsuario() que muestra la pagina correspondiente al perfil del usuario
  Widget paginaUsuario() {
    if (Controlador.usuario.email == "admin@admin") {
      return Column(
        children: [
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
                  leading: const Icon(Icons.person),
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
              "${Controlador.usuario.nombre} ${Controlador.usuario.apellidos}",
              Controlador.usuario.email),
        ],
      );
    }
  }

  Widget construirNombre(nombre, email) => Column(
        children: [
          Text(nombre,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
          const SizedBox(height: 4),
          Text(email, style: const TextStyle(color: Colors.grey, fontSize: 18)),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.only(
                left: 120, right: 120, top: 10, bottom: 10),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(25, 5, 255, 1),
            ),
            child: const Text(
              'ESTADO',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.only(left: 35, right: 20),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 206, 206, 206),
            ),
            child: DropdownButton<String>(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              value: estado,
              onChanged: (String? newValue) {
                setState(() {
                  estado = newValue!;
                });
              },
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
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
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.only(
                left: 103, right: 103, top: 10, bottom: 10),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(25, 5, 255, 1),
            ),
            child: const Text(
              'INTERESES',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
          Container(
              height: 40,
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
                      leading: const Icon(Icons.person),
                      title: Text(interes.nombre),
                      onTap: () {
                        setState(() {
                          if (interesesSeleccionados.contains(interes)) {
                            interesesSeleccionados.remove(interes);
                          } else {
                            interesesSeleccionados.add(interes);
                          }
                        });
                      },
                    );
                  },
                ),
              )),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            spacing: 10.0,
            runSpacing: 8.0,
            children: interesesSeleccionados.map((interest) {
              bool seleccionado = interesesSeleccionados.contains(interest);
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: seleccionado
                      ? const Color.fromRGBO(25, 5, 255, 1)
                      : Colors.grey[700],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text(
                  interest.nombre,
                  style: const TextStyle(color: Colors.white),
                ),
              );
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
}
