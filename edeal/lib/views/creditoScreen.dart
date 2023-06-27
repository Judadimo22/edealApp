import 'dart:async';
import 'dart:convert';
import 'package:edeal/views/creditoScreen2.dart';
import 'package:edeal/views/creditoScreen3.dart';
import 'package:edeal/views/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:velocity_x/velocity_x.dart';
import 'dart:math';


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
  TextEditingController _montoCreditoController = TextEditingController();
  String _creditoPara = 'Me gustaría un crédito para:';
  String _tarjetaCredito = 'Tengo tarjeta de crédito:';
  String _banco = 'Con cual banco:';
  String _plazoCredito = 'Plazo del crédito en meses';
  bool _mostrarCampoBanco = false;


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
    if (_montoCreditoController.text.isEmpty ||
        _plazoCredito == 'Plazo del crédito en meses' ||
        _tarjetaCredito == 'Tengo tarjeta de crédito:' ||
        _creditoPara == 'Me gustaría un crédito para:'
    ) {
      String errorMessage = '';

      if (_creditoPara == 'Me gustaría un crédito para:') {
        errorMessage = 'Por favor, selecciona una opción en Me gustaría un crédito para';
      } else if (_tarjetaCredito == 'Tengo tarjeta de crédito:') {
        errorMessage = 'Por favor, selecciona una opción en Tengo tarjeta de crédito';
      } else if (_montoCreditoController.text.isEmpty) {
        errorMessage = 'Por favor, ingresa el monto del crédito';
      } else if (_plazoCredito == 'Plazo del crédito en meses') {
        errorMessage = 'Por favor, selecciona una opción en Plazo del crédito';
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
        Uri.parse('https://edeal-app.onrender.com/credit/$userId'),
        body: {
          'credito': _creditoPara,
          'tarjetaDeCredito': _tarjetaCredito,
          'bancoCredito': _banco,
          'montoCredito': _montoCreditoController.text,
          'plazoCredito': _plazoCredito
          },
      );

      if (response.statusCode == 200) {
        setState(() {
          userData['credit'] = _creditoPara;
          userData['tarjetaDeCredito'] = _tarjetaCredito;
          userData['bancoCredito'] = _banco;
          userData['montoCredito'] = _montoCreditoController.text;
          userData['plazoCredito'] = _plazoCredito;
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
            ) ;
          },
        )
      ;
        setState(() {
         _creditoPara = 'Me gustaría un crédito para:';
         _tarjetaCredito = 'Tengo tarjeta de crédito:';
         _banco = 'Con cual banco:';
         _plazoCredito = 'Plazo del crédito en meses';
         _montoCreditoController.text = '';
      });
      } else {
        print('Error al actualizar la información: ${response.statusCode}');
      }
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
      if (newTarjeta == 'Si') {
        _mostrarCampoBanco = true;
      } else {
        _mostrarCampoBanco = false;
      }
    });
  }

  void updateBancoOption(String? newBanco){
    setState(() {
    _banco = newBanco!;
    });
  }

    void updateplazoCreditoOption(String? newPlazoCredito){
    setState(() {
    _plazoCredito = newPlazoCredito!;
    });
  }



  @override
  Widget build(BuildContext context) {
    if(userData['credito'] != null
    && userData['montoCredito'] != null
    && userData['plazoCredito'] != null
    && userData['tarjetaDeCredito'] != null
    && userData['credito2'] == null
    && userData['montoCredito2'] == null
    && userData['plazoCredito2'] == null
    && userData['tarjetaDeCredito2'] == null
    ){
    double montoCredito = double.parse(userData['montoCredito']);
    int plazoCredito = int.parse(userData['plazoCredito']);
    double valorCuota = (montoCredito * (0.018 * pow(1 + 0.018, plazoCredito))) /
    (pow(1 + 0.018, plazoCredito) - 1);
    return Scaffold(
      backgroundColor: Color(0XFF524898),
      body: Center(
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Credito 1',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white
              )
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: (){
                showDialog(
                  context: context, 
                  builder: (BuildContext context){
                    return AlertDialog(
                      title: Text('Información crédito 1'),
                      content: SingleChildScrollView(
                        child: ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 150),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Valor del crédito: ${userData['montoCredito']}'),
                            SizedBox(height: 10,),
                            Text('Objetivo del credito: ${userData['credito']}'),
                            SizedBox(height: 10,),
                            Text('Tiene tarjeta de credito: ${userData['tarjetaDeCredito']}'),
                            SizedBox(height: 10,),
                            Text('Plazo del crédito: ${userData['plazoCredito']} meses'),
                            SizedBox(height: 10,),
                            Text('Valor mensual de la cuota: \$${valorCuota.toStringAsFixed(2)}'),
                          ],
                        ),
                      ), 
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        }, 
                        child: Text('Aceptar')
                        ),
                    ],
                    );
                  }
                  );
            
              },
              child: Text('Ver información')
              ),
              SizedBox(height: 70,),
              ElevatedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Credito2Screen(token: widget.token))
                  );
                }, 
                child: Text('Crear nuevo crédito'))
          ]
          
        )
      ),
    );
    }


    else if(userData['credito'] != null
    && userData['montoCredito'] != null
    && userData['plazoCredito'] != null
    && userData['tarjetaDeCredito'] != null
    && userData['credito2'] != null
    && userData['montoCredito2'] != null
    && userData['plazoCredito2'] != null
    && userData['tarjetaDeCredito2'] != null
    && userData['credito3'] == null
    && userData['montoCredito3'] == null
    && userData['plazoCredito3'] == null
    && userData['tarjetaCredito3'] == null
    ){
    double montoCredito = double.parse(userData['montoCredito']);
    int plazoCredito = int.parse(userData['plazoCredito']);
    double valorCuota = (montoCredito * (0.018 * pow(1 + 0.018, plazoCredito))) /
    (pow(1 + 0.018, plazoCredito) - 1);

    double montoCredito2 = double.parse(userData['montoCredito2']);
    int plazoCredito2 = int.parse(userData['plazoCredito2']);
    double valorCuota2 = (montoCredito2 * (0.018 * pow(1 + 0.018, plazoCredito2))) /
    (pow(1 + 0.018, plazoCredito2) - 1);

    return Scaffold(
      backgroundColor: Color(0XFF524898),
      body: Center(
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Credito 1',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white
              )
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: (){
                showDialog(
                  context: context, 
                  builder: (BuildContext context){
                    return AlertDialog(
                      title: Text('Información crédito 1'),
                      content: SingleChildScrollView(
                        child: ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 150),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Valor del crédito: ${userData['montoCredito']}'),
                            SizedBox(height: 10,),
                            Text('Objetivo del credito: ${userData['credito']}'),
                            SizedBox(height: 10,),
                            Text('Tiene tarjeta de credito: ${userData['tarjetaDeCredito']}'),
                            SizedBox(height: 10,),
                            Text('Plazo del crédito: ${userData['plazoCredito']} meses'),
                            SizedBox(height: 10,),
                            Text('Valor mensual de la cuota: \$${valorCuota.toStringAsFixed(2)}'),
                          ],
                        ),
                      ), 
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        }, 
                        child: Text('Aceptar')
                        ),
                    ],
                    );
                  }
                  );
            
              },
              child: Text('Ver información')
              ),

              SizedBox(height: 10,),

              Text(
              'Credito 2',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white
              )
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: (){
                showDialog(
                  context: context, 
                  builder: (BuildContext context){
                    return AlertDialog(
                      title: Text('Información crédito 2'),
                      content: SingleChildScrollView(
                        child: ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 150),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Valor del crédito: ${userData['montoCredito2']}'),
                            SizedBox(height: 10,),
                            Text('Objetivo del credito: ${userData['credito2']}'),
                            SizedBox(height: 10,),
                            Text('Tiene tarjeta de credito: ${userData['tarjetaDeCredito2']}'),
                            SizedBox(height: 10,),
                            Text('Plazo del crédito: ${userData['plazoCredito2']} meses'),
                            SizedBox(height: 10,),
                            Text('Valor mensual de la cuota: \$${valorCuota2.toStringAsFixed(2)}'),
                          ],
                        ),
                      ), 
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        }, 
                        child: Text('Aceptar')
                        ),
                    ],
                    );
                  }
                  );
            
              },
              child: Text('Ver información')
              ),

              SizedBox(height: 70,),
              ElevatedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Credito3Screen(token: widget.token))
                  );
                }, 
                child: Text('Crear nuevo crédito'))
          ]
          
        )
      ),
    );
    }

    else {
          return Scaffold(
      backgroundColor: Color(0XFF524898),
      body: Center(
        child: SingleChildScrollView(
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
                    if(_mostrarCampoBanco)
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
                   Container(
                      width: 374,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: DropdownButton<String>(
                      dropdownColor: Color(0XFF524898) ,
                      value: _plazoCredito,
                      onChanged: updateplazoCreditoOption,
                      items: <String>[
                        'Plazo del crédito en meses',
                          '1 ',
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
                      icon:  Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                    ),
                    ),
                SizedBox(height: 20),
Container(
  margin: EdgeInsets.only(bottom: 20),
  child: TextField(
    controller: _montoCreditoController,
    keyboardType: TextInputType.number,
    style: TextStyle(color: Colors.white),
    decoration: InputDecoration(
      errorStyle: TextStyle(color: Colors.white),
      hintText: "Monto del crédito",
      hintStyle: TextStyle(color: Colors.white),
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
    ),
  ).p4().px12(),
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
        )
      ),
    );
    }

  }
}


