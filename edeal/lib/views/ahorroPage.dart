import 'dart:async';
import 'dart:convert';
import 'package:edeal/views/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:velocity_x/velocity_x.dart';

class AhorroScreen extends StatefulWidget {
  final String token;

  AhorroScreen({required this.token, Key? key}) : super(key: key);

  @override
  State<AhorroScreen> createState() => _AhorroScreenState();
}

class _AhorroScreenState extends State<AhorroScreen> {
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

  // void updateValorAhorroOption(String? newValorAhorro){
  //   setState(() {
  //     _valorAhorro = newValorAhorro!;
  //   });
  // }

void updatePlazoOption(String? newValue) {
  if (newValue != null && newValue != 'Plazo(meses):') {
    setState(() {
      _plazo = newValue;
    });
  }
}

  @override
  Widget build(BuildContext context) {
      if (userData['ahorroPara'] != null &&
      userData['valorAhorro'] != null &&
      userData['plazoAhorro'] != null) {
      double valorAhorro = double.parse(userData['valorAhorro']);
      int plazoAhorro = int.parse(userData['plazoAhorro']);
      double metaAhorroMes = (valorAhorro / plazoAhorro);
    return Scaffold(
      backgroundColor: Color(0XFF524898),
      body: Center(
        child: Text(
      'La meta de ahorro es de : \$${metaAhorroMes.toStringAsFixed(2)}',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  } else {
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
                          fontSize: 30,
                          color: Colors.white
                        ),
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
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: Colors.white
                              ),
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
    style: TextStyle(color: Colors.white), // Cambiar el color del texto que se ingresa
    decoration: InputDecoration(
      errorStyle: TextStyle(color: Colors.white),
      hintText: "Monto del ahorro",
      hintStyle: TextStyle(color: Colors.white),
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red), // Cambiar el color del borde inferior
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
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: Colors.white
                              ),
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
                      child: Text('Crear mi meta de ahorro', style: TextStyle(fontSize: 18)),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0XFFE8E112),
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
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
}






