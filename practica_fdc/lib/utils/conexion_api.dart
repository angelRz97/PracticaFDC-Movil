import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practica_fdc/utils/controlador.dart';
import 'package:practica_fdc/utils/controlador_encriptacion.dart';

class ConexionApi {
  static String url = "http://194.164.166.106:3306/";

  static Future<int> login(String email, String contrasena) async {
    String peticion = "${url}api/login";
    String emailEncriptado = ControladorEncriptacion.ecriptar(email);
    try {
      final respuesta = await http.post(Uri.parse(peticion),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'email': emailEncriptado,
            'claveAcceso': contrasena,
          }));
      final respuestaDecodificada = utf8.decode(respuesta.bodyBytes);
      Map<String, dynamic> datosRespuesta = jsonDecode(respuestaDecodificada);
      List<dynamic> errores = datosRespuesta["errores"];
      if (errores.isNotEmpty) {
        return 1;
      } else {
        Controlador.usuario = datosRespuesta["usuario"];
      }
    } catch (e) {
      return 2;
    }
    return 0;
  }
}
