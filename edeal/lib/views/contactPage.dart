import 'dart:async';
import 'dart:convert';
import 'package:edeal/views/formPage.dart';
import 'package:edeal/views/homeScreen.dart';
import 'package:edeal/views/questionsPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';


class ContactScreen extends StatefulWidget {
  final String token;

  ContactScreen({required this.token, Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  late String userId;
  Map<String, dynamic> userData = {};

  final _formKey = GlobalKey<FormState>();
  TextEditingController _newDataController = TextEditingController();
  TextEditingController _valorAhorroController = TextEditingController();
  String _ahorroPara = 'Quiero ahorrar para:';
  // String _valorAhorro = 'Valor del ahorro(millones):';
  String _plazo= 'Plazo(meses):';
  bool _showTextField = false;


  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    userId = jwtDecodedToken['_id'];
    fetchUserData();
  }

  void fetchUserData() async {
    var response = await http.get(Uri.parse('https://edeal-app.onrender.com/user/$userId'));

    if (response.statusCode == 200) {
      setState(() {
        userData = jsonDecode(response.body);
      });
    } else {
      print('Error: ${response.statusCode}');
    }
  }

void saveUserData() async {
  if (_formKey.currentState!.validate()) {
    if (_valorAhorroController.text.isEmpty ||
        _plazo == 'Plazo(meses):' ||
        _ahorroPara == 'Quiero ahorrar para:'
        ) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Campos incompletos'),
            content: Text('Por favor, completa todos los campos antes de enviar el formulario.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Aceptar'),
              ),
            ],
          );
        },
      );
    } else {
      var newData = _newDataController.text;

      var response = await http.put(
        Uri.parse('https://edeal-app.onrender.com/ahorro/$userId'),
        body: {
          'ahorroPara': _ahorroPara == 'Otros' ? newData : _ahorroPara,
          'valorAhorro': _valorAhorroController.text,
          'plazoAhorro': _plazo,
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          userData['ahorroPara'] = _ahorroPara == 'Otros' ? newData : _ahorroPara;
          userData['valorAhorro'] = _valorAhorroController.text;
          userData['plazoAhorro'] = _plazo;
        });

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Información actualizada'),
              content: Text('Tu información se almacenó correctamente.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Aceptar'),
                ),
              ],
            );
          },
        );

        setState(() {
          _ahorroPara = 'Quiero ahorrar para:';
          // _valorAhorroController = '';
          _plazo = 'Plazo(meses):';
        });
      } else {
        print('Error al actualizar la información: ${response.statusCode}');
      }
    }
  }
}


  void updateSelectedOption(String? newValue) {
    setState(() {
      _ahorroPara = newValue!;
      if (newValue == 'Otros') {
        _showTextField = true;
      } else {
        _showTextField = false;
      }
    });
  }

void updatePlazoOption(String? newValue) {
  if (newValue != null && newValue != 'Plazo(meses):') {
    setState(() {
      _plazo = newValue;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF524898),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Form(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  color: Color(0XFF524898),
                  padding: EdgeInsets.symmetric(vertical: 50),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 50, bottom: 30),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  // Acción al hacer clic en el ícono "Chatea con nosotros"
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0XFFE8E112),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Chatea con nosotros',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: InkWell(
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FormContactScreen(token: widget.token)),
            )
            }, 
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0XFFE8E112),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.mail,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Envíanos un mensaje',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}