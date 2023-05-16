import 'dart:async';
import 'dart:convert';
import 'package:edeal/views/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

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
  String _ahorroPara = 'Quiero ahorrar para:';
  String _valorAhorro = 'Valor del ahorro:';
  String _plazo= 'Plazo(meses):';


  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    userId = jwtDecodedToken['_id'];
    fetchUserData();
  }

  void fetchUserData() async {
    var response = await http.get(Uri.parse('http://192.168.1.108:3001/user/$userId'));

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
        Uri.parse('http://192.168.1.108:3001/ahorro/$userId'),
        body: {
          'ahorroPara': _ahorroPara,
          'valorAhorro': _valorAhorro,
          'plazoAhorro': _plazo
          },
      );

      if (response.statusCode == 200) {
        setState(() {
          userData['ahorroPara'] = _ahorroPara;
          userData['valorAhorro'] = _valorAhorro;
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

        print('Información actualizada correctamente');
        setState(() {
         _ahorroPara = 'Quiero ahorrar para:';
         _valorAhorro = 'Valor del ahorro:';
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
    });
  }

  void updateValorAhorroOption(String? newValorAhorro){
    setState(() {
    _valorAhorro = newValorAhorro!;
    });
  }

  void updatePlazoOption(String? newPlazo){
    setState(() {
    _plazo = newPlazo!;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 50),
                  child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 50),
                      child:
                      Text(
                        'Ahorro',
                        style: TextStyle(
                          fontSize: 30
                        ),
                        ),),
                    SizedBox(height: 20),
                    Container(
                      width: 374,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      color: Colors.white,
                      child: DropdownButton<String>(
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
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 374,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      color: Colors.white,
                      child: Expanded(
                        child: DropdownButton<String>(
                      value: _valorAhorro,
                      onChanged: updateValorAhorroOption,
                      items: <String>[
                        'Valor del ahorro:',
                        '1 millón',
                        '2 millones',
                        '3 millones',
                        '4 millones',
                        '5 millones',
                        '6 millones',
                        '7 millones',
                        '8 millones',
                        '9 millones',
                        '10 millones',
                        '11 milllones',
                        '12 milllones',
                        '13 millones',
                        '14 millones',
                        '15 millones',
                        '16 millones',
                        '17 millones',
                        '18 millones',
                        '19 millones',
                        '20 millones'

                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),)
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 374,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: DropdownButton<String>(
                      value: _plazo,
                      onChanged: updatePlazoOption,
                      items: <String>[
                        'Plazo(meses):',
                        '1 mes',
                        '2 meses',
                        '3 meses',
                        '4 meses',
                        '5 meses',
                        '6 meses',
                        '7 meses',
                        '8 meses',
                        '9 meses',
                        '10 meses',
                        '11 meses',
                        '12 meses',
                        '13 meses',
                        '14 meses',
                        '15 meses',
                        '16 meses',
                        '17 meses',
                        '18 meses',
                        '19 meses',
                        '20 meses',
                        '21 meses',
                        '22 meses',
                        '23 meses',
                        '24 meses'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: saveUserData,
                      child: Text('Crear mi meta de ahorro'),
                    ),
                  ],
                ),)
              ),
            ),
          ],
        ),
      ),
    );
  }
}