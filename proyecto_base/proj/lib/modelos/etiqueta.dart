/// clase que representa una etiqueta
class EtiquetaDTO {
  final int id;
  final String nombre;
  
  /// Constructor
  const EtiquetaDTO({
    required this.id, required this.nombre});
}

/// Lista provisional para pruebas sin API
const etiquetas = [EtiquetaDTO(id: 0,nombre: "JAVA"),
EtiquetaDTO(id: 1,nombre: "C"),
EtiquetaDTO(id: 2,nombre: "C+"),
EtiquetaDTO(id: 3,nombre: "C#"),
EtiquetaDTO(id: 4,nombre: "dart"),
EtiquetaDTO(id: 5,nombre: "WPF"),
];