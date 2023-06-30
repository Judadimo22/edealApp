import 'dart:convert';
import 'package:edeal/formularioPlanFinanciero/controlFinanzas.dart';
import 'package:edeal/formularioPlanFinanciero/informacionPersonal.dart';
import 'package:edeal/formularioPlanFinanciero/paso2/gastos.dart';
import 'package:edeal/views/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class Hogar extends StatefulWidget {
  final String token;

  const Hogar({required this.token, Key? key}) : super(key: key);

  @override
  State<Hogar> createState() => _HogarState();
}

class _HogarState extends State<Hogar> {
  late String userId;
  Map<String, dynamic> userData = {};
  final TextEditingController _creditoHipotecarioController = TextEditingController();
  final TextEditingController _arriendoController = TextEditingController();
  final TextEditingController _serviciosPublicosController = TextEditingController();
  final TextEditingController _internetController = TextEditingController();
  final TextEditingController _planCelularController = TextEditingController();
  final TextEditingController _mantenimientoHogarController = TextEditingController();
  final TextEditingController _segurosHogarController = TextEditingController();
  final TextEditingController _mercadoController = TextEditingController();
  final TextEditingController _otrosGastosHogar = TextEditingController();


  double valorCreditoHipotecario= 0.0; 
  double valorArriendo = 0.0; 
  double valorServiciosPublicos = 0.0;
  double valorInternet = 0.0;
  double valorPlanCelular = 0.0;
  double valorMantenimientoHogar = 0.0;
  double valorSegurosHogar = 0.0;
  double valorMercado = 0.0;
  double valorOtrosGastosHogar = 0.0;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    userId = jwtDecodedToken['_id'];
    fetchUserData();
    

    _creditoHipotecarioController.addListener(() {
      setState(() {
        valorCreditoHipotecario = double.tryParse(_creditoHipotecarioController.text) ?? 0.0;
      });
    });

    _arriendoController.addListener(() {
      setState(() {
        valorArriendo = double.tryParse(_arriendoController.text) ?? 0.0;
      });
    });

    _serviciosPublicosController.addListener(() {
      setState(() {
        valorServiciosPublicos = double.tryParse(_serviciosPublicosController.text) ?? 0.0;
      });
    });

    _internetController.addListener(() {
      setState(() {
        valorInternet = double.tryParse(_internetController.text) ?? 0.0;
      });
    });

    _planCelularController.addListener(() { 
      setState(() {
        valorPlanCelular = double.tryParse(_planCelularController.text) ?? 0.0;
      });
    });

     _mantenimientoHogarController.addListener(() { 
      setState(() {
        valorMantenimientoHogar = double.tryParse(_mantenimientoHogarController.text) ?? 0.0;
      });
    });

     _segurosHogarController.addListener(() { 
      setState(() {
        valorSegurosHogar = double.tryParse(_segurosHogarController.text) ?? 0.0;
      });
    });

     _mercadoController.addListener(() { 
      setState(() {
        valorMercado = double.tryParse(_mercadoController.text) ?? 0.0;
      });
    });

     _otrosGastosHogar.addListener(() { 
      setState(() {
        valorOtrosGastosHogar = double.tryParse(_otrosGastosHogar.text) ?? 0.0;
      });
    });



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

