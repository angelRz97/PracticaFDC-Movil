import 'dart:typed_data';

class Usuario {
  int id;
  String usuario;
  String contrasena;
  String nombre;
  String apellidos;
  String email;
  String telefono;
  Enum estado;
  DateTime actualizacion;
  Uint8List imagen;

  Usuario(
      {required this.id,
      required this.usuario,
      required this.contrasena,
      required this.nombre,
      required this.apellidos,
      required this.email,
      required this.telefono,
      required this.estado,
      required this.actualizacion,
      required this.imagen});
}
