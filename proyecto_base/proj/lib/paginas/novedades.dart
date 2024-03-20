import 'package:flutter/material.dart';
import '../models/formacionDTO.dart';
import '../models/interes.dart';
import '../models/ofertaDTO.dart';
import '../utils/controlador.dart';


/// Clase contenedora de la pantalla de novedades de la aplicación
class Novedades extends StatefulWidget {

  @override
  State<Novedades> createState() => _NovedadesState();
}

/// Setear variables
class _NovedadesState extends State<Novedades> {
  /// Controlador de introducción de texto
  final controller = TextEditingController();
  /// lista de novedades
  List<Object> interests = [];

  @override
  void initState() {
    // TODO: implement initState
    /// Introducimos la lista de formaciones y la lista de novedades
    interests.addAll(Controlador.listaOfertas);
    interests.addAll(Controlador.listaFormaciones);
    /// Odraganizamos la lista por fecha
    interests.sort((a, b) => ((a is OfertaDTO ? a.fecha : (a as FormacionDTO).fecha)!.compareTo((b is OfertaDTO ? b.fecha : (b as FormacionDTO).fecha)!)),);
    
    interests = interests.reversed.toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
          children: <Widget>[
            //Lista de offertas
            Expanded(
              child: ListView.builder(
                itemCount: interests.length<20 ? interests.length : 20,
                itemBuilder: (context, index) {
                  final interest = interests[index];

                  return InkWell(
                    /// Mostra detalle de novedad al clicar
                    onTap: () {
                      if(interest is OfertaDTO){
                        _showInterestDialog(interest);
                      }
                      else{
                        _showInterestDialogFor(interest as FormacionDTO);
                      }
                      
                    },
                    /// Cata en la que se muetra la imagen, titulo y descripcion de la novedad
                    child: Card(
                      child: ListTile(
                        leading: Container(
                          width: 80,
                          height: 100,
                          decoration: BoxDecoration(
                            //image: DecorationImage(image: AssetImage(interest is OfertaDTO ? interest.imagen : (interest as FormacionDTO).imagen),fit: BoxFit.fitWidth)
                          )
                        ),
                        title: Text(interest is OfertaDTO ?  "OFERTA LABORAL": "CURSO"),
                        subtitle: Text(interest is OfertaDTO ? interest.titulo : (interest as FormacionDTO).titulo ),
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
          title: Text("DETALLE OFERTA",style: TextStyle(fontWeight: FontWeight.bold,)),
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
                  height: 300,
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
                /// Etiquetas de las novedades
                Text("INTERESES",style: TextStyle(fontWeight: FontWeight.bold,)),
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

  // Metodo para mostrar los detalles de una formacion
  void _showInterestDialogFor(FormacionDTO interestName) {
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
                /// Titulo de la formacion
                Text("TITULO",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                )),
                Container(
                  width: 300,
                  height: 50,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 185, 185, 185),
                      borderRadius: BorderRadius.circular(10)),
                  child: SingleChildScrollView(
                      child: Text(interestName.titulo,
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
                      child: Text(interestName.descripcion,
                          textAlign: TextAlign.justify)),
                ),
                SizedBox(
                  height: 20,
                ),

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
                            interestName.fechaInicio.day.toString() +
                            "/" +
                            interestName.fechaInicio.month.toString() +
                            "/" +
                            interestName.fechaInicio.year.toString()),
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
                            interestName.fechaFin.day.toString() +
                            "/" +
                            interestName.fechaFin.month.toString() +
                            "/" +
                            interestName.fechaFin.year.toString()),
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
                listaEtiquetas(Controlador.listaIntereses),
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