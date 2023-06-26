import 'dart:async';
import 'dart:convert';
import 'package:edeal/views/ahorroPage.dart';
import 'package:edeal/views/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class Ahorro3Screen extends StatefulWidget {
  final String token;

  Ahorro3Screen({required this.token, Key? key}) : super(key: key);

  @override
  State<Ahorro3Screen> createState() => _Ahorro3ScreenState();
}

class _Ahorro3ScreenState extends State<Ahorro3Screen> {
  late String userId;
  Map<String, dynamic> userData = {};

  final _formKey = GlobalKey<FormState>();
  TextEditingController _newDataController = TextEditingController();
  TextEditingController _valorAhorroController = TextEditingController();
  String _ahorroPara = 'Quiero ahorrar para:';
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

  Future<void> saveUserData() async {
    if (_formKey.currentState!.validate()) {
      if (_valorAhorroController.text.isEmpty ||
          _plazo == 'Plazo(meses):' ||
          _ahorroPara == 'Quiero ahorrar para:'
      ) {
        String errorMessage = '';

        if (_ahorroPara == 'Quiero ahorrar para:') {
          errorMessage = 'Por favor, selecciona una opción en Quiero ahorrar para';
        } else if (_valorAhorroController.text.isEmpty) {
          errorMessage = 'Por favor, ingresa el monto del ahorro';
        } else if (_plazo == 'Plazo(meses):') {
          errorMessage = 'Por favor, selecciona una opción en Plazo';
        }

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Campos incompletos'),
              content: Text(errorMessage),
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
          Uri.parse('https://edeal-app.onrender.com/ahorro3/$userId'),
          body: {
            'ahorro3Para': _ahorroPara == 'Otros' ? newData : _ahorroPara,
            'valorAhorro3': _valorAhorroController.text,
            'plazoAhorro3': _plazo,
          },
        );

        if (response.statusCode == 200) {
          setState(() {
            userData['ahorro3Para'] = _ahorroPara == 'Otros' ? newData : _ahorroPara;
            userData['valorAhorro3'] = _valorAhorroController.text;
            userData['plazoAhorro3'] = _plazo;
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AhorroScreen(token: widget.token),
                        ),
                      );
                    },
                    child: Text('Aceptar'),
                  ),
                ],
              );
            },
          );

          setState(() {
            _ahorroPara = 'Quiero ahorrar para:';
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
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    color: Color(0XFF524898),
                    padding: EdgeInsets.symmetric(vertical: 50),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 50),
                          child: Text(
                            'Ahorro',
                            style: TextStyle(
                                fontSize: 30, color: Colors.white),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: 374,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          color: Color(0XFF524898),
                          child: DropdownButton<String>(
                            dropdownColor: Color(0XFF524898),
                            value: _ahorroPara,
                            onChanged: updateSelectedOption,
                            items: <String>[
                              'Quiero ahorrar para:',
                              'Viaje',
                              'Celular',
                              'Evento',
                              'Estudios',
                              'Carro',
                              'Otros'
                            ].map<DropdownMenuItem<String>>(
                                (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                            }).toList(),
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        if (_showTextField)
                          Container(
                            width: 374,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              controller: _newDataController,
                              decoration: InputDecoration(
                                hintText: 'Ingrese el objetivo de ahorro',
                                hintStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Por favor, ingrese el objetivo de ahorro';
                                }
                                return null;
                              },
                            ),
                          ),
                        SizedBox(height: 20),
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: TextField(
                            controller: _valorAhorroController,
                            keyboardType: TextInputType.number,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              errorStyle: TextStyle(color: Colors.white),
                              hintText: "Monto del ahorro",
                              hintStyle: TextStyle(color: Colors.white),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                          ).p4().px12(),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: 374,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: DropdownButton<String>(
                            dropdownColor: Color(0XFF524898),
                            value: _plazo,
                            onChanged: updatePlazoOption,
                            items: <String>[
                              'Plazo(meses):',
                              '1',
                              '2',
                              '3',
                              '4',
                              '5',
                              '6',
                              '7',
                              '8',
                              '9',
                              '10',
                              '11',
                              '12',
                              '13',
                              '14',
                              '15',
                              '16',
                              '17',
                              '18',
                              '19',
                              '20'
                            ].map<DropdownMenuItem<String>>(
                                (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                            }).toList(),
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: saveUserData,
                          child: Text('Crear mi meta de ahorro',
                              style: TextStyle(fontSize: 18)),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0XFFE8E112),
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
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
