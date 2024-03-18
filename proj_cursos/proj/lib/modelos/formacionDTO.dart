
/// clase que representa una formacion
class   FormacionDTO {
  final int id;
  final String titulo;
  final String descripcion;
  final String requisitos;
  final int vacantes;
  final DateTime fechaInicio;
  final DateTime fechaFin;
  final String imagen;
 
  ///Constructor
  const FormacionDTO({
    required this.id, required this.titulo, required this.descripcion, required this.requisitos, required this.vacantes, required this.fechaInicio, required this.fechaFin,required this.imagen});
}
///Lista para pruebas
var formacion = [FormacionDTO(id: 0, titulo: "Oferta1", descripcion: "Una oferta muy buena", requisitos: "que?", vacantes: 0, fechaInicio: DateTime.now(), fechaFin: DateTime.now(),imagen: "assets/images/formacion_ejemplo.jpeg"),
FormacionDTO(id: 0, titulo: "Oferta2", descripcion: "Imatia\nUna oferta muy buena", requisitos: "que?", fechaInicio: DateTime.now(), fechaFin: DateTime.now(), vacantes: 0, imagen: "assets/images/formacion_ejemplo.jpeg"),
FormacionDTO(id: 0, titulo: "Oferta3", descripcion: "Losan\nUna oferta muy buena", requisitos: "que?", fechaInicio: DateTime.now(), fechaFin: DateTime.now(), vacantes: 0, imagen: "assets/images/formacion_ejemplo.jpeg"),
FormacionDTO(id: 0, titulo: "Oferta4", descripcion: "Deloite\nUna oferta muy buena", requisitos: "que?", fechaInicio: DateTime.now(), fechaFin: DateTime.now(), vacantes: 0, imagen: "assets/images/formacion_ejemplo.jpeg"),
FormacionDTO(id: 0, titulo: "Oferta5", descripcion: "Aulanosa\nUna oferta muy buena", requisitos: "que?", fechaInicio: DateTime.now(), fechaFin: DateTime.now(), vacantes: 0, imagen: "assets/images/formacion_ejemplo.jpeg"),];