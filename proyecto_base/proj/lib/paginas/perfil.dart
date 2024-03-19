import 'package:flutter/material.dart';
import 'package:proj/models/usuario.dart';
import 'package:proj/utils/conexion_api.dart';

import '../models/interes.dart';
import '../utils/controlador.dart';
import '../construirPerfil.dart';

class Perfil extends StatefulWidget {
  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  final nombreController =
      TextEditingController(text: Controlador.usuario.nombre);
  final apellidosController =
      TextEditingController(text: Controlador.usuario.apellidos);
  final emailController =
      TextEditingController(text: Controlador.usuario.email);
  final telefonoController =
      TextEditingController(text: Controlador.usuario.telefono);

  /// Controlador de introducción de texto
  final controller = TextEditingController();

  /// Lista general de intereses
  List<Interes> intereses = Controlador.listaIntereses;

  /// Lista de intereses que has seleccionado
  List<Interes> interesesSeleccionados = [];

  /// Texto default del estado del perfil
  String estado = Controlador.usuario.estado.name;

  @override
  Widget build(BuildContext context) {
    if (Controlador.usuario.email == "admin@admin") {
      return Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Buscar',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.red))),
              onChanged: searchInteres,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.person),
                  title: Text("Controlador.usuario.usuario"),
                );
              },
            ),
          ),
        ],
      );
    } else {
      return ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 30),

          /// Funcion para construir la imagen y poder editar la imagen
          construirPerfil(),
          const SizedBox(height: 24),

          /// Funcion para construir el apartado de estado e intereses
          construirNombre(
              Controlador.usuario.nombre,
              Controlador.usuario.apellidos,
              Controlador.usuario.email,
              Controlador.usuario.telefono),
        ],
      );
    }
  }

  Widget construirNombre(nombre, apellidos, email, telefono) => Column(
        children: [
          TextFormField(
            controller: nombreController,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          TextFormField(
            controller: apellidosController,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          TextFormField(
            controller: emailController,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          TextFormField(
            controller: telefonoController,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 20),
          // Text(nombre + " " + apellidos, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
          // const SizedBox(height: 4),
          // Text(email, style: const TextStyle(color: Colors.grey, fontSize: 18)),
          // const SizedBox(height: 20),
          IconButton(
            icon: Icon(Icons.abc),
            onPressed: () {
              Controlador.usuario.nombre = nombreController.text;
              Controlador.usuario.apellidos = apellidosController.text;
              Controlador.usuario.email = emailController.text;
              Controlador.usuario.telefono = telefonoController.text;
              ConexionApi.actualizar();
            },
          ),
          Container(
            padding: const EdgeInsets.only(
                left: 120, right: 120, top: 10, bottom: 10),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(25, 5, 255, 1),
            ),
            child: const Text(
              'ESTADO',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.only(left: 35, right: 20),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 206, 206, 206),
            ),
            child: DropdownButton<String>(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              value: estado,
              onChanged: (String? newValue) {
                setState(() {
                  estado = newValue!;
                });
              },
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              icon: const Icon(Icons.arrow_drop_down,
                  color: Color.fromRGBO(25, 5, 255, 1)),
              iconSize: 50,
              items: [Estado.DESEMPLEADO.name, Estado.EMPLEADO.name]
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.only(
                left: 103, right: 103, top: 10, bottom: 10),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(25, 5, 255, 1),
            ),
            child: const Text(
              'INTERESES',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
          Container(
              height: 40,
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromRGBO(217, 217, 217, 1),
                  style: BorderStyle.solid,
                  width: 1.0,
                ),

                /// Setear color de la barra
                color: const Color.fromRGBO(217, 217, 217, 1),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: TextField(
                /// Llamar al controlador
                controller: controller,

                /// Setear icono, texto y forma de la barra
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),

                /// Setear función de la barra
                onChanged: searchInteres,
              )),
          Container(
              margin: const EdgeInsets.fromLTRB(30, 0, 30, 10),

              /// Setear color de fondo de la lista
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromRGBO(217, 217, 217, 1),
                  style: BorderStyle.solid,
                  width: 1.0,
                ),
                color: const Color.fromRGBO(217, 217, 217, 1),
                borderRadius: BorderRadius.circular(20.0),
              ),

              /// Limitar tamaño de la lista
              child: LimitedBox(
                maxHeight: 170,
                child: ListView.builder(
                  /// Cambiar efecto del overscroll en la lista
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: intereses.length,
                  itemBuilder: (context, index) {
                    final interes = intereses[index];
                    return ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(interes.nombre),
                      onTap: () {
                        setState(() {
                          if (interesesSeleccionados.contains(interes)) {
                            interesesSeleccionados.remove(interes);
                          } else {
                            interesesSeleccionados.add(interes);
                          }
                        });
                      },
                    );
                  },
                ),
              )),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.center,
            spacing: 10.0,
            runSpacing: 8.0,
            children: interesesSeleccionados.map((interest) {
              bool seleccionado = interesesSeleccionados.contains(interest);
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: seleccionado
                      ? const Color.fromRGBO(25, 5, 255, 1)
                      : Colors.grey[700],
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text(
                  interest.nombre,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
        ],
      );

  /// Método searchInteres(String) para buscar un elemento en la lista general de intereses
  void searchInteres(String query) {
    if (query.isEmpty) {
      setState(() {
        intereses = Controlador.listaIntereses;
      });
    } else {
      final sugerencias = intereses.where((interes) {
        final nombreInteres = interes.nombre.toLowerCase();
        final input = query.toLowerCase();

        return nombreInteres.contains(input);
      }).toList();
      setState(() => intereses = sugerencias);
    }
  }
}
