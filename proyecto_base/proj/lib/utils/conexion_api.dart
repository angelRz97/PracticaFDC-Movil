import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:proj/models/usuario.dart';
import 'package:proj/utils/controlador.dart';
import 'package:proj/utils/controlador_encriptacion.dart';

/// Clase para realizar las peticiones a la API
class ConexionApi {
  static String url = "http://10.0.2.2:8080/";

  /// Devuelve un entero en función del resultado de la petición de login a la api
  static Future<int> login(String email, String contrasena) async {
    print(contrasena);
    String peticion = "${url}api/login";
    String emailEncriptado = ControladorEncriptacion.encriptar(email);
    try {
      // Se realiza la petición
      final respuesta = await http.post(Uri.parse(peticion),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'nombre': emailEncriptado,
            'contrasena': contrasena,
          }));
      final respuestaDecodificada = utf8.decode(respuesta.bodyBytes);
      // Se recogen los datos
      Map<String, dynamic> datosRespuesta = jsonDecode(respuestaDecodificada);
      List<dynamic> errores = datosRespuesta["errores"];
      if (errores.isNotEmpty) {
        // Si hay errores se devuelve 1
        return 1;
      } else {
        Controlador.usuario = Usuario(
            id: datosRespuesta["usuario"]["id"],
            usuario: ControladorEncriptacion.desencriptar(datosRespuesta["usuario"]["usuario"]),
            contrasena: contrasena,
            nombre: ControladorEncriptacion.desencriptar(datosRespuesta["usuario"]["nombre"]),
            apellidos: ControladorEncriptacion.desencriptar(datosRespuesta["usuario"]["apellidos"]),
            email: ControladorEncriptacion.desencriptar(datosRespuesta["usuario"]["email"]),
            telefono: ControladorEncriptacion.desencriptar(datosRespuesta["usuario"]["telefono"]),
            estado: datosRespuesta["usuario"]["estado"] == "EMPLEADO" ? Estado.EMPLEADO : Estado.DESEMPLEADO,
            actualizacion: DateTime.parse(datosRespuesta["usuario"]["actualizacion"]),
            imagen: datosRespuesta["usuario"]["imagen"]);
      }
    } catch (e) {
      // Si hubo algún problema con la ejecución se devuelve 2
      return 2;
    }
    // Todo correcto
    return 0;
  }

  /// Devuelve un entero en función del resultado de la petición de login a la api
  static Future<int> actualizar() async {
    String peticion = "${url}api/usuarios";
    try {
      // Se realiza la petición
      print(Controlador.usuario.estado.name);
      final respuesta = await http.put(Uri.parse(peticion),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'id': Controlador.usuario.id,
            'usuario': ControladorEncriptacion.encriptar(Controlador.usuario.usuario),
            'contrasena': Controlador.usuario.contrasena,
            'nombre': ControladorEncriptacion.encriptar(Controlador.usuario.nombre),
            'apellidos': ControladorEncriptacion.encriptar(Controlador.usuario.apellidos),
            'email': ControladorEncriptacion.encriptar(Controlador.usuario.email),
            'telefono': ControladorEncriptacion.encriptar(Controlador.usuario.telefono),
            'imagen': Controlador.usuario.imagen,
            'estado': Controlador.usuario.estado.name
          }));

      final respuestaDecodificada = utf8.decode(respuesta.bodyBytes);
      // Se recogen los datos
      Map<String, dynamic> datosRespuesta = jsonDecode(respuestaDecodificada);
      List<dynamic> errores = datosRespuesta["errores"];
      if (errores.isNotEmpty) {
        // Si hay errores se devuelve 1
        for (int i = 0; i < errores.length; i++) {
          print(errores[i]);
        }
        return 1;
      } else {
        Controlador.usuario = Usuario(
            id: datosRespuesta["usuario"]["id"],
            usuario: ControladorEncriptacion.desencriptar(datosRespuesta["usuario"]["usuario"]),
            contrasena: Controlador.usuario.contrasena,
            nombre: ControladorEncriptacion.desencriptar(datosRespuesta["usuario"]["nombre"]),
            apellidos: ControladorEncriptacion.desencriptar(datosRespuesta["usuario"]["apellidos"]),
            email: ControladorEncriptacion.desencriptar(datosRespuesta["usuario"]["email"]),
            telefono: ControladorEncriptacion.desencriptar(datosRespuesta["usuario"]["telefono"]),
            estado: datosRespuesta["usuario"]["estado"] == "EMPLEADO" ? Estado.EMPLEADO : Estado.DESEMPLEADO,
            actualizacion: DateTime.parse(datosRespuesta["usuario"]["actualizacion"]),
            imagen: datosRespuesta["usuario"]["imagen"]);
      }
    } catch (e) {
      // Si hubo algún problema con la ejecución se devuelve 2
      print(e);
      print("ID:" + Controlador.usuario.id.toString());
      print("Usuario:" + Controlador.usuario.usuario);
      print("Contra:" + Controlador.usuario.contrasena);
      print("Name:" + Controlador.usuario.nombre);
      print("Ap:" + Controlador.usuario.apellidos);
      print("mail:" + Controlador.usuario.email);
      print("telef:" + Controlador.usuario.telefono.toString());
      return 2;
    }
    // Todo correcto
    return 0;
  }
}
