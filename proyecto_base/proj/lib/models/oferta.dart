/// clase que representa una oferta de trabajo
class Oferta {
  final int id;
  final String titulo;
  final String descripcion;
  final String requisitos;
  final int vacantes;
  final String imagen;

  ///Constructor
  const Oferta({required this.id, required this.titulo, required this.descripcion, required this.requisitos, required this.vacantes, required this.imagen});
}

///Lista para pruebas
const ofertas = [
  Oferta(id: 0, titulo: "Desarrollador web", descripcion: "Una oferta muy buena", requisitos: "que?", vacantes: 0, imagen: "assets/images/fondo.jpg"),
  Oferta(
      id: 0,
      titulo: "Desarrollador java",
      descripcion:
          "Imatia\nUna oferta muy buena asdasdasdasdasdasd asd asdasdas dasd asd sad asd as das dasd asd asd asd asd asd asd asd as asdasd asd asda sdas das das das das das das das das das dasd asd asdasdas das das das d as as dasdas",
      requisitos: "que?",
      vacantes: 0,
      imagen: "assets/images/fondo.jpg"),
  Oferta(id: 0, titulo: "Desarrollador c", descripcion: "Losan\nUna oferta muy buena", requisitos: "que?", vacantes: 0, imagen: "assets/images/fondo.jpg"),
  Oferta(id: 0, titulo: "Desarrollador c+", descripcion: "Deloite\nUna oferta muy buena", requisitos: "que?", vacantes: 0, imagen: "assets/images/fondo.jpg"),
  Oferta(id: 0, titulo: "Desarrollador c#", descripcion: "Aulanosa\nUna oferta muy buena", requisitos: "que?", vacantes: 0, imagen: "assets/images/fondo.jpg"),
];
