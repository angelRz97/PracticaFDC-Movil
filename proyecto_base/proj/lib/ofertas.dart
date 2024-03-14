import 'package:flutter/material.dart';
import 'package:proj/intereses/interes.dart';
import '/principal.dart';

class Ofertas extends StatefulWidget {

  @override
  State<Ofertas> createState() => _OfertasState();
}

class _OfertasState extends State<Ofertas> {
  final controller = TextEditingController();
  List<Interest> interests = allInterests;

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

                  return ListTile(
                    leading: Icon(Icons.person),
                    title: Text(interest.name),
                  );
                },
              ),
            )
          ],
        );
  }
  void searchInterest(String query) {
    final suggestions = allInterests.where((interest) {
      final interestName = interest.name.toLowerCase();
      final input = query.toLowerCase();

      return interestName.contains(input);
    }).toList();

    setState(() => interests = suggestions);
  }
}    