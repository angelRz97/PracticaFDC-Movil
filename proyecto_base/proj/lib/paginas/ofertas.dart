import 'package:flutter/material.dart';
import 'package:proj/modelos/interes.dart';

import '../modelos/ofertaDTO.dart';


/// Clase contenedora de la pantalla de ofertas de la aplicación
class Ofertas extends StatefulWidget {

  @override
  State<Ofertas> createState() => _OfertasState();
}

/// Setear variables
class _OfertasState extends State<Ofertas> {
  /// Controlador de introducción de texto
  final controller = TextEditingController();
  /// lista de ofertas
  List<OfertaDTO> interests = ofertas;

  @override
  Widget build(BuildContext context) {
    return Column(
          children: <Widget>[
            /// Crear un buscador que filtra ofertas segun el texto
            Container(
                margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search), hintText: 'Buscar', border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: Colors.red))),
                  onChanged: searchInterest,
                )),
            //Lista de offertas
            Expanded(
              child: ListView.builder(
                itemCount: interests.length,
                itemBuilder: (context, index) {
                  final interest = interests[index];

                  return InkWell(
                    /// Mostra detalle de oferta al clicar
                    onTap: () {
                      _showInterestDialog(interest);
                    },
                    /// Cata en la que se muetra la imagen, titulo y descripcion de la oferta
                    child: Card(
                      child: ListTile(
                        leading: Container(width: 80,height: 100,decoration: BoxDecoration(image: DecorationImage(image: AssetImage(interest.imagen),fit: BoxFit.fitWidth))),
                        title: Text("OFERTA LABORAL"),
                        subtitle: Text(interest.titulo),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        );
  }

  /// Metodo para el buscador
  void searchInterest(String query) {
    final suggestions = ofertas.where((interest) {
      final interestName = interest.titulo.toLowerCase();
      final input = query.toLowerCase();

      return interestName.contains(input);
    }).toList();

    setState(() => interests = suggestions);
  }

  // Metodo para mostrar los detalles de una oferta
  void _showInterestDialog(OfertaDTO interestName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("DETALLE OFERTAS",style: TextStyle(fontWeight: FontWeight.bold,)),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Titulo de la oferta y vacantes
                Row(
                  children: [
                    Text("TITULO",style: TextStyle(fontWeight: FontWeight.bold,)),
                    Spacer(),
                    Text("VACANTES: "+interestName.vacantes.toString(),style: TextStyle(fontWeight: FontWeight.bold,),),
                  ],
                ),
                Container(
                  width: 300,
                  height: 50,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 185, 185, 185),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: SingleChildScrollView(child: Text(interestName.titulo, textAlign: TextAlign.justify)),
                ),
                SizedBox(
                  height: 20,
                ),
                /// Descripcion de la oferta
                Text("DESCRIPCION",style: TextStyle(fontWeight: FontWeight.bold,)),
                Container(
                  width: 300,
                  height: 150,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 185, 185, 185),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: SingleChildScrollView(child: Text(interestName.descripcion, textAlign: TextAlign.justify)),
                ),
                SizedBox(
                  height: 20,
                ),
                /// Requisito de la oferta
                Text("REQUISITOS",style: TextStyle(fontWeight: FontWeight.bold,)),
                Container(
                  width: 300,
                  height: 150,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 185, 185, 185),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: SingleChildScrollView(child: Text(interestName.requisitos, textAlign: TextAlign.justify)),
                ),
                SizedBox(
                  height: 20,
                ),
                /// Etiquetas de las ofertas
                Text("INTERESES",style: TextStyle(fontWeight: FontWeight.bold,)),
                /// Lista provisional de etiquetas a espera de la API
                listaEtiquetas(listaIntereses),
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
              child: Text('Inscribirse'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  /// Metodo que devuelve un widget con las etiquetas de la oferta
  Widget listaEtiquetas(List<Interes> etiqueta){
    return Wrap(
      spacing: MediaQuery.of(context).size.width * 0.02,
      runSpacing: 10.0,
      children: [
        for(int i = etiqueta.length-1; i>=0 ; i--)
        /// Etiqueta
        Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(25, 5, 255, 1),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  child: Text(etiqueta[i].nombre, style: TextStyle(color: Colors.white),),
                ),
      ]
    );
  }
}    