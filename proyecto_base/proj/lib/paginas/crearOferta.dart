import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/interes.dart';
import '../utils/controlador.dart';

class CrearOferta extends StatefulWidget {
  @override
  State<CrearOferta> createState() => _CrearOfertaState();
}

class _CrearOfertaState extends State<CrearOferta> {
  final tituloController =
      TextEditingController();
  final vacantesController =
      TextEditingController();
  final descripcionController =
      TextEditingController();

  bool ocultarContrasena1 = true;
  bool ocultarContrasena2 = true;

  /// Controlador de introducción de texto
  final controller = TextEditingController();

  /// Lista general de intereses
  List<Interes> intereses = Controlador.listaIntereses;

  /// Lista de intereses que has seleccionado
  List<Interes> interesesSeleccionados = [];


  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.chevron_left),),
        title: const Text('Crear Oferta', style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: tituloController,
                      decoration: InputDecoration(
                        labelText: 'Titulo',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Campo Vacio';
                        }
                        return '';
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: vacantesController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Vacantes',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Campo Vacio';
                        }
                        return '';
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: descripcionController,
                      decoration: InputDecoration(
                        labelText: 'Descripción',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Campo Vacio';
                        }
                        return '';
                      },
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 40,
                      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
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
                      const SizedBox(height: 10),
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
                                leading: const Icon(Icons.add_circle_outline_sharp),
                                title: Text(interes.nombre),
                                onTap: () {
                                  setState(() {
                                    if (!interesesSeleccionados.contains(interes)) {
                                      interesesSeleccionados.add(interes);
                                    }
                                  });
                                },
                              );
                            },
                          ),
                        )),
                    const SizedBox(height: 20),
                    if (interesesSeleccionados.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.only(left: 48, right: 48, top: 10, bottom: 10),
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(25, 5, 255, 1),
                        borderRadius: BorderRadius.all(Radius.circular(50))
                      ),
                      child: const Text(
                        'INTERESES',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.center,
                      spacing: 10.0,
                      runSpacing: 8.0,
                      children: interesesSeleccionados.map((interest) {
                        bool seleccionado = interesesSeleccionados.contains(interest);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (seleccionado) {
                                interesesSeleccionados.remove(interest);
                              }
                            });
                          }, 
                          child: Container(
                            padding:  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0750d8),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Text(
                              interest.nombre,
                              style: const TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          )
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                            formKey.currentState?.validate();
                            if (tituloController.text.isNotEmpty && 
                              vacantesController.text.isNotEmpty &&  
                              descripcionController.text.isNotEmpty) {
                                setState(() {
                                  
                                  Navigator.of(context).pop();
                                });
                            }
                        }, 
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0750d8), 
                          side: BorderSide.none, 
                          shape: const StadiumBorder()
                        ), 
                        child: const Text('CREAR', 
                          style: TextStyle(color: Colors.white),
                        )
                      )
                    ),
                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }
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