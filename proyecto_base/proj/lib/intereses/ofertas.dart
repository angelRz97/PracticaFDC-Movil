
class OfertasDTO {
  final int id;
  final String titulo;
  final String descripcion;
  final String requisitos;
  final int vacantes;
  final String imagen;
  

  const OfertasDTO({
    required this.id, required this.titulo, required this.descripcion, required this.requisitos, required this.vacantes, required this.imagen});
}

const ofertas = [OfertasDTO(id: 0, titulo: "Oferta1", descripcion: "Una oferta muy buena", requisitos: "que?", vacantes: 0, imagen: ""),
OfertasDTO(id: 0, titulo: "Oferta2", descripcion: "Imatia\nUna oferta muy buena asdasdasdasdasdasd asd asdasdas dasd asd sad asd as das dasd asd asd asd asd asd asd asd as asdasd asd asda sdas das das das das das das das das das dasd asd asdasdas das das das d as as dasdas", requisitos: "que?", vacantes: 0, imagen: ""),
OfertasDTO(id: 0, titulo: "Oferta3", descripcion: "Losan\nUna oferta muy buena", requisitos: "que?", vacantes: 0, imagen: ""),
OfertasDTO(id: 0, titulo: "Oferta4", descripcion: "Deloite\nUna oferta muy buena", requisitos: "que?", vacantes: 0, imagen: ""),
OfertasDTO(id: 0, titulo: "Oferta5", descripcion: "Aulanosa\nUna oferta muy buena", requisitos: "que?", vacantes: 0, imagen: ""),];




