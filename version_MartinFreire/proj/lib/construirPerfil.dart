// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class construirPerfil extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _perfil();
}

class _perfil extends State<construirPerfil> {
  File ? imagenSeleccionada;
  String ruta = 'assets/persona.png';

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Center(
      child: Stack(
        children: [construirImagen(), Positioned(bottom: 0, right: 4, child: construirEditarIcono(color))],
      ),
    );
  }

  Widget construirImagen() {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: 
        imagenSeleccionada != null ? Image.file(imagenSeleccionada!,fit: BoxFit.cover,width: 128,height: 128,) : Image.asset('assets/persona.png', fit: BoxFit.cover, width: 128, height: 128),
      ),
    );
  }

  Future<void> _seleccionarFoto() async {
    final imagenDevuelta = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (imagenDevuelta != null) {imagenSeleccionada = File(imagenDevuelta.path);}
    });
  }

  Widget construirEditarIcono(Color color) => Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Color(0xFF0750d8),
    ),
    padding: EdgeInsets.all(8),
    child: GestureDetector(
      onTap: () {
        _seleccionarFoto();
      },
      child: Icon(
        Icons.edit,
        color: Colors.white,
        size: 20
      ),
    ),
  );

  Widget construirCirculo({
    required Widget child,
    required double all,
    required Color color
  }) => ClipOval(
    child: Container(
      padding: EdgeInsets.all(all),
      color: color,
      child: child
    ),
  );
}
