import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:proj/models/formacionDTO.dart';
import 'package:proj/models/formacionUsuario.dart';
import 'package:proj/models/interes.dart';
import 'package:proj/models/ofertaDTO.dart';
import 'package:proj/models/usuario.dart';
import 'package:proj/utils/controlador.dart';
import 'package:proj/utils/controlador_encriptacion.dart';

/// Clase para realizar las peticiones a la API
class ConexionApi {
  static String url = "http://194.164.166.106/aulanosa/";

  /// Devuelve un entero en función del resultado de la petición de login a la api
  static Future<int> login(String email, String contrasena) async {
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
            usuario: ControladorEncriptacion.desencriptar(
                datosRespuesta["usuario"]["usuario"]),
            contrasena: contrasena,
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

  /// Devuelve un entero en función del resultado de la petición de login a la api
  static Future<int> actualizar() async {
    String peticion = "${url}api/usuarios";
    try {
      // Se realiza la petición
      final respuesta = await http.put(Uri.parse(peticion),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'id': Controlador.usuario.id,
            'usuario':
                ControladorEncriptacion.encriptar(Controlador.usuario.usuario),
            'contrasena': Controlador.usuario.contrasena,
            'nombre':
                ControladorEncriptacion.encriptar(Controlador.usuario.nombre),
            'apellidos': ControladorEncriptacion.encriptar(
                Controlador.usuario.apellidos),
            'email':
                ControladorEncriptacion.encriptar(Controlador.usuario.email),
            'telefono':
                ControladorEncriptacion.encriptar(Controlador.usuario.telefono),
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
            usuario: ControladorEncriptacion.desencriptar(
                datosRespuesta["usuario"]["usuario"]),
            contrasena: Controlador.usuario.contrasena,
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

  /// Metodo para recuperar la lista de todos los intereses de la bd. Devuelve un entero en función del resultado.
  static Future<int> recuperaIntereses() async {
    String peticion = "${url}api/etiquetas";
    try {
      // Se realiza la petición
      final respuesta = await http.get(
        Uri.parse(peticion),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      // Se recogen los datos
      final respuestaDecodificada = utf8.decode(respuesta.bodyBytes);
      Map<String, dynamic> datosRespuesta = jsonDecode(respuestaDecodificada);
      List<dynamic> errores = datosRespuesta["errores"];
      if (errores.isNotEmpty) {
        // Existen errores
        print(errores);
        return 1;
      } else {
        // Se guardan las etiquetas en el controlador
        List<dynamic> etiquetas = datosRespuesta["etiquetas"];
        for (int i = 0; i < etiquetas.length; i++) {
          Interes interes =
              Interes(id: etiquetas[i]["id"], nombre: etiquetas[i]["nombre"]);
          Controlador.listaIntereses.add(interes);
        }
      }
    } catch (e) {
      // Error en la ejecución
      print(e);
      return 2;
    }
    // Todo ok
    return 0;
  }

  // Realiza una petición a la api para recuperar las lista de ofertas y formaciones
  static Future<int> recuperaNovedades() async {
    String peticion = "${url}api/novedades";
    try {
      // Se realiza la petición
      final respuesta = await http.get(
        Uri.parse(peticion),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      // Se recogen los datos
      final respuestaDecodificada = utf8.decode(respuesta.bodyBytes);
      Map<String, dynamic> datosRespuesta = jsonDecode(respuestaDecodificada);
      Map<String, dynamic> datosOfertas = datosRespuesta["ofertas"];
      Map<String, dynamic> datosFormaciones = datosRespuesta["formaciones"];

      //Ofertas o = Ofertas.fromJson(datosRespuesta["ofertas"]);

      List<dynamic> listaOfertas = datosOfertas["ofertas"];
      List<dynamic> listaFormaciones = datosFormaciones["listaFormaciones"];

      //Lista ofertas
      for (int i = 0; i < listaOfertas.length; i++) {
        OfertaDTO oferta = OfertaDTO(
            id: listaOfertas[i]["id"],
            titulo: listaOfertas[i]["titulo"],
            descripcion: listaOfertas[i]["descripcion"],
            vacantes: listaOfertas[i]["vacantes"],
            imagen: listaOfertas[i]["imagen"],
            intereses: getIntereses(listaOfertas[i]["requisitos"]),
            estado: listaOfertas[i]["estado"] == "ABIERTA"
                ? EstadoOfertas.ABIERTA
                : EstadoOfertas.CERRADA,
            fecha: listaOfertas[i]["fecha"] == null
                ? null
                : DateTime.parse(listaOfertas[i]["fecha"]));
        Controlador.listaOfertas.add(oferta);
      }

      //Lista formaciones
      for (int i = 0; i < listaFormaciones.length; i++) {
        FormacionDTO formacion = FormacionDTO(
            id: listaFormaciones[i]["id"],
            titulo: listaFormaciones[i]["titulo"],
            descripcion: listaFormaciones[i]["descripcion"],
            intereses: getIntereses(listaFormaciones[i]["requisitos"]),
            fechaInicio: DateTime.parse(listaFormaciones[i]["inicio"]),
            fechaFin: DateTime.parse(listaFormaciones[i]["fin"]),
            imagen: listaFormaciones[i]["imagen"],
            estado: listaFormaciones[i]["estado"] == "ABIERTA"
                ? EstadoOfertas.ABIERTA
                : EstadoOfertas.CERRADA,
            coste: listaFormaciones[i]["coste"],
            fecha: listaFormaciones[i]["fecha"] == null
                ? null
                : DateTime.parse(listaFormaciones[i]["fecha"]));
        Controlador.listaFormaciones.add(formacion);
      }
    } catch (e) {
      // Hubo errores en la ejecución
      print(e);
      return 2;
    }
    // Todo correcto
    return 0;
  }

  /// Inscribe al usuario que se le pase en la formación que se le pase.
  static Future<int> inscribirFormacion(int idUsuario, int idFormacion) async {
    String peticion = "${url}api/formaciones/$idFormacion/inscripciones";
    try {
      // Se realiza la petición
      final respuesta = await http.post(Uri.parse(peticion),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{"usuarioId": idUsuario}));
      final respuestaDecodificada = utf8.decode(respuesta.bodyBytes);
      Map<String, dynamic> datosRespuesta = jsonDecode(respuestaDecodificada);
      List<dynamic> errores = datosRespuesta["mensajes"];
      if (errores.isNotEmpty) {
        // Hay errores
        return 1;
      }
    } catch (e) {
      // Errores en la ejecución
      print(e);
      return 2;
    }
    // Todo ok
    return 0;
  }

  /// Recupera los intereses del usuario
  static Future<int> interesesUsuario(int idUsuario) async {
    String peticion = "${url}api/usuarios/$idUsuario/intereses";
    try {
      // Se realiza la petición
      final respuesta = await http.get(
        Uri.parse(peticion),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      final respuestaDecodificada = utf8.decode(respuesta.bodyBytes);
      Map<String, dynamic> datosRespuesta = jsonDecode(respuestaDecodificada);
      List<dynamic> errores = datosRespuesta["errores"];
      if (errores.isNotEmpty) {
        // Hay errores
        print(errores);
        return 1;
      } else {
        // Se guardan las etiquetas en el controlador
        List<dynamic> etiquetas = datosRespuesta["etiquetas"];
        for (int i = 0; i < etiquetas.length; i++) {
          Interes interes =
              Interes(id: etiquetas[i]["id"], nombre: etiquetas[i]["nombre"]);
          Controlador.listaInteresesUsuario.add(interes);
        }
      }
    } catch (e) {
      // Errores en la ejecución
      print(e);
      return 2;
    }
    // Todo ok
    return 0;
  }

  /// Inserta intereses de usuario en la bd
  static Future<int> insertarInteresUsuario(
      int idUsuario, Interes interes) async {
    String peticion = "${url}api/usuarios/$idUsuario/intereses";
    try {
      // Se realiza la petición
      final respuesta = await http.post(Uri.parse(peticion),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
              <String, dynamic>{"id": interes.id, "nombre": interes.nombre}));
      final respuestaDecodificada = utf8.decode(respuesta.bodyBytes);
      Map<String, dynamic> datosRespuesta = jsonDecode(respuestaDecodificada);
      List<dynamic> errores = datosRespuesta["mensajes"];
      if (errores.isNotEmpty) {
        // Hay errores
        print(errores);
        return 1;
      }
    } catch (e) {
      // Errores en la ejecución
      print(e);
      return 2;
    }
    // Todo ok
    return 0;
  }

  /// Metodo para recuperar la lista de todos los usuarios de la bd. Devuelve un entero en función del resultado.
  static Future<int> recuperaUsuarios() async {
    String peticion = "${url}api/admin/usuarios/listar";
    try {
      // Se realiza la petición
      final respuesta = await http.get(
        Uri.parse(peticion),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      // Se recogen los datos
      final respuestaDecodificada = utf8.decode(respuesta.bodyBytes);
      Map<String, dynamic> datosRespuesta = jsonDecode(respuestaDecodificada);
      List<dynamic> errores = datosRespuesta["errores"];
      if (errores.isNotEmpty) {
        // Existen errores
        return 1;
      } else {
        // Se guardan las usuarios en el controlador
        List<dynamic> usuarios = datosRespuesta["usuarios"];
        for (int i = 0; i < usuarios.length; i++) {
          Usuario usuario = Usuario(
              id: usuarios[i]["id"],
              usuario:
                  ControladorEncriptacion.desencriptar(usuarios[i]["usuario"]),
              contrasena: usuarios[i]["contrasena"],
              nombre:
                  ControladorEncriptacion.desencriptar(usuarios[i]["nombre"]),
              apellidos: ControladorEncriptacion.desencriptar(
                  usuarios[i]["apellidos"]),
              email: ControladorEncriptacion.desencriptar(usuarios[i]["email"]),
              telefono:
                  ControladorEncriptacion.desencriptar(usuarios[i]["telefono"]),
              actualizacion: usuarios[i]["actualizacion"],
              estado: usuarios[i]["estado"],
              imagen: usuarios[i]["imagen"]);
          Controlador.listaUsuarios.add(usuario);
        }
      }
    } catch (e) {
      // Error en la ejecución
      return 2;
    }
    // Todo ok
    return 0;
  }

  static Future<int> formacionesConInteres(int idUsuario) async {
    String peticion = "${url}api/formaciones/$idUsuario/usuarios";
    try {
      // Se realiza la petición
      final respuesta = await http.get(
        Uri.parse(peticion),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      // Se recogen los datos
      final respuestaDecodificada = utf8.decode(respuesta.bodyBytes);
      Map<String, dynamic> datosRespuesta = jsonDecode(respuestaDecodificada);
      List<dynamic> formaciones = datosRespuesta["formacionUsuarioDTOS"];
      List<dynamic> errores = datosRespuesta["errores"];
      if (errores.isNotEmpty) {
        print(errores);
        return 1;
      } else {
        for (int i = 0; i < formaciones.length; i++) {
          FormacionDTO formacionDTO = FormacionDTO(
              id: formaciones[i]["formacionDTO"]["id"],
              titulo: formaciones[i]["formacionDTO"]["titulo"],
              descripcion: formaciones[i]["formacionDTO"]["descripcion"],
              intereses:
                  getIntereses(formaciones[i]["formacionDTO"]["requisitos"]),
              fechaInicio:
                  DateTime.parse(formaciones[i]["formacionDTO"]["inicio"]),
              fechaFin: DateTime.parse(formaciones[i]["formacionDTO"]["fin"]),
              imagen: formaciones[i]["formacionDTO"]["imagen"],
              estado: formaciones[i]["formacionDTO"]["estado"] == "ABIERTA"
                  ? EstadoOfertas.ABIERTA
                  : EstadoOfertas.CERRADA,
              coste: formaciones[i]["formacionDTO"]["coste"],
              fecha: formaciones[i]["formacionDTO"]["fecha"] == null
                  ? null
                  : DateTime.parse(formaciones[i]["formacionDTO"]["fecha"]));
          FormacionUsuario formacionUsuario = FormacionUsuario(
              formacion: formacionDTO,
              inscrito: formaciones[i]["inscrito"],
              interesado: formaciones[i]["interesado"]);
          Controlador.listaFormacionesConInteres.add(formacionUsuario);
        }
      }
    } catch (e) {
      // Hubo errores en la ejecución
      print(e);
      return 2;
    }
    // Todo correcto
    return 0;
  }

  static List<Interes> getIntereses(List<dynamic> listaIntereses) {
    List<Interes> lista = [];
    for (int i = 0; i < listaIntereses.length; i++) {
      for (int x = 0; x < Controlador.listaIntereses.length; x++) {
        if (Controlador.listaIntereses[x].id == int.parse(listaIntereses[i])) {
          lista.add(Controlador.listaIntereses[x]);
          break;
        }
      }
    }
    return lista;
  }
}
