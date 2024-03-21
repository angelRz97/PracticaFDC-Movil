// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:proj/models/formacionUsuario.dart';
import 'package:proj/utils/conexion_api.dart';
import 'package:proj/utils/controlador.dart';

import '../models/interes.dart';

/// Clase contenedora de la pantalla de Formacion de la aplicación
class Formacion extends StatefulWidget {
  @override
  State<Formacion> createState() => _FormacionState();
}

/// Setear variables
class _FormacionState extends State<Formacion> {
  /// Controlador de introducción de texto
  final controller = TextEditingController();

  /// lista de Formacion
  List<FormacionUsuario> interests = Controlador.listaFormacionesConInteres;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        /// Crear un buscador que filtra Formacion segun el texto
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
              onChanged: searchInterest,
            )),
        //Lista de ofertas
        Expanded(
          child: ListView.builder(
            itemCount: interests.length,
            itemBuilder: (context, index) {
              final interest = interests[index];

              return InkWell(
                /// Mostra detalle de formacion al clickar
                onTap: () {
                  _showInterestDialog(interest);
                },

                /// Cata en la que se muetra la imagen, titulo y descripcion de la formacion
                child: Card(
                  elevation: 4,
                  child: Column(
                    children: [
                      ListTile(
                        leading: Container(
                          width: 80,
                          height: 100,
                          decoration: BoxDecoration(
                            //image: DecorationImage(
                            //  image: AssetImage(interest.imagen),
                            //  fit: BoxFit.fitWidth
                            //)
                            color: Colors.grey.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 10,
                                offset: const Offset(0,3)
                              )
                            ]
                          ),
                        ),
                        title: const Text("CURSO"),
                        subtitle: Text(interest.formacion.titulo),
                        trailing: interest.inscrito ? const Icon(Icons.check_circle_outline_rounded, color: Color.fromARGB(255, 0, 255, 34)) : null,
                      ),
                      if (interest.interesado)
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        height: 5,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xFF0750d8),
                              width: 5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              );
            },
          ),
        )
      ],
    );
  }

  /// Metodo para el buscador
  void searchInterest(String query) {
    final suggestions =
        Controlador.listaFormacionesConInteres.where((interest) {
      final interestName = interest.formacion.titulo.toLowerCase();
      final input = query.toLowerCase();

      return interestName.contains(input);
    }).toList();

    setState(() => interests = suggestions);
  }

  // Metodo para mostrar los detalles de una formacion
  void _showInterestDialog(FormacionUsuario interestName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("DETALLE FORMACION",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Titulo de la formacion y vacantes
                Row(
                  children: [
                    Text("TITULO",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                    Spacer(),
                    // Text(
                    //   "VACANTES: " + interestName.vacantes.toString(),
                    //   style: TextStyle(
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                  ],
                ),
                Container(
                  width: 300,
                  height: 50,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 185, 185, 185),
                      borderRadius: BorderRadius.circular(10)),
                  child: SingleChildScrollView(
                      child: Text(interestName.formacion.titulo,
                          textAlign: TextAlign.justify)),
                ),
                SizedBox(
                  height: 20,
                ),

                /// Descripcion de la formacion
                Text("DESCRIPCION",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                Container(
                  width: 300,
                  height: 300,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 185, 185, 185),
                      borderRadius: BorderRadius.circular(10)),
                  child: SingleChildScrollView(
                      child: Text(interestName.formacion.descripcion,
                          textAlign: TextAlign.justify)),
                ),
                SizedBox(
                  height: 20,
                ),

                /// Requisito de la formacion
                // Text("REQUISITOS",
                //     style: TextStyle(
                //       fontWeight: FontWeight.bold,
                //     )),
                // Container(
                //   width: 300,
                //   height: 150,
                //   padding: EdgeInsets.all(10),
                //   decoration: BoxDecoration(
                //       color: Color.fromARGB(255, 185, 185, 185),
                //       borderRadius: BorderRadius.circular(10)),
                //   child: SingleChildScrollView(
                //       child: Text(interestName.requisitos,
                //           textAlign: TextAlign.justify)),
                // ),
                // SizedBox(
                //   height: 20,
                // ),

                /// fechas de incio y final del las formaciones
                Text("DURACION DEL CURSO",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 185, 185, 185),
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Text("Inicio: " +
                            interestName.formacion.fechaInicio.day.toString() +
                            "/" +
                            interestName.formacion.fechaInicio.month
                                .toString() +
                            "/" +
                            interestName.formacion.fechaInicio.year.toString()),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 185, 185, 185),
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Text("Fin: " +
                            interestName.formacion.fechaFin.day.toString() +
                            "/" +
                            interestName.formacion.fechaFin.month.toString() +
                            "/" +
                            interestName.formacion.fechaFin.year.toString()),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),

                /// Etiquetas dde intereses
                Text("INTERESES",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),

                /// Lista provisional de etiquetas a espera de la API
                listaEtiquetas(interestName.formacion.intereses),
              ],
            ),
          ),

          /// Botones para cerrar e inscribirse
          actions: <Widget>[
            /// Boton a espera de API
            TextButton(
              onPressed: () async {
                switch (await ConexionApi.inscribirFormacion(
                    Controlador.usuario.id, interestName.formacion.id)) {
                  case 0:
                    Navigator.of(context).pop();
                    break;
                  case 1:
                    break;
                  case 2:
                    break;
                }
              },
              child: interestName.inscrito ? Text('Desuscribirse') : Text('Inscribirse'),
            ),
            TextButton(
              onPressed: () {
                if (!interestName.inscrito) {
                  Navigator.of(context).pop();
                }
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  /// Metodo que devuelve un widget con las etiquetas de la formacion
  Widget listaEtiquetas(List<Interes> etiqueta) {
    return Wrap(
        spacing: MediaQuery.of(context).size.width * 0.02,
        runSpacing: 10.0,
        children: [
          for (int i = etiqueta.length - 1; i >= 0; i--)

            /// Etiqueta
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(25, 5, 255, 1),
                  borderRadius: BorderRadius.circular(5)),
              child: Text(
                etiqueta[i].nombre,
                style: TextStyle(color: Colors.white),
              ),
            ),
        ]);
  }
}
