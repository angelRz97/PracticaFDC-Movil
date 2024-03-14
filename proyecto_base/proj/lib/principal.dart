import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'intereses/interes.dart';

class Principal extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _principal();
}

class _principal extends State<Principal> {
  static String barText = "NOVEDADES";
  static int pageIndex = 0;

  final controller = TextEditingController();
  List<Interest> interests = allInterests;

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/logo.png',
              fit: BoxFit.contain,
              height: 32,
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                barText,
                textAlign: TextAlign.end,
                style: const TextStyle(fontFamily: 'InriaSans'),
              ),
            )
          ],
        ),
        backgroundColor: const Color.fromRGBO(25, 5, 255, 1),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        index: selectedIndex,
        items: const [
          CurvedNavigationBarItem(
              child: Icon(Icons.new_releases, color: Colors.white),
              label: 'NOVEDADES',
              labelStyle: TextStyle(color: Colors.white)),
          CurvedNavigationBarItem(
              child: Icon(Icons.cases_sharp, color: Colors.white),
              label: 'OFERTAS',
              labelStyle: TextStyle(color: Colors.white)),
          CurvedNavigationBarItem(
              child: Icon(Icons.school, color: Colors.white),
              label: 'FORMACIÓN',
              labelStyle: TextStyle(color: Colors.white)),
          CurvedNavigationBarItem(
              child: Icon(Icons.person, color: Colors.white),
              label: 'USUARIO',
              labelStyle: TextStyle(color: Colors.white))
        ],
        color: const Color.fromRGBO(25, 5, 255, 1),
        buttonBackgroundColor: const Color.fromRGBO(25, 5, 255, 1),
        backgroundColor: const Color.fromRGBO(25, 5, 255, 1),
        onTap: (index) {
          setState(() {});
          if (index == 0) {
            barText = "NOVEDADES";
            pageIndex = 0;
          }
          if (index == 1) {
            barText = "OFERTAS";
            pageIndex = 1;
          }
          if (index == 2) {
            barText = "FORMACIÓN";
            pageIndex = 2;
          }
          if (index == 3) {
            barText = "USUARIO";
            pageIndex = 3;
          }
        },
      ),
      body: mostrarPag(pageIndex),
    );
  }

  setBarText(barText) {
    if (selectedIndex == 0) {
      barText = "OFERTAS LABORALES";
    } else if (selectedIndex == 1) {
      barText = "NOVEDADES";
    } else if (selectedIndex == 2) barText = "FORMACIÓN";
  }

  mostrarPag(index) {
    if (index == 0) {
      return Container(
          child: const Center(
              child: Text("pagina 1",
                  style: TextStyle(fontFamily: 'GowunDodum'))));
    }
    if (index == 1) {
      return Container(child: const Center(child: Text("pagina 2")));
    }
    if (index == 2) {
      return Container(child: const Center(child: Text("pagina 3")));
    }
    if (index == 3) {
      return pagina4();
    }
  }

  Widget pagina4() {
    return Container(
        child: Column(
      children: <Widget>[
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
        Expanded(
          child: ListView.builder(
            itemCount: interests.length,
            itemBuilder: (context, index) {
              final interest = interests[index];

              return ListTile(
                leading: const Icon(Icons.person),
                title: Text(interest.name),
              );
            },
          ),
        )
      ],
    ));
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
