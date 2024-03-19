import 'dart:typed_data';

import 'package:proj/utils/controlador.dart';

import 'interes.dart';

/// clase que representa una oferta de trabajo
class OfertaDTO {
  int id;
  String titulo;
  String descripcion;
  int vacantes;
  List<Interes> intereses;
  EstadoOfertas estado;
  DateTime? fecha;
  Uint8List? imagen;

  ///Constructor
  OfertaDTO(
      {required this.id,
      required this.titulo,
      required this.descripcion,
      required this.vacantes,
      required this.imagen,
      required this.intereses,
      required this.estado,
      required this.fecha});
}

enum EstadoOfertas { ABIERTA, CERRADA }

///Lista para pruebas
final ofertas = [
  OfertaDTO(
      id: 0,
      titulo: "Desarrollador web",
      descripcion: "Una oferta muy buena",
      //requisitos: "que?",
      vacantes: 0,
      imagen: null,
      intereses: Controlador.listaIntereses,
      estado: EstadoOfertas.ABIERTA,
      fecha: null),
  OfertaDTO(
      id: 0,
      titulo: "Desarrollador java",
      descripcion:
          "Imatia\nUna oferta muy buena asdasdasdasdasdasd asd asdasdas dasd asd sad asd as das dasd asd asd asd asd asd asd asd as asdasd asd asda sdas das das das das das das das das das dasd asd asdasdas das das das d as as dasdas",
      // requisitos: "que?",
      vacantes: 0,
      imagen: null,
      intereses: Controlador.listaIntereses,
      estado: EstadoOfertas.ABIERTA,
      fecha: null),
  OfertaDTO(
      id: 0,
      titulo: "Desarrollador c",
      descripcion: "Losan\nUna oferta muy buena",
      //requisitos: "que?",
      vacantes: 0,
      imagen: null,
      intereses: Controlador.listaIntereses,
      estado: EstadoOfertas.ABIERTA,
      fecha: null),
  OfertaDTO(
      id: 0,
      titulo: "Desarrollador c+",
      descripcion: "Deloite\nUna oferta muy buena",
      // requisitos: "que?",
      vacantes: 0,
      imagen: null,
      intereses: Controlador.listaIntereses,
      estado: EstadoOfertas.ABIERTA,
      fecha: null),
  OfertaDTO(
      id: 0,
      titulo: "Desarrollador c#",
      descripcion: "Aulanosa\nUna oferta muy buena",
      // requisitos: "que?",
      vacantes: 0,
      imagen: null,
      intereses: Controlador.listaIntereses,
      estado: EstadoOfertas.ABIERTA,
      fecha: null),
];
