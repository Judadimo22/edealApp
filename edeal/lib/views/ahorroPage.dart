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
                        '1 mes',
                        '3 meses',
                        '6 meses',
                        '9 meses',
                        '12 meses',

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
                        '6 meses',
                        '12 meses',
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