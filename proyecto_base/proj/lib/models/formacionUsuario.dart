import 'package:proj/models/formacionDTO.dart';

class FormacionUsuario {
  FormacionDTO formacion;
  bool inscrito;
  bool interesado;

  FormacionUsuario(
      {required this.formacion,
      required this.inscrito,
      required this.interesado});
}
