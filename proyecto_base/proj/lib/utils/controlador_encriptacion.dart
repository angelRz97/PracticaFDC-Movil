import 'package:encrypt/encrypt.dart';

// Clase encargada de la encriptación de los datos
class ControladorEncriptacion {
  static final clave = Key.fromUtf8("4rbgenERAdfeku ... afw ff4fa1121");
  static final iv = IV.fromBase64("123asd1q");
  static late Encrypter encriptador;

  // Devuelveu un String encriptado
  static String ecriptar(String cadena) {
    encriptador = Encrypter(AES(clave));
    final encriptado = encriptador.encrypt(cadena, iv: iv);
    return encriptado.base64;
  }

  // Desencripta el String que se le pase
  static String desencriptar(String cadena) {
    encriptador = Encrypter(AES(clave));
    final encriptado = Encrypted.from64(cadena);
    final desencriptado = encriptador.decrypt(encriptado, iv: iv);
    return desencriptado;
  }
}
