import 'dart:typed_data';

import 'package:proj/models/interes.dart';
import 'package:proj/models/ofertaDTO.dart';

/// clase que representa una formacion
class FormacionDTO {
  int id;
  String titulo;
  String descripcion;
  List<Interes> intereses;
  DateTime fechaInicio;
  DateTime fechaFin;
  Uint8List? imagen;
  EstadoOfertas estado;
  int coste;
  DateTime? fecha;

  ///Constructor
  FormacionDTO(
      {required this.id,
      required this.titulo,
      required this.descripcion,
      required this.intereses,
      required this.fechaInicio,
      required this.fechaFin,
      required this.imagen,
      required this.estado,
      required this.coste,
      required this.fecha});
}

///Lista para pruebas
// var formacion = [
//   FormacionDTO(
//       id: 0,
//       titulo: "Oferta1",
//       descripcion: "Una oferta muy buena",
//       intereses: Controlador.listaIntereses,
//       coste: 0,
//       fechaInicio: DateTime.now(),
//       fechaFin: DateTime.now(),
//       imagen: null,
//       estado: EstadoOfertas.ABIERTA,
//       fecha: DateTime.now()),
//   FormacionDTO(
//       id: 0,
//       titulo: "Oferta2",
//       descripcion: "Imatia\nUna oferta muy buena",
//       intereses: Controlador.listaIntereses,
//       fechaInicio: DateTime.now(),
//       fechaFin: DateTime.now(),
//       coste: 0,
//       imagen: null,
//       estado: EstadoOfertas.ABIERTA,
//       fecha: DateTime.now()),
//   FormacionDTO(
//       id: 0,
//       titulo: "Oferta3",
//       descripcion: "Losan\nUna oferta muy buena",
//       intereses: Controlador.listaIntereses,
//       fechaInicio: DateTime.now(),
//       fechaFin: DateTime.now(),
//       coste: 0,
//       imagen: null,
//       estado: EstadoOfertas.ABIERTA,
//       fecha: DateTime.now()),
//   FormacionDTO(
//       id: 0,
//       titulo: "Oferta4",
//       descripcion: "Deloite\nUna oferta muy buena",
//       intereses: Controlador.listaIntereses,
//       fechaInicio: DateTime.now(),
//       fechaFin: DateTime.now(),
//       coste: 0,
//       imagen: null,
//       estado: EstadoOfertas.ABIERTA,
//       fecha: DateTime.now()),
//   FormacionDTO(
//       id: 0,
//       titulo: "Oferta5",
//       descripcion: "Aulanosa\nUna oferta muy buena",
//       intereses: Controlador.listaIntereses,
//       fechaInicio: DateTime.now(),
//       fechaFin: DateTime.now(),
//       coste: 0,
//       imagen: null,
//       estado: EstadoOfertas.ABIERTA,
//       fecha: DateTime.now()),
// ];
