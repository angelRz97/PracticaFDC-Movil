// ignore_for_file: use_key_in_widget_constructors, curly_braces_in_flow_control_structures, camel_case_types

import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import '../interes.dart';

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
  List<Interes> intereses = listaIntereses;

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
                style: const TextStyle(fontFamily: 'InriaSans'),
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
              "NOVEDADES", Icon(Icons.new_releases, color: Colors.white)),
          footerItem("OFERTAS", Icon(Icons.cases, color: Colors.white)),
          footerItem("FORMACIÓN", Icon(Icons.school, color: Colors.white)),
          footerItem("USUARIO", Icon(Icons.person, color: Colors.white))
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
      return const Center(child: Text("pagina 2"));
    }
    if (index == 2) {
      return const Center(child: Text("pagina 3"));
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
    return Column(
      children: <Widget>[
        /// Crear barra de búsqueda
        Container(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: TextField(
              /// Llamar al controlador
              controller: controller,

              /// Setear icono, texto y forma de la barra
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Buscar',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),

              /// Setear función de la barra
              onChanged: searchInteres,
            )),

        /// Mostrar lista general de intereses
        Expanded(
          child: ListView.builder(
            itemCount: intereses.length,
            itemBuilder: (context, index) {
              final interes = intereses[index];
              return ListTile(
                leading: const Icon(Icons.person),
                title: Text(interes.nombre),
              );
            },
          ),
        )
      ],
    );
  }

  /// Método searchInteres(String) para buscar un elemento en la lista general de intereses
  void searchInteres(String query) {
    final sugerencias = listaIntereses.where((interes) {
      final nombreInteres = interes.nombre.toLowerCase();
      final input = query.toLowerCase();

      return nombreInteres.contains(input);
    }).toList();
    setState(() => intereses = sugerencias);
  }
}