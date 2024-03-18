


import 'interes.dart';

/// clase que representa una oferta de trabajo
class OfertaDTO {
  final int id;
  final String titulo;
  final String descripcion;
  final String requisitos;
  final int vacantes;
  final String imagen;
  final List<Interes> intereses;
  
  ///Constructor
  const OfertaDTO({
    required this.id, required this.titulo, required this.descripcion, required this.requisitos, required this.vacantes, required this.imagen, required this.intereses});
}

///Lista para pruebas
const ofertas = [OfertaDTO(id: 0, titulo: "Desarrollador web", descripcion: "Una oferta muy buena", requisitos: "que?", vacantes: 0, imagen: "assets/images/fondo.jpg", intereses: listaIntereses),
OfertaDTO(id: 0, titulo: "Desarrollador java", descripcion: "Imatia\nUna oferta muy buena asdasdasdasdasdasd asd asdasdas dasd asd sad asd as das dasd asd asd asd asd asd asd asd as asdasd asd asda sdas das das das das das das das das das dasd asd asdasdas das das das d as as dasdas", requisitos: "que?", vacantes: 0, imagen: "assets/images/fondo.jpg", intereses: listaIntereses),
OfertaDTO(id: 0, titulo: "Desarrollador c", descripcion: "Losan\nUna oferta muy buena", requisitos: "que?", vacantes: 0, imagen: "assets/images/fondo.jpg", intereses: listaIntereses),
OfertaDTO(id: 0, titulo: "Desarrollador c+", descripcion: "Deloite\nUna oferta muy buena", requisitos: "que?", vacantes: 0, imagen: "assets/images/fondo.jpg", intereses: listaIntereses),
OfertaDTO(id: 0, titulo: "Desarrollador c#", descripcion: "Aulanosa\nUna oferta muy buena", requisitos: "que?", vacantes: 0, imagen: "assets/images/fondo.jpg", intereses: listaIntereses),];




