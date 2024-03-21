import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:proj/models/formacionDTO.dart';
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
  List<FormacionDTO> interests = Controlador.listaFormaciones;

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
                        subtitle: Text(interest.titulo),
                        trailing: const Icon(Icons.check_circle_outline_rounded, color: Color.fromARGB(255, 0, 255, 34)),
                      ),
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
    final suggestions = formacion.where((interest) {
      final interestName = interest.titulo.toLowerCase();
      final input = query.toLowerCase();

      return interestName.contains(input);
    }).toList();

    setState(() => interests = suggestions);
  }

  // Metodo para mostrar los detalles de una formacion
  void _showInterestDialog(FormacionDTO interestName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("DETALLE FORMACION",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Titulo de la formacion y vacantes
                const Row(
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
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 185, 185, 185),
                      borderRadius: BorderRadius.circular(10)),
                  child: SingleChildScrollView(
                      child: Text(interestName.titulo,
                          textAlign: TextAlign.justify)),
                ),
                const SizedBox(
                  height: 20,
                ),

                /// Descripcion de la formacion
                const Text("DESCRIPCION",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                Container(
                  width: 300,
                  height: 300,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 185, 185, 185),
                      borderRadius: BorderRadius.circular(10)),
                  child: SingleChildScrollView(
                      child: Text(interestName.descripcion,
                          textAlign: TextAlign.justify)),
                ),
                const SizedBox(
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
                const Text("DURACION DEL CURSO",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 185, 185, 185),
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Text("Inicio: " +
                            interestName.fechaInicio.day.toString() +
                            "/" +
                            interestName.fechaInicio.month.toString() +
                            "/" +
                            interestName.fechaInicio.year.toString()),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 185, 185, 185),
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Text("Fin: " +
                            interestName.fechaFin.day.toString() +
                            "/" +
                            interestName.fechaFin.month.toString() +
                            "/" +
                            interestName.fechaFin.year.toString()),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),

                /// Etiquetas dde intereses
                const Text("INTERESES",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )),

                /// Lista provisional de etiquetas a espera de la API
                listaEtiquetas(interestName.intereses),
              ],
            ),
          ),

          /// Botones para cerrar e inscribirse
          actions: <Widget>[
            /// Boton a espera de API
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Inscribirse'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
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
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(25, 5, 255, 1),
                  borderRadius: BorderRadius.circular(5)),
              child: Text(
                etiqueta[i].nombre,
                style: const TextStyle(color: Colors.white),
              ),
            ),
        ]);
  }
}
