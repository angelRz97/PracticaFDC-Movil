import 'package:flutter/material.dart';
import 'package:proj/intereses/interes.dart';
import 'package:proj/intereses/ofertas.dart';
import '/principal.dart';

class Ofertas extends StatefulWidget {

  @override
  State<Ofertas> createState() => _OfertasState();
}

class _OfertasState extends State<Ofertas> {
  final controller = TextEditingController();
  List<OfertasDTO> interests = ofertas;

  @override
  Widget build(BuildContext context) {
    return Column(
          children: <Widget>[
            Container(
                margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search), hintText: 'Buscar', border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: Colors.red))),
                  onChanged: searchInterest,
                )),
            Expanded(
              child: ListView.builder(
                itemCount: interests.length,
                itemBuilder: (context, index) {
                  final interest = interests[index];

                  return InkWell(
                    onTap: () {
                      _showInterestDialog(interest);
                    },
                    child: Card(
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text(interest.titulo),
                        subtitle: subtitulo(interest.descripcion),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        );
  }

  Widget subtitulo (String texto){
    texto = texto.split("\n")[0];
    if(texto.length >20){
      texto = texto.substring(0,20);
    }
    return Text(texto);
  }

  void searchInterest(String query) {
    final suggestions = ofertas.where((interest) {
      final interestName = interest.titulo.toLowerCase();
      final input = query.toLowerCase();

      return interestName.contains(input);
    }).toList();

    setState(() => interests = suggestions);
  }

  void _showInterestDialog(OfertasDTO interestName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Detalle formacion",style: TextStyle(fontWeight: FontWeight.bold,)),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Titulo",style: TextStyle(fontWeight: FontWeight.bold,)),
                Container(
                  width: 300,
                  height: 50,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 161, 166, 235),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Text(interestName.titulo),
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Descripcion",style: TextStyle(fontWeight: FontWeight.bold,)),
                Container(
                  width: 300,
                  height: 150,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 161, 166, 235),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Text(interestName.descripcion),
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Requisitos",style: TextStyle(fontWeight: FontWeight.bold,)),
                Container(
                  width: 300,
                  height: 150,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 161, 166, 235),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Text(interestName.requisitos),
                )
              ],
            ),
          ),
          actions: <Widget>[
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
}    