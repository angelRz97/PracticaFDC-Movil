// ignore_for_file: use_key_in_widget_constructors, curly_braces_in_flow_control_structures, camel_case_types

import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:proj/paginas/formacion.dart';
import 'novedades.dart';
import 'ofertas.dart';
import 'perfil.dart';

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
                style: const TextStyle(fontFamily: 'InriaSans', color: Colors.white),
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
          footerItem("NOVEDADES", const Icon(Icons.new_releases, color: Colors.white)),
          footerItem("OFERTAS", const Icon(Icons.cases_rounded, color: Colors.white)),
          footerItem("FORMACIÓN", const Icon(Icons.school, color: Colors.white)),
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
      return Novedades();
    }
    if (index == 1) {
      return Ofertas();
    }
    if (index == 2) {
      return Formacion();
    }
    if (index == 3) {
      /// Llamar al widget paginaUsuario()
      return Perfil();
    }
  }

  /// Función footerItem(String, Icon) para definir cada elemento de la NavigationBar
  footerItem(String texto, Icon icono) {
    return CurvedNavigationBarItem(child: icono, label: texto, labelStyle: const TextStyle(color: Colors.white));
  }
}
