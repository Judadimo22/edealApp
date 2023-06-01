import 'dart:async';
import 'dart:convert';
import 'package:edeal/formularioPlanFinanciero/definirObjetivos.dart';
import 'package:edeal/views/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:velocity_x/velocity_x.dart';

class Salud extends StatefulWidget {
  final String token;

  Salud({required this.token, Key? key}) : super(key: key);

  @override
  State<Salud> createState() => _SaludState();
}

class _SaludState extends State<Salud> {
  late String userId;
  Map<String, dynamic> userData = {};

  final _formKey = GlobalKey<FormState>();



  String _planCobertura = 'Cuenta con un plan de cobertura de salud';
  String _tipoPlan = 'Que tipo de plan';
  String _porcentajeCobertura = 'Porcentaje de cobertura de su plan';



  bool _showPlanCobertura= false;

 

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

// void saveUserData() async {
//   if (_formKey.currentState!.validate()) {
//     var vacacionesViajes = _vacacionesViajesController.text;

//     var response = await http.put(
//       Uri.parse('http://192.168.1.108:3001/ahorro/$userId'),
//       body: {
//         'ahorroPara': _ahorroPara == 'Otros' ? newData : _ahorroPara,
//         'valorAhorro': _valorAhorroController.text,
//         'plazoAhorro': _plazo,
//       },
//     );

//     if (response.statusCode == 200) {
//       setState(() {
//         userData['ahorroPara'] = _ahorroPara == 'Otros' ? newData : _ahorroPara;
//         userData['valorAhorro'] = _valorAhorroController.text;
//         userData['plazoAhorro'] = _plazo;
//       });

//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Información actualizada'),
//             content: Text('Tu información se almacenó correctamente.'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('Aceptar'),
//               ),
//             ],
//           );
//         },
//       );

//       setState(() {
//         _ahorroPara = 'Quiero ahorrar para:';
//         // _valorAhorroController = '';
//         _plazo = 'Plazo(meses):';
//       });
//     } else {
//       print('Error al actualizar la información: ${response.statusCode}');
//     }
//   }
// }


  void updatePlanCobertura(String? newPlanCobertura) {
    setState(() {
      _planCobertura = newPlanCobertura!;
      if (newPlanCobertura == 'Cuenta con un plan de cobertura de salud: Si') {
        _showPlanCobertura = true;
      } else {
        _showPlanCobertura = false;
      }
    });
  }

  void updateTipoPlan(String? newTipoPLan) {
    setState(() {
      _tipoPlan= newTipoPLan!;
    });
  }

  void updatePorcentajeCobertura(String? newPorcentajeCobertura) {
    setState(() {
      _porcentajeCobertura = newPorcentajeCobertura!;
    });
  }

  void saveObjetivosSalud() async {
    // var newData = _newDataController.text;

    var response = await http.put(
      Uri.parse('https://edeal-app.onrender.com/objetivosSalud/$userId'),
      body: {
        'cuentaConPlanSalud': _planCobertura,
        'tipoPlanSalud': _tipoPlan,
        'porcentajeCoberturaPlan': _porcentajeCobertura,
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        userData['cuentaConPlanSalud'] = _planCobertura;
        userData['tipoPlanSalud'] = _tipoPlan;
        userData['porcentajeCoberturaPlan'] = _porcentajeCobertura;
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Objetivos de salud actualizados'),
            content: Text('Tus objetivos de salud han sido actualizados'),
            actions: [
              TextButton(
                  onPressed: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>DefinirObjetivo(token: widget.token)));
                  },
                child: Text('Aceptar'),
              ),
            ],
          );
        },
      );

      // setState(() {
      //   _ahorroPara = 'Quiero ahorrar para:';
      //   // _valorAhorroController = '';
      //   _plazo = 'Plazo(meses):';
      // });
}
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0XFF524898) ,
      ),
      backgroundColor: Color(0XFF524898),
      body:SingleChildScrollView(
        child:  Center(
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
                        'Salud',
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
                        value: _planCobertura,
                        onChanged: updatePlanCobertura,
                        items: <String>[
                          'Cuenta con un plan de cobertura de salud',
                          'Cuenta con un plan de cobertura de salud: Si',
                          'Cuenta con un plan de cobertura de salud: No'
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
                    if (_showPlanCobertura)
                    Column(
                      children: [
                    Container(
                      width: 374,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      color: Color(0XFF524898),
                      child: DropdownButton<String>(
                        dropdownColor: Color(0XFF524898),
                        value: _tipoPlan,
                        onChanged: updateTipoPlan,
                        items: <String>[
                          'Que tipo de plan',
                          'Publico',
                          'Privado'
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
                    Container(
                      width: 374,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      color: Color(0XFF524898),
                      child: DropdownButton<String>(
                        dropdownColor: Color(0XFF524898),
                        value: _porcentajeCobertura,
                        onChanged: updatePorcentajeCobertura,
                        items: <String>[
                          'Porcentaje de cobertura de su plan',
                          '0 a 25 %',
                          '25 a 50 %',
                          '50 a 75 %',
                          '100%'
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
                      ],
                    ),



                    SizedBox(height: 40),



                    ElevatedButton(
                      onPressed: (){
              if (_planCobertura == 'Cuenta con un plan de cobertura de salud'
        ) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Completa todos los campos antes de continuar'),
            content: Text('Por favor completa todos los campos antes de continuar'),
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
      saveObjetivosSalud();
    }
                        
                      },
                      child: Text('Continuar', style: TextStyle(fontSize: 18)),
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
      )
    );
  }
}