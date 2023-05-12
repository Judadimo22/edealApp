import 'dart:async';
import 'dart:convert';
import 'package:edeal/views/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class CreditoScreen extends StatefulWidget {
  final String token;

  CreditoScreen({required this.token, Key? key}) : super(key: key);

  @override
  State<CreditoScreen> createState() => _CreditoScreenState();
}

class _CreditoScreenState extends State<CreditoScreen> {
  late String userId;
  Map<String, dynamic> userData = {};

  final _formKey = GlobalKey<FormState>();
  TextEditingController _newDataController = TextEditingController();
  String _creditoPara = 'Me gustaría un crédito para:';
  String _tarjetaCredito = 'Tengo tarjeta de crédito:';
  String _banco = 'Con cual banco:';


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
        Uri.parse('http://192.168.1.108:3001/credit/$userId'),
        body: {
          'credito': _creditoPara,
          'tarjetaDeCredito': _tarjetaCredito,
          'bancoCredito': _banco
          },
      );

      if (response.statusCode == 200) {
        setState(() {
          userData['credit'] = _creditoPara;
          userData['tarjetaDeCredito'] = _tarjetaCredito;
          userData['bancoCredito'] = _banco;
        });

        print('Información actualizada correctamente');
        setState(() {
         _creditoPara = 'Me gustaría un crédito para:';
         _tarjetaCredito = 'Tengo tarjeta de crédito:';
         _banco = 'Con cual banco:';
      });
      } else {
        print('Error al actualizar la información: ${response.statusCode}');
      }
    }
  }

  void updateSelectedOption(String? newValue) {
    setState(() {
      _creditoPara = newValue!;
    });
  }

  void updateTarjetaOption(String? newTarjeta){
    setState(() {
    _tarjetaCredito = newTarjeta!;
    });
  }

  void updateBancoOption(String? newBanco){
    setState(() {
    _banco = newBanco!;
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
                        'Crédito',
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
                      value: _creditoPara,
                      onChanged: updateSelectedOption,
                      items: <String>[
                        'Me gustaría un crédito para:',
                        'Gastos Personales',
                        'Celular',
                        'Bajar la tase de interés de mi trajeta de crédito',
                        'Hacer mercado',
                        'Pagar deudas'
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
                      value: _tarjetaCredito,
                      onChanged: updateTarjetaOption,
                      items: <String>[
                        'Tengo tarjeta de crédito:',
                        'Si',
                        'No'
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
                      value: _banco,
                      onChanged: updateBancoOption,
                      items: <String>[
                        'Con cual banco:',
                        'Davivienda',
                        'Bancolombia',
                        'Colpatria'
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
                      child: Text('Guardar'),
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



