import 'package:flutter/material.dart';

class Formacion{
  final int id;
  final String descripcion;
  final String requisitos;
  final DateTime fecha;
  final DateTime fin;
  final int coste;
  final Image imagen;

  Formacion(this.id, this.descripcion, this.requisitos, this.fecha, this.fin, this.coste, this.imagen);
}