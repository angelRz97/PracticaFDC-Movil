// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';

class construirPerfil extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Center(
      child: Stack(
        children: [
          construirImagen(),
          Positioned(
            bottom: 0,
            right: 4,
            child: construirEditarIcono(color)
          )
        ],
      ),
    );
  }

  Widget construirImagen() {
    String url = 'assets/logoAulaNosa.png';
    final image = NetworkImage('https://aishlatino.b-cdn.net/wp-content/uploads/2021/11/que-tipo-de-persona-te-gustaria-ser-730x411-SP.jpg');

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
        ),
      ),
    );
  }

  Widget construirEditarIcono(Color color) => construirCirculo(
    color: Colors.white,
    all: 3,
    child: construirCirculo(
      color: color,
      all: 8,
      child: Icon(
        Icons.edit,
        color: Colors.white,
        size: 20
      )
    )
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