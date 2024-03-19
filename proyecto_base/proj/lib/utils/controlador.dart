import 'package:proj/models/formacionDTO.dart';
import 'package:proj/models/interes.dart';
import 'package:proj/models/usuario.dart';
import 'package:proj/paginas/ofertas.dart';

import '../models/ofertaDTO.dart';

// Clase Controladora que recibirá los datos de la api
class Controlador {
  static late Usuario usuario;
  static List<Interes> listaIntereses = [];
  static List<OfertaDTO> listaOfertas = [];
  static List<FormacionDTO> listaFormaciones = [];
}
