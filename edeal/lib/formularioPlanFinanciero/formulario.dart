import 'dart:convert';
import 'package:edeal/formularioPlanFinanciero/informacionPersonal.dart';
import 'package:edeal/views/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class Formulario extends StatefulWidget {
  @override
  _FormularioState createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  List<Item> _items = [
    Item(headerValue: 'Panel 1', expandedValue: 'Formulario 1', isExpanded: false),
    Item(headerValue: 'Panel 2', expandedValue: 'Formulario 2', isExpanded: false),
    Item(headerValue: 'Panel 3', expandedValue: 'Formulario 3', isExpanded: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Desplegable con Formulario'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: ExpansionPanelList(
            elevation: 1,
            expandedHeaderPadding: EdgeInsets.zero,
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                _items[index].isExpanded = !isExpanded;
              });
            },
            children: _items.map<ExpansionPanel>((Item item) {
              return ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text(item.headerValue),
                  );
                },
                body: item.isExpanded
                    ? Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.expandedValue),
                            SizedBox(height: 16.0),
                            // Aquí puedes colocar el formulario
                            // Puedes usar cualquier widget de formulario, como TextFormField, DropdownButton, etc.
                            // Ejemplo:
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Campo de texto'),
                            ),
                            SizedBox(height: 16.0),
                            ElevatedButton(
                              onPressed: () {
                                // Acción al enviar el formulario
                              },
                              child: Text('Enviar'),
                            ),
                          ],
                        ),
                      )
                    : SizedBox.shrink(),
                isExpanded: item.isExpanded,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class Item {
  String headerValue;
  String expandedValue;
  bool isExpanded;

  Item({required this.headerValue, required this.expandedValue, required this.isExpanded});
}