  void saveGastosHogar() async {

    var response = await http.put(
      Uri.parse('https://edeal-app.onrender.com/gastosHogar/$userId'),
      body: {
        'creditoHipotecario': _creditoHipotecarioController.text,
        'arriendo': _arriendoController.text,
        'serviciosPublicos': _serviciosPublicosController.text,
        'internet': _internetController.text,
        'planCelular': _planCelularController.text,
        'mantenimientoHogar': _mantenimientoHogarController.text,
        'segurosHogar': _segurosHogarController.text,
        'mercado': _mercadoController.text,
        'otrosGastosHogar': _otrosGastosHogar.text
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        userData['creditoHipotecario'] = _creditoHipotecarioController.text;
        userData['arriendo'] = _arriendoController.text;
        userData['serviciosPublicos'] = _serviciosPublicosController.text;
        userData['internet'] = _internetController.text;
        userData['mantenimientoHogar'] = _mantenimientoHogarController.text;
        userData['segurosHogar'] = _segurosHogarController.text;
        userData['mercado'] = _mercadoController.text;
        userData['planCelular'] = _planCelularController.text;
        userData['otrosGastosHogar'] = _otrosGastosHogar.text;
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Gastos del hogar actualizados'),
            content: Text('Tus gastos del hogar han sido actualizados'),
            actions: [
              TextButton(
                  onPressed: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>Gastos(token: widget.token)));
                  },
                child: Text('Aceptar'),
              ),
            ],
          );
        },
      );

}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
               Row(
              children: [
              Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.080, left: MediaQuery.of(context).size.height * 0.040),
              child: Column(
                children: [
                  Text(
                ' Agrega              ',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF444C52),
                  fontSize: MediaQuery.of(context).size.height * 0.035,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  letterSpacing: -0.01
                )
              ),
              Text(
                ' tus gastos       ',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF444C52),
                  fontSize: MediaQuery.of(context).size.height * 0.035,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  letterSpacing: -0.01
                )
              )
                ],
              )
            ),
            Container(
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.040, bottom: MediaQuery.of(context).size.height * 0.035 ),
              child:Text(
                '3/4',
                style: GoogleFonts.inter(
                  color: const Color(0xFF444C52),
                  fontSize: MediaQuery.of(context).size.height * 0.015,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  letterSpacing: -0.01
                )
              ),
            )
              ],
            ),
                    Container(
              margin: EdgeInsets.only(top: 20, left: MediaQuery.of(context).size.height * 0.050, right: MediaQuery.of(context).size.height * 0.050 ),
              child: Text(
                'Por favor indiquenos la siguiente información de sus gastos',
                style: GoogleFonts.inter(
                  color: const Color(0xFF817F7F),
                  fontSize: MediaQuery.of(context).size.height * 0.020,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  letterSpacing: -0.01
                )
              ),
            ),
                      Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.030 ),
                    child: Column(
                      children: [ 
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.050),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Alquiler', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.016,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
                          ) ,
                        ), 
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.010 ),
                          child: TextField(
                      controller: _creditoHipotecarioController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Alquiler",
                        hintStyle: const TextStyle(
                          color: Color(0xFFABB3B8)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF0C67B0),
                            width: 1
                          ),
                        ),
                        enabledBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF0C67B0),
                            width: 1
                          ),
                        ),
                      ),
                    ).p4().px24(),
                        ),
                      ],
                    )
                  ),
              Container(
                margin: const EdgeInsets.only(top: 40),
                child: const Text(
                  'Mis gastos del hogar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
                  controller: _creditoHipotecarioController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Crédito hipotecario',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left:20, right: 20),
                child: TextField(
                  controller: _arriendoController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Arriendo',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
                  controller: _serviciosPublicosController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Servicios publicos',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
                  controller: _internetController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Internet',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
                  controller: _planCelularController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Plan de celular',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
                  controller: _mantenimientoHogarController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Mantenimiento del hogar',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
                  controller: _segurosHogarController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Segutos del hogar',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
                  controller: _mercadoController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Mercado',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
                  controller: _otrosGastosHogar,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Otros',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Text(
                  'Total - Mis gastos del hogar \$${(valorCreditoHipotecario + valorArriendo + valorServiciosPublicos + valorInternet + valorPlanCelular + valorMantenimientoHogar + valorSegurosHogar + valorMercado + valorOtrosGastosHogar).toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30, bottom: 30, left: 20, right: 20),
                child: ElevatedButton(
                  onPressed: () => {
               if (_creditoHipotecarioController.text.isEmpty ||
        _arriendoController.text.isEmpty ||
        _serviciosPublicosController.text.isEmpty ||
        _internetController.text.isEmpty ||
        _planCelularController.text.isEmpty ||
        _mantenimientoHogarController.text.isEmpty ||
        _segurosHogarController.text.isEmpty ||
        _mercadoController.text.isEmpty || 
        _otrosGastosHogar.text.isEmpty
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
      )
    } else {
      saveGastosHogar()
    }
                    
                  },
                  child: const Text('Continuar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
