import 'dart:convert';
import 'package:edeal/formularioPlanFinanciero/gastos/hogar.dart';
import 'package:edeal/widgets/thumb.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


class Ingresos extends StatefulWidget {
  final String token;

  const Ingresos({required this.token, Key? key}) : super(key: key);

  @override
  State<Ingresos> createState() => _IngresosState();
}

class _IngresosState extends State<Ingresos> {
  late String userId;
  Map<String, dynamic> userData = {};
  double _salario = 0;
  double _inversionesPesos = 0;
  double _inversionesUsd = 0;
  double _alquileresInmobiliarios = 0;
  double _dividendos = 0;
  double _pensiones = 0;
  double _otrosIngresos = 0;
  double _fondoEmergencia = 0;
  double _fondoAhorro = 0;
  double _fondoRetiro = 0;
  double _inversiones = 0;
  double _otrosAhorros = 0;

  

  





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

  void saveIngresos() async {

    var response = await http.put(
      Uri.parse('https://edeal-app.onrender.com/ingresos/$userId'),
      body: {
        'salario': _salario.toInt().toString(),
        'inversionesPesos': _inversionesPesos.toInt().toString(),
        'inversionesUsd': _inversionesUsd.toInt().toString(),
        'alquileresInmobiliarios': _alquileresInmobiliarios.toInt().toString(),
        'dividendos': _dividendos.toInt().toString(),
        'pensiones': _pensiones.toInt().toString(),
        'otrosIngresos': _otrosIngresos.toInt().toString(),
        'fondoEmergencia': _fondoEmergencia.toInt().toString(),
        'fondoAhorro': _fondoAhorro.toInt().toString(),
        'fondoRetiro': _fondoRetiro.toInt().toString(),
        'inversiones': _inversiones.toInt().toString(),
        'otrosAhorros': _otrosAhorros.toInt().toString()
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        userData['salario'] = _salario.toInt().toString();
        userData['inversionesPesos'] = _inversionesPesos.toInt().toString();
        userData['inversionesUsd'] = _inversionesUsd.toInt().toString();
        userData['alquileresInmobiliarios'] = _alquileresInmobiliarios.toInt().toString();
        userData['dividendos'] = _dividendos.toInt().toString();
        userData['pensiones'] = _pensiones.toInt().toString();
        userData['otrosIngresos'] = _otrosIngresos.toInt().toString();
        userData['fondoEmergencia'] = _fondoEmergencia.toInt().toString();
        userData['fondoAhorro'] = _fondoAhorro.toInt().toString();
        userData['fondoRetiro'] = _fondoRetiro.toInt().toString();
        userData['inversiones'] = _inversiones.toInt().toString();
        userData['otrosAhorros'] = _otrosAhorros.toInt().toString();
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
                'Ingresos y ahorros actualizados',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.height * 0.020,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  letterSpacing: -0.01
                )
              ),
            content: Text(
                'Tus ingresos y ahorros han sido actualizados de manera correcta.',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF444C52),
                  fontSize: MediaQuery.of(context).size.height * 0.020,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                  letterSpacing: -0.01
                )
              ),
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
                '2/6',
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
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.030, ),
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
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.035, right:MediaQuery.of(context).size.height * 0.035, bottom:MediaQuery.of(context).size.height * 0.045 ),
                         child: Column(
                           children: [
                               Text(
                              '${NumberFormat('#,###,###').format(_salario)}  COP',
                               style: const TextStyle(fontSize: 12),
                             ),
                          SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                          activeTrackColor: const Color(0xFF0C67B0),
                          inactiveTrackColor: const Color(0xFFE8E112),
                          thumbColor: Colors.white,
                          trackHeight: 4.0,
                          thumbShape: const CustomSliderThumbShape(
                          thumbRadius: 8.0, 
                          borderThickness: 2.0, 
                          borderColor: Colors.blue),
                          overlayColor: const Color(0x00FFFFFF),
                          overlayShape: const RoundSliderOverlayShape(overlayRadius: 16.0),
                          ),
                         child: Slider(
                          min: 0,
                          max: 20000000,
                          divisions: 20,
                          value: _salario,
                          onChanged: (value) {
                         setState(() {
                          _salario = value;
                         });
                        },
                       ),
                       ),
                       Container(
                        margin: EdgeInsets.only(left:MediaQuery.of(context).size.height * 0.020 ),
                        child: Row(
                          children: [Expanded(
                              child: Text(
                              '0', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
                              ),
                              Text(
                              '20,000,000', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
         
                          ],
                        ),
                       )
                       ],
                      ),
                      ),
                      Container(
                          margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.050, right: MediaQuery.of(context).size.height * 0.050, bottom: MediaQuery.of(context).size.height * 0.020),
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
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.035, right:MediaQuery.of(context).size.height * 0.035, bottom:MediaQuery.of(context).size.height * 0.040 ),
                         child: Column(
                           children: [
                               Text(
                              '${NumberFormat('#,###,###').format(_inversionesPesos)}  COP',
                               style: const TextStyle(fontSize: 12),
                             ),
                          SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                          activeTrackColor: const Color(0xFF0C67B0),
                          inactiveTrackColor: const Color(0xFFE8E112),
                          thumbColor: Colors.white,
                          trackHeight: 4.0,
                          thumbShape: const CustomSliderThumbShape(
                          thumbRadius: 8.0, 
                          borderThickness: 2.0, 
                          borderColor: Colors.blue),
                          overlayColor: const Color(0x00FFFFFF),
                          overlayShape: const RoundSliderOverlayShape(overlayRadius: 16.0),
                          ),
                         child: Slider(
                          min: 0,
                          max: 20000000,
                          divisions: 20,
                          value: _inversionesPesos,
                          onChanged: (value) {
                         setState(() {
                          _inversionesPesos = value;
                         });
                        },
                       ),
                       ),
                       Container(
                        margin: EdgeInsets.only(left:MediaQuery.of(context).size.height * 0.020 ),
                        child: Row(
                          children: [Expanded(
                              child: Text(
                              '0', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
                              ),
                              Text(
                              '20,000,000', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
         
                          ],
                        ),
                       )
                       ],
                      ),
                      ),

                      ],
                    )
                  ),
            Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.010, bottom: 20 ),
                    child: Column(
                      children: [ 
                        Container(
                          margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.050, right:MediaQuery.of(context).size.height * 0.050, bottom: MediaQuery.of(context).size.height * 0.020 ),
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
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.035, right:MediaQuery.of(context).size.height * 0.035, bottom:MediaQuery.of(context).size.height * 0.020 ),
                         child: Column(
                           children: [
                               Text(
                              '${NumberFormat('#,###,###').format(_inversionesUsd)}  USD',
                               style: const TextStyle(fontSize: 12),
                             ),
                          SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                          activeTrackColor: const Color(0xFF0C67B0),
                          inactiveTrackColor: const Color(0xFFE8E112),
                          thumbColor: Colors.white,
                          trackHeight: 4.0,
                          thumbShape: const CustomSliderThumbShape(
                          thumbRadius: 8.0, 
                          borderThickness: 2.0, 
                          borderColor: Colors.blue),
                          overlayColor: const Color(0x00FFFFFF),
                          overlayShape: const RoundSliderOverlayShape(overlayRadius: 16.0),
                          ),
                         child: Slider(
                          min: 0,
                          max: 100000,
                          divisions: 50,
                          value: _inversionesUsd,
                          onChanged: (value) {
                         setState(() {
                          _inversionesUsd = value;
                         });
                        },
                       ),
                       ),
                      Container(
                        margin: EdgeInsets.only(left:MediaQuery.of(context).size.height * 0.020 ),
                        child: Row(
                          children: [Expanded(
                              child: Text(
                              '0', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
                              ),
                              Text(
                              '100,000', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
         
                          ],
                        ),
                       )
                       ],
                      ),
                      ),

                      ],
                    )
                  ),

              Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.002, bottom: MediaQuery.of(context).size.height * 0.010 ),
                    child: Column(
                      children: [ 
                        Container(
                          margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.050, right:MediaQuery.of(context).size.height * 0.050, bottom: MediaQuery.of(context).size.height * 0.020 ),
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
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.035, right:MediaQuery.of(context).size.height * 0.035, bottom:MediaQuery.of(context).size.height * 0.040 ),
                         child: Column(
                           children: [
                               Text(
                              '${NumberFormat('#,###,###').format(_alquileresInmobiliarios)}  COP',
                               style: const TextStyle(fontSize: 12),
                             ),
                          SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                          activeTrackColor: const Color(0xFF0C67B0),
                          inactiveTrackColor: const Color(0xFFE8E112),
                          thumbColor: Colors.white,
                          trackHeight: 4.0,
                          thumbShape: const CustomSliderThumbShape(
                          thumbRadius: 8.0, 
                          borderThickness: 2.0, 
                          borderColor: Colors.blue),
                          overlayColor: const Color(0x00FFFFFF),
                          overlayShape: const RoundSliderOverlayShape(overlayRadius: 16.0),
                          ),
                         child: Slider(
                          min: 0,
                          max: 20000000,
                          divisions: 20,
                          value: _alquileresInmobiliarios,
                          onChanged: (value) {
                         setState(() {
                          _alquileresInmobiliarios = value;
                         });
                        },
                       ),
                       ),
                    Container(
                        margin: EdgeInsets.only(left:MediaQuery.of(context).size.height * 0.020 ),
                        child: Row(
                          children: [Expanded(
                              child: Text(
                              '0', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
                              ),
                              Text(
                              '20,000,000', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
         
                          ],
                        ),
                       )
                       ],
                      ),
                      ),

                      ],
                    )
                  ),
              Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.002, bottom: MediaQuery.of(context).size.height * 0.010 ),
                    child: Column(
                      children: [ 
                        Container(
                          margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.050, right:MediaQuery.of(context).size.height * 0.050, bottom: MediaQuery.of(context).size.height * 0.020 ),
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
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.035, right:MediaQuery.of(context).size.height * 0.035, bottom:MediaQuery.of(context).size.height * 0.040 ),
                         child: Column(
                           children: [
                               Text(
                              '${NumberFormat('#,###,###').format(_dividendos)}  COP',
                               style: const TextStyle(fontSize: 12),
                             ),
                          SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                          activeTrackColor: const Color(0xFF0C67B0),
                          inactiveTrackColor: const Color(0xFFE8E112),
                          thumbColor: Colors.white,
                          trackHeight: 4.0,
                          thumbShape: const CustomSliderThumbShape(
                          thumbRadius: 8.0, 
                          borderThickness: 2.0, 
                          borderColor: Colors.blue),
                          overlayColor: const Color(0x00FFFFFF),
                          overlayShape: const RoundSliderOverlayShape(overlayRadius: 16.0),
                          ),
                         child: Slider(
                          min: 0,
                          max: 20000000,
                          divisions: 20,
                          value: _dividendos,
                          onChanged: (value) {
                         setState(() {
                          _dividendos = value;
                         });
                        },
                       ),
                       ),
                      Container(
                        margin: EdgeInsets.only(left:MediaQuery.of(context).size.height * 0.020 ),
                        child: Row(
                          children: [Expanded(
                              child: Text(
                              '0', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
                              ),
                              Text(
                              '20,000,000', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
         
                          ],
                        ),
                       )
                       ],
                      ),
                      ),

                      ],
                    )
                  ),
                Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.002, bottom: MediaQuery.of(context).size.height * 0.010 ),
                    child: Column(
                      children: [ 
                        Container(
                          margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.050, right:MediaQuery.of(context).size.height * 0.050, bottom: MediaQuery.of(context).size.height * 0.020 ),
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
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.035, right:MediaQuery.of(context).size.height * 0.035, bottom:MediaQuery.of(context).size.height * 0.040 ),
                         child: Column(
                           children: [
                               Text(
                              '${NumberFormat('#,###,###').format(_pensiones)}  COP',
                               style: const TextStyle(fontSize: 12),
                             ),
                          SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                          activeTrackColor: const Color(0xFF0C67B0),
                          inactiveTrackColor: const Color(0xFFE8E112),
                          thumbColor: Colors.white,
                          trackHeight: 4.0,
                          thumbShape: const CustomSliderThumbShape(
                          thumbRadius: 8.0, 
                          borderThickness: 2.0, 
                          borderColor: Colors.blue),
                          overlayColor: const Color(0x00FFFFFF),
                          overlayShape: const RoundSliderOverlayShape(overlayRadius: 16.0),
                          ),
                         child: Slider(
                          min: 0,
                          max: 20000000,
                          divisions: 20,
                          value: _pensiones,
                          onChanged: (value) {
                         setState(() {
                          _pensiones = value;
                         });
                        },
                       ),
                       ),
                      Container(
                        margin: EdgeInsets.only(left:MediaQuery.of(context).size.height * 0.020 ),
                        child: Row(
                          children: [Expanded(
                              child: Text(
                              '0', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
                              ),
                              Text(
                              '20,000,000', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
         
                          ],
                        ),
                       )
                       ],
                      ),
                      ),

                      ],
                    )
                  ),
                Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.002, bottom: MediaQuery.of(context).size.height * 0.010 ),
                    child: Column(
                      children: [ 
                        Container(
                          margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.050, right:MediaQuery.of(context).size.height * 0.050, bottom: MediaQuery.of(context).size.height * 0.020 ),
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
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.035, right:MediaQuery.of(context).size.height * 0.035, bottom:MediaQuery.of(context).size.height * 0.040 ),
                         child: Column(
                           children: [
                               Text(
                              '${NumberFormat('#,###,###').format(_otrosIngresos)}  COP',
                               style: const TextStyle(fontSize: 12),
                             ),
                          SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                          activeTrackColor: const Color(0xFF0C67B0),
                          inactiveTrackColor: const Color(0xFFE8E112),
                          thumbColor: Colors.white,
                          trackHeight: 4.0,
                          thumbShape: const CustomSliderThumbShape(
                          thumbRadius: 8.0, 
                          borderThickness: 2.0, 
                          borderColor: Colors.blue),
                          overlayColor: const Color(0x00FFFFFF),
                          overlayShape: const RoundSliderOverlayShape(overlayRadius: 16.0),
                          ),
                         child: Slider(
                          min: 0,
                          max: 20000000,
                          divisions: 20,
                          value: _otrosIngresos,
                          onChanged: (value) {
                         setState(() {
                          _otrosIngresos = value;
                         });
                        },
                       ),
                       ),
                      Container(
                        margin: EdgeInsets.only(left:MediaQuery.of(context).size.height * 0.020 ),
                        child: Row(
                          children: [Expanded(
                              child: Text(
                              '0', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
                              ),
                              Text(
                              '20,000,000', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
         
                          ],
                        ),
                       )
                       ],
                      ),
                      ),

                      ],
                    )
                  ),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.040 ),
                    child: Column(
                children: [
                  Text(
                'Agrega                           ',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF444C52),
                  fontSize: MediaQuery.of(context).size.height * 0.035,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  letterSpacing: -0.01
                )
              ),
              Text(
                'tus ahorros                  ',
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
              margin: EdgeInsets.only(top: 20, left: MediaQuery.of(context).size.height * 0.050, right: MediaQuery.of(context).size.height * 0.050, bottom:MediaQuery.of(context).size.height * 0.030  ),
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
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.002, bottom: MediaQuery.of(context).size.height * 0.010 ),
                    child: Column(
                      children: [ 
                        Container(
                          margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.050, right:MediaQuery.of(context).size.height * 0.050, bottom: MediaQuery.of(context).size.height * 0.020 ),
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
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.035, right:MediaQuery.of(context).size.height * 0.035, bottom:MediaQuery.of(context).size.height * 0.040 ),
                         child: Column(
                           children: [
                               Text(
                              '${NumberFormat('#,###,###').format(_fondoEmergencia)}  COP',
                               style: const TextStyle(fontSize: 12),
                             ),
                          SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                          activeTrackColor: const Color(0xFF0C67B0),
                          inactiveTrackColor: const Color(0xFFE8E112),
                          thumbColor: Colors.white,
                          trackHeight: 4.0,
                          thumbShape: const CustomSliderThumbShape(
                          thumbRadius: 8.0, 
                          borderThickness: 2.0, 
                          borderColor: Colors.blue),
                          overlayColor: const Color(0x00FFFFFF),
                          overlayShape: const RoundSliderOverlayShape(overlayRadius: 16.0),
                          ),
                         child: Slider(
                          min: 0,
                          max: 20000000,
                          divisions: 20,
                          value: _fondoEmergencia,
                          onChanged: (value) {
                         setState(() {
                          _fondoEmergencia = value;
                         });
                        },
                       ),
                       ),
                      Container(
                        margin: EdgeInsets.only(left:MediaQuery.of(context).size.height * 0.020 ),
                        child: Row(
                          children: [Expanded(
                              child: Text(
                              '0', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
                              ),
                              Text(
                              '20,000,000', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
         
                          ],
                        ),
                       )
                       ],
                      ),
                      ),

                      ],
                    )
                  ),
            Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.002, bottom: MediaQuery.of(context).size.height * 0.010 ),
                    child: Column(
                      children: [ 
                        Container(
                          margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.050, right:MediaQuery.of(context).size.height * 0.050, bottom: MediaQuery.of(context).size.height * 0.020 ),
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
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.035, right:MediaQuery.of(context).size.height * 0.035, bottom:MediaQuery.of(context).size.height * 0.040 ),
                         child: Column(
                           children: [
                               Text(
                              '${NumberFormat('#,###,###').format(_fondoAhorro)}  COP',
                               style: const TextStyle(fontSize: 12),
                             ),
                          SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                          activeTrackColor: const Color(0xFF0C67B0),
                          inactiveTrackColor: const Color(0xFFE8E112),
                          thumbColor: Colors.white,
                          trackHeight: 4.0,
                          thumbShape: const CustomSliderThumbShape(
                          thumbRadius: 8.0, 
                          borderThickness: 2.0, 
                          borderColor: Colors.blue),
                          overlayColor: const Color(0x00FFFFFF),
                          overlayShape: const RoundSliderOverlayShape(overlayRadius: 16.0),
                          ),
                         child: Slider(
                          min: 0,
                          max: 20000000,
                          divisions: 20,
                          value: _fondoAhorro,
                          onChanged: (value) {
                         setState(() {
                          _fondoAhorro = value;
                         });
                        },
                       ),
                       ),
                      Container(
                        margin: EdgeInsets.only(left:MediaQuery.of(context).size.height * 0.020 ),
                        child: Row(
                          children: [Expanded(
                              child: Text(
                              '0', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
                              ),
                              Text(
                              '20,000,000', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
         
                          ],
                        ),
                       )
                       ],
                      ),
                      ),

                      ],
                    )
                  ),
        Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.002, bottom: MediaQuery.of(context).size.height * 0.010 ),
                    child: Column(
                      children: [ 
                        Container(
                          margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.050, right:MediaQuery.of(context).size.height * 0.050, bottom: MediaQuery.of(context).size.height * 0.020 ),
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
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.035, right:MediaQuery.of(context).size.height * 0.035, bottom:MediaQuery.of(context).size.height * 0.040 ),
                         child: Column(
                           children: [
                               Text(
                              '${NumberFormat('#,###,###').format(_fondoRetiro)}  COP',
                               style: const TextStyle(fontSize: 12),
                             ),
                          SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                          activeTrackColor: const Color(0xFF0C67B0),
                          inactiveTrackColor: const Color(0xFFE8E112),
                          thumbColor: Colors.white,
                          trackHeight: 4.0,
                          thumbShape: const CustomSliderThumbShape(
                          thumbRadius: 8.0, 
                          borderThickness: 2.0, 
                          borderColor: Colors.blue),
                          overlayColor: const Color(0x00FFFFFF),
                          overlayShape: const RoundSliderOverlayShape(overlayRadius: 16.0),
                          ),
                         child: Slider(
                          min: 0,
                          max: 20000000,
                          divisions: 20,
                          value: _fondoRetiro,
                          onChanged: (value) {
                         setState(() {
                          _fondoRetiro = value;
                         });
                        },
                       ),
                       ),
                      Container(
                        margin: EdgeInsets.only(left:MediaQuery.of(context).size.height * 0.020 ),
                        child: Row(
                          children: [Expanded(
                              child: Text(
                              '0', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
                              ),
                              Text(
                              '20,000,000', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
         
                          ],
                        ),
                       )
                       ],
                      ),
                      ),

                      ],
                    )
                  ),
            Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.002, bottom: MediaQuery.of(context).size.height * 0.010 ),
                    child: Column(
                      children: [ 
                        Container(
                          margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.050, right:MediaQuery.of(context).size.height * 0.050, bottom: MediaQuery.of(context).size.height * 0.020 ),
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
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.035, right:MediaQuery.of(context).size.height * 0.035, bottom:MediaQuery.of(context).size.height * 0.040 ),
                         child: Column(
                           children: [
                               Text(
                              '${NumberFormat('#,###,###').format(_inversiones)}  COP',
                               style: const TextStyle(fontSize: 12),
                             ),
                          SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                          activeTrackColor: const Color(0xFF0C67B0),
                          inactiveTrackColor: const Color(0xFFE8E112),
                          thumbColor: Colors.white,
                          trackHeight: 4.0,
                          thumbShape: const CustomSliderThumbShape(
                          thumbRadius: 8.0, 
                          borderThickness: 2.0, 
                          borderColor: Colors.blue),
                          overlayColor: const Color(0x00FFFFFF),
                          overlayShape: const RoundSliderOverlayShape(overlayRadius: 16.0),
                          ),
                         child: Slider(
                          min: 0,
                          max: 20000000,
                          divisions: 20,
                          value: _inversiones,
                          onChanged: (value) {
                         setState(() {
                          _inversiones = value;
                         });
                        },
                       ),
                       ),
                      Container(
                        margin: EdgeInsets.only(left:MediaQuery.of(context).size.height * 0.020 ),
                        child: Row(
                          children: [Expanded(
                              child: Text(
                              '0', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
                              ),
                              Text(
                              '20,000,000', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
         
                          ],
                        ),
                       )
                       ],
                      ),
                      ),

                      ],
                    )
                  ),
            Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.002, bottom: MediaQuery.of(context).size.height * 0.010 ),
                    child: Column(
                      children: [ 
                        Container(
                          margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.050, right:MediaQuery.of(context).size.height * 0.050, bottom: MediaQuery.of(context).size.height * 0.020 ),
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
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.035, right:MediaQuery.of(context).size.height * 0.035, bottom:MediaQuery.of(context).size.height * 0.040 ),
                         child: Column(
                           children: [
                               Text(
                              '${NumberFormat('#,###,###').format(_otrosAhorros)}  COP',
                               style: const TextStyle(fontSize: 12),
                             ),
                          SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                          activeTrackColor: const Color(0xFF0C67B0),
                          inactiveTrackColor: const Color(0xFFE8E112),
                          thumbColor: Colors.white,
                          trackHeight: 4.0,
                          thumbShape: const CustomSliderThumbShape(
                          thumbRadius: 8.0, 
                          borderThickness: 2.0, 
                          borderColor: Colors.blue),
                          overlayColor: const Color(0x00FFFFFF),
                          overlayShape: const RoundSliderOverlayShape(overlayRadius: 16.0),
                          ),
                         child: Slider(
                          min: 0,
                          max: 20000000,
                          divisions: 20,
                          value: _otrosAhorros,
                          onChanged: (value) {
                         setState(() {
                          _otrosAhorros = value;
                         });
                        },
                       ),
                       ),
                      Container(
                        margin: EdgeInsets.only(left:MediaQuery.of(context).size.height * 0.020 ),
                        child: Row(
                          children: [Expanded(
                              child: Text(
                              '0', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
                              ),
                              Text(
                              '20,000,000', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
         
                          ],
                        ),
                       )
                       ],
                      ),
                      ),

                      ],
                    )
                  ),
              Container(
                margin: const EdgeInsets.only(top: 30, bottom: 30, left: 20, right: 20),
                child: ElevatedButton(
                  onPressed: () => {
                    if (
                      _salario == 0 &&
                      _inversionesPesos == 0 &&
                      _inversionesUsd == 0 &&
                      _alquileresInmobiliarios == 0 &&
                      _dividendos == 0 &&
                      _pensiones == 0 && 
                      _otrosIngresos == 0
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

