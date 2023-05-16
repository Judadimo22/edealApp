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
                      child:
                      Text(
                        'Crédito',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white
                        ),
                        ),),
                    SizedBox(height: 20),
                    Container(
                      width: 374,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      color: Color(0XFF524898),
                      child: DropdownButton<String>(
                      dropdownColor: Color(0XFF524898) ,
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
                          child: Text(
                            value,
                            style: TextStyle(
                              color: Colors.white,
                          ),
                          ),
                        );
                      }).toList(),
                      icon:  Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                    ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 374,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      color: Color(0XFF524898),
                      child: Expanded(
                        child: DropdownButton<String>(
                      dropdownColor: Color(0XFF524898) ,
                      value: _tarjetaCredito,
                      onChanged: updateTarjetaOption,
                      items: <String>[
                        'Tengo tarjeta de crédito:',
                        'Si',
                        'No'
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
                      icon:  Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                    ),)
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 374,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: DropdownButton<String>(
                      dropdownColor: Color(0XFF524898) ,
                      value: _banco,
                      onChanged: updateBancoOption,
                      items: <String>[
                        'Con cual banco:',
                        'Banco de Bogotá',
                        'Banco Popular',
                        'Coorbanca',
                        'Bancolombia',
                        'Banco CITIBANK',
                        'HSBC Colombia',
                        'Banco GNB Sudameris',
                        'BBVA Colombia ',
                        'Helm Bank',
                        'MULTIBANCA COLPATRIA',
                        'Banco de Occidente',
                        'Banco Caja Social ',
                        'Banco Davivienda',
                        'Banco AV Villas',
                        'Fiduciaria Skandia',
                        'Banco Pichincha S.A',
                        'Banco Coomeva S.A.',
                        'Banco Procredit',
                        'Banco Falabella',
                        'Coltefinanciera',
                        'Coopcentral'
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
                      icon:  Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                    ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0XFFE8E112)),
                    ),
                      onPressed: saveUserData,
                      child: Text('Solicitar crédito'),
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



