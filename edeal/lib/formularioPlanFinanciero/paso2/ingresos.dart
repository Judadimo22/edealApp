import 'dart:convert';
import 'package:edeal/formularioPlanFinanciero/controlFinanzas.dart';
import 'package:edeal/formularioPlanFinanciero/gastos/hogar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_xlider/flutter_xlider.dart';


class Ingresos extends StatefulWidget {
  final String token;

  const Ingresos({required this.token, Key? key}) : super(key: key);

  @override
  State<Ingresos> createState() => _IngresosState();
}

class _IngresosState extends State<Ingresos> {
  late String userId;
  Map<String, dynamic> userData = {};
  final TextEditingController _salarioController = TextEditingController();
  final TextEditingController _inversionesPesosController = TextEditingController();
  final TextEditingController _inversionesDolarController = TextEditingController();
  final TextEditingController _alquilerInmobiliarioController = TextEditingController();
  final TextEditingController _dividendosController = TextEditingController();
  final TextEditingController _pensionesController = TextEditingController();
  final TextEditingController _otrosIngresosController = TextEditingController();
  final TextEditingController _fondoEmergenciaController = TextEditingController();
  final TextEditingController _fondoAhorroController = TextEditingController();
  final TextEditingController _fondoRetiroController = TextEditingController();
  final TextEditingController _inversionesController = TextEditingController();
  final TextEditingController _otrosAhorrosController = TextEditingController();
  List<double> sliderValues = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6];
  


  double valorSalario = 0.0; 
  double valorInversionesPesos = 0.0; 
  double valorInversionesDolar = 0.0;
  double valorAlquileres = 0.0;
  double valorDividendos = 0.0;
  double valorPensiones = 0.0;
  double valorOtrosIngresos = 0.0;


  @override
  
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    userId = jwtDecodedToken['_id'];
    fetchUserData();
    

    _salarioController.addListener(() {
      setState(() {
        valorSalario = double.tryParse(_salarioController.text) ?? 0.0;
      });
    });

    _inversionesPesosController.addListener(() {
      setState(() {
        valorInversionesPesos = double.tryParse(_inversionesPesosController.text) ?? 0.0;
      });
    });

    _inversionesDolarController.addListener(() {
      setState(() {
        valorInversionesDolar = double.tryParse(_inversionesDolarController.text) ?? 0.0;
      });
    });

    _alquilerInmobiliarioController.addListener(() {
      setState(() {
        valorAlquileres = double.tryParse(_alquilerInmobiliarioController.text) ?? 0.0;
      });
    });

    _dividendosController.addListener(() {
      setState(() {
        valorDividendos = double.tryParse(_dividendosController.text) ?? 0.0;
      });
    });

    _pensionesController.addListener(() { 
      setState(() {
        valorPensiones = double.tryParse(_pensionesController.text) ?? 0.0;
      });
    });

    _otrosIngresosController.addListener(() { 
      setState(() {
        valorOtrosIngresos = double.tryParse(_otrosIngresosController.text) ?? 0.0;
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

  void saveIngresos() async {

    var response = await http.put(
      Uri.parse('https://edeal-app.onrender.com/ingresos/$userId'),
      body: {
        'salario': _salarioController.text,
        'inversionesPesos': _inversionesPesosController.text,
        'inversionesUsd': _inversionesDolarController.text,
        'alquileresInmobiliarios': _alquilerInmobiliarioController.text,
        'dividendos': _dividendosController.text,
        'pensiones': _pensionesController.text,
        'otrosIngresos': _otrosIngresosController.text,
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        userData['salario'] = _salarioController.text;
        userData['inversionesPesos'] = _inversionesPesosController.text;
        userData['inversionesUsd'] = _inversionesDolarController.text;
        userData['alquileresInmobiliarios'] = _alquilerInmobiliarioController.text;
        userData['dividendos'] = _dividendosController.text;
        userData['pensiones'] = _pensionesController.text;
        userData['otrosIngresos'] = _otrosIngresosController.text;
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Ingresos actualizados'),
            content: Text('Tus ingresos han sido actualizados'),
            actions: [
              TextButton(
                  onPressed: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>Hogar(token: widget.token)));
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
    double _salario = 0.0;
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
                ' tus ingresos   ',
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
                '2/4',
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
                'Por favor indiquenos la siguiente información de sus ingresos',
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
                              'Salario', 
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
  margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.010),
  child: FlutterSlider(
    values: sliderValues,
    min: 0,
    max: 10000,
    step: FlutterSliderStep(step: 1),
    axis: Axis.horizontal,
    handlerWidth: 15,
    handlerHeight: 15,
    handler: FlutterSliderHandler(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFF0C67B0),
        ),
      ),
    ),
    handlerAnimation: FlutterSliderHandlerAnimation(
      curve: Curves.elasticOut,
      reverseCurve: Curves.elasticOut,
      duration: const Duration(milliseconds: 700),
      scale: 1.2,
    ),
    onDragging: (handlerIndex, lowerValue, upperValue) {
      setState(() {
        _salario = lowerValue;
      });
    },
    trackBar: FlutterSliderTrackBar(
      activeTrackBarHeight: 5,
      inactiveTrackBarHeight: 3,
      inactiveTrackBar: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: const Color(0xFFABB3B8),
      ),
      activeTrackBar: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: const Color(0xFF0C67B0),
      ),
    ),
    tooltip: FlutterSliderTooltip(
      textStyle: const TextStyle(fontSize: 12),
      boxStyle: FlutterSliderTooltipBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: const Color(0xFF0C67B0),
        ),
      ),
    ),
  ),
).p4().px24(),
            
                        Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.030 ),
                    child: Column(
                      children: [ 
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.050),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Inversiones en pesos', 
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
                      controller: _inversionesPesosController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Inversiones en pesos",
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

                      ],
                    )
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
                              'Inversiones en USD', 
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
                      controller: _inversionesDolarController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Inversiones en USD",
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
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.030 ),
                    child: Column(
                      children: [ 
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.050),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Alquileres inmobiliarios', 
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
                      controller: _alquilerInmobiliarioController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Alquileres inmobiliarios",
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
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.030 ),
                    child: Column(
                      children: [ 
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.050),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Dividendos', 
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
                      controller: _dividendosController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Dividendos",
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
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.030 ),
                    child: Column(
                      children: [ 
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.050),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Pensiones', 
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
                      controller: _pensionesController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Pensiones",
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
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.030 ),
                    child: Column(
                      children: [ 
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.050),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Otros ingresos', 
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
                      controller: _otrosIngresosController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Otros ingresos",
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
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.040 ),
                    child: Column(
                children: [
                  Text(
                'Agrega                     ',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF444C52),
                  fontSize: MediaQuery.of(context).size.height * 0.035,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  letterSpacing: -0.01
                )
              ),
              Text(
                'tus ahorros            ',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF444C52),
                  fontSize: MediaQuery.of(context).size.height * 0.035,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  letterSpacing: -0.01
                )
              )
                ],
              ),
                  ),
            Container(
              margin: EdgeInsets.only(top: 20, left: MediaQuery.of(context).size.height * 0.050, right: MediaQuery.of(context).size.height * 0.050 ),
              child: Text(
                'Por favor indiquenos la siguiente información de sus ahorros',
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
                              'Fondo de emergencia', 
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
                      controller: _fondoEmergenciaController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Fondo de emergencia",
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
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.030 ),
                    child: Column(
                      children: [ 
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.050),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Fondo de ahorro', 
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
                      controller: _fondoAhorroController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Fondo de ahorro",
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
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.030 ),
                    child: Column(
                      children: [ 
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.050),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Fondo de retiro', 
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
                      controller: _fondoRetiroController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Fondo de retiro",
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
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.030 ),
                    child: Column(
                      children: [ 
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.050),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Inversiones', 
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
                      controller: _inversionesController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Inversiones",
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
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.030 ),
                    child: Column(
                      children: [ 
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.050),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Otros ahorros', 
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
                      controller: _fondoAhorroController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Otros ahorros",
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
                margin: const EdgeInsets.only(top: 30, bottom: 30, left: 20, right: 20),
                child: ElevatedButton(
                  onPressed: () => {
                    if (
        _inversionesPesosController.text.isEmpty ||
        _inversionesDolarController.text.isEmpty ||
        _alquilerInmobiliarioController.text.isEmpty ||
        _dividendosController.text.isEmpty ||
        _pensionesController.text.isEmpty ||
        _otrosIngresosController.text.isEmpty
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
      saveIngresos()
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

