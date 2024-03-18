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
    String peticion = "${url}api/login";
    String emailEncriptado = ControladorEncriptacion.ecriptar(email);
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
            usuario: ControladorEncriptacion.desencriptar(
                datosRespuesta["usuario"]["usuario"]),
            contrasena: datosRespuesta["usuario"]["contrasena"],
            nombre: ControladorEncriptacion.desencriptar(
                datosRespuesta["usuario"]["nombre"]),
            apellidos: ControladorEncriptacion.desencriptar(
                datosRespuesta["usuario"]["apellidos"]),
            email: ControladorEncriptacion.desencriptar(
                datosRespuesta["usuario"]["email"]),
            telefono: ControladorEncriptacion.desencriptar(
                datosRespuesta["usuario"]["telefono"]),
            estado: datosRespuesta["usuario"]["estado"] == "EMPLEADO"
                ? Estado.EMPLEADO
                : Estado.DESEMPLEADO,
            actualizacion:
                DateTime.parse(datosRespuesta["usuario"]["actualizacion"]),
            imagen: datosRespuesta["usuario"]["imagen"]);
      }
    } catch (e) {
      // Si hubo algún problema con la ejecución se devuelve 2
      return 2;
    }
    // Todo correcto
    return 0;
  }
}
