import 'dart:convert';
import 'package:edeal/formularioPlanFinanciero/paso3/metasFinancieras.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:edeal/widgets/thumb.dart';

class Hogar extends StatefulWidget {
  final String token;

  const Hogar({required this.token, Key? key}) : super(key: key);

  @override
  State<Hogar> createState() => _HogarState();
}

class _HogarState extends State<Hogar> {
  late String userId;
  Map<String, dynamic> userData = {};
  double _alquiler = 0;
  double _serviciosPublicos = 0;
  double _mercado = 0;
  double _otrosGastosHogar = 0;
  double _gasolina = 0;
  double _mantenimientoVehiculo = 0;
  double _transportePublico = 0;
  double _viajes = 0;
  double _restaurantes = 0;
  double _eventosConciertos = 0;
  double _cuotaCreditoVivienda = 0;
  double _cuotaCreditoVehiculo = 0;
  double _cuotaTarjetaCredito = 0;
  double _cuotaOtrosCreditos = 0;
  double _seguroVehiculo = 0;
  double _seguroSalud = 0;
  double _seguroVida = 0;
  double _creditoUsd = 0;
  double _otrosGastosFinancieros = 0;
  double _renta = 0;
  double _predial = 0;
  double _impuestoVehiculos = 0;




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

  void saveGastosHogar() async {

    var response = await http.put(
      Uri.parse('https://edeal-app.onrender.com/gastos/$userId'),
      body: {
        'alquiler': _alquiler.toInt().toString(),
        'serviciosPublicos': _serviciosPublicos.toInt().toString(),
        'mercado': _mercado.toInt().toString(),
        'otrosGastosHogar': _otrosGastosHogar.toInt().toString(),
        'gasolina': _gasolina.toInt().toString(),
        'mantenimientoVehiculo': _mantenimientoVehiculo.toInt().toString(),
        'transportePublico': _transportePublico.toInt().toString(),
        'viajes': _viajes.toInt().toString(),
        'restaurantes': _restaurantes.toInt().toString(),
        'conciertos': _eventosConciertos.toInt().toString(),
        'cuotaCreditoVivienda': _cuotaCreditoVivienda.toInt().toString(),
        'cuotaCreditoVehiculo': _cuotaCreditoVehiculo.toInt().toString(),
        'cuotaTarjetaCredito': _cuotaTarjetaCredito.toInt().toString(),
        'cuotaOtrosCreditos': _cuotaOtrosCreditos.toInt().toString(),
        'seguroVehiculo': _seguroVehiculo.toInt().toString(),
        'seguroSalud': _seguroSalud.toInt().toString(),
        'seguroVida': _seguroSalud.toInt().toString(),
        'creditoUsd': _creditoUsd.toInt().toString(),
        'otrosGastosFinancieros': _otrosGastosFinancieros.toInt().toString(),
        'renta': _renta.toInt().toString(),
        'predial': _predial.toInt().toString(),
        'impuestoVehiculos': _impuestoVehiculos.toInt().toString(),
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        userData['alquiler'] = _alquiler.toInt().toString();
        userData['serviciosPublicos'] = _serviciosPublicos.toInt().toString();
        userData['mercado'] = _mercado.toInt().toString();
        userData['otrosGastosHogar'] = _otrosGastosHogar.toInt().toString();
        userData['gasolina'] = _gasolina.toInt().toString();
        userData['mantenimientoCarro'] = _mantenimientoVehiculo.toInt().toString();
        userData['transportePublico'] = _transportePublico.toInt().toString();
        userData['viajes'] = _viajes.toInt().toString();
        userData['restaurantes'] = _restaurantes.toInt().toString();
        userData['conciertos'] = _eventosConciertos.toInt().toString();
        userData['cuotaCreditoVivienda'] = _cuotaCreditoVivienda.toInt().toString();
        userData['cuotaCreditoVehiculo'] = _cuotaCreditoVehiculo.toInt().toString();
        userData['cuotaTarjetaCredito'] = _cuotaTarjetaCredito.toInt().toString();
        userData['cuotaOtrosCreditos'] = _cuotaOtrosCreditos.toInt().toString();
        userData['seguroVehiculo'] = _seguroVehiculo.toInt().toString();
        userData['seguroSalud'] = _seguroSalud.toInt().toString();
        userData['seguroVida'] = _seguroSalud.toInt().toString();
        userData['creditoUsd'] = _creditoUsd.toInt().toString();
        userData['otrosGastosFinancieros'] = _otrosGastosFinancieros.toInt().toString();
        userData['renta'] = _renta.toInt().toString();
        userData['predial'] = _predial.toInt().toString();
        userData['impuestoVehiculos'] = _impuestoVehiculos.toInt().toString();
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
                'Gastos actualizados',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.height * 0.020,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  letterSpacing: -0.01
                )
              ),
            content: Text(
                'Tus gastos han sido actualizados de manera correcta.',
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
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>MetasFinancieras(token: widget.token)));
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
                'Agrega tus             ',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF444C52),
                  fontSize: MediaQuery.of(context).size.height * 0.030,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  letterSpacing: -0.01
                )
              ),
              Text(
                ' gastos del hogar  ',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF444C52),
                  fontSize: MediaQuery.of(context).size.height * 0.030,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  letterSpacing: -0.01
                )
              )
                ],
              )
            ),
            Container(
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.010, bottom: MediaQuery.of(context).size.height * 0.035 ),
              child:Text(
                '3/6',
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
                'Por favor indiquenos la siguiente información de sus gastos del hogar',
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
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.035, right:MediaQuery.of(context).size.height * 0.035, bottom:MediaQuery.of(context).size.height * 0.045 ),
                         child: Column(
                           children: [
                               Text(
                              '${NumberFormat('#,###,###').format(_alquiler)}  COP',
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
                          value: _alquiler,
                          onChanged: (value) {
                         setState(() {
                          _alquiler = value;
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
                              'Servicios públicos', 
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
                              '${NumberFormat('#,###,###').format(_serviciosPublicos)}  COP',
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
                          value: _serviciosPublicos,
                          onChanged: (value) {
                         setState(() {
                          _serviciosPublicos = value;
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
                              'Mercado', 
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
                              '${NumberFormat('#,###,###').format(_mercado)}  COP',
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
                          value: _mercado,
                          onChanged: (value) {
                         setState(() {
                          _mercado = value;
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
                              'Otros', 
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
                              '${NumberFormat('#,###,###').format(_otrosGastosHogar)}  COP',
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
                          value: _otrosGastosHogar,
                          onChanged: (value) {
                         setState(() {
                          _otrosGastosHogar = value;
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
                'Agrega tus gastos     ',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF444C52),
                  fontSize: MediaQuery.of(context).size.height * 0.035,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  letterSpacing: -0.01
                )
              ),
              Text(
                'de transporte               ',
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
                'Por favor indiquenos la siguiente información de sus gastos en transporte',
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
                              'Gasolina', 
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
                              '${NumberFormat('#,###,###').format(_gasolina)}  COP',
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
                          value: _gasolina,
                          onChanged: (value) {
                         setState(() {
                          _gasolina = value;
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
                              'Mantenimiento de vehículo', 
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
                              '${NumberFormat('#,###,###').format(_mantenimientoVehiculo)}  COP',
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
                          value: _mantenimientoVehiculo,
                          onChanged: (value) {
                         setState(() {
                          _mantenimientoVehiculo = value;
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
                              'Transporte público', 
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
                              '${NumberFormat('#,###,###').format(_transportePublico)}  COP',
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
                          value: _transportePublico,
                          onChanged: (value) {
                         setState(() {
                          _transportePublico = value;
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
                'Agrega tus gastos      ',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF444C52),
                  fontSize: MediaQuery.of(context).size.height * 0.035,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  letterSpacing: -0.01
                )
              ),
              Text(
                'en vacaciones              ',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF444C52),
                  fontSize: MediaQuery.of(context).size.height * 0.035,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  letterSpacing: -0.01
                )
              ),
              Text(
                'y entretenimiento      ',
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
                'Por favor indiquenos la siguiente información de sus gastos en vacaciones y entretenimiento',
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
                              'Viajes', 
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
                              '${NumberFormat('#,###,###').format(_viajes)}  COP',
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
                          value: _viajes,
                          onChanged: (value) {
                         setState(() {
                          _viajes = value;
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
                              'Restaurantes', 
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
                              '${NumberFormat('#,###,###').format(_restaurantes)}  COP',
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
                          value: _restaurantes,
                          onChanged: (value) {
                         setState(() {
                          _restaurantes = value;
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
                              'Eventos y conciertos', 
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
                              '${NumberFormat('#,###,###').format(_eventosConciertos)} COP',
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
                          value: _eventosConciertos,
                          onChanged: (value) {
                         setState(() {
                          _eventosConciertos = value;
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
                'Agrega tus gastos     ',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF444C52),
                  fontSize: MediaQuery.of(context).size.height * 0.035,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  letterSpacing: -0.01
                )
              ),
              Text(
                'financieros                    ',
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
                'Por favor indiquenos la siguiente información de sus gastos financieros',
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
                              'Cuota crédito de vivienda', 
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
                              '${NumberFormat('#,###,###').format(_cuotaCreditoVivienda)}  COP',
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
                          value: _cuotaCreditoVivienda,
                          onChanged: (value) {
                         setState(() {
                          _cuotaCreditoVivienda = value;
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
                              'Cuota crédito vehículo', 
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
                              '${NumberFormat('#,###,###').format(_cuotaCreditoVehiculo)}  COP',
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
                          value: _cuotaCreditoVehiculo,
                          onChanged: (value) {
                         setState(() {
                          _cuotaCreditoVehiculo = value;
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
                              'Cuota tarjeta de crédito', 
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
                              '${NumberFormat('#,###,###').format(_cuotaTarjetaCredito)}  COP',
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
                          value: _cuotaTarjetaCredito,
                          onChanged: (value) {
                         setState(() {
                          _cuotaTarjetaCredito = value;
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
                              'Cuota otros créditos', 
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
                              '${NumberFormat('#,###,###').format(_cuotaOtrosCreditos)}  COP',
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
                          value: _cuotaOtrosCreditos,
                          onChanged: (value) {
                         setState(() {
                          _cuotaOtrosCreditos = value;
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
                              'Seguro de vehículo', 
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
                              '${NumberFormat('#,###,###').format(_seguroVehiculo)}  COP',
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
                          value: _seguroVehiculo,
                          onChanged: (value) {
                         setState(() {
                          _seguroVehiculo = value;
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
                              'Seguro de salud', 
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
                              '${NumberFormat('#,###,###').format(_seguroSalud)}  COP',
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
                          value: _seguroSalud,
                          onChanged: (value) {
                         setState(() {
                          _seguroSalud = value;
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
                              'Seguro de vida', 
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
                              '${NumberFormat('#,###,###').format(_seguroVida)}  COP',
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
                          value: _seguroVida,
                          onChanged: (value) {
                         setState(() {
                          _seguroVida = value;
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
                              'Crédito en USD', 
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
                              '${NumberFormat('#,###,###').format(_creditoUsd)}  USD',
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
                          value: _creditoUsd,
                          onChanged: (value) {
                         setState(() {
                          _creditoUsd = value;
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
                              'Otros gastos financieros', 
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
                              '${NumberFormat('#,###,###').format(_otrosGastosFinancieros)}  COP',
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
                          value: _otrosGastosFinancieros,
                          onChanged: (value) {
                         setState(() {
                          _otrosGastosFinancieros = value;
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
                'Agrega tus gastos     ',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF444C52),
                  fontSize: MediaQuery.of(context).size.height * 0.035,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  letterSpacing: -0.01
                )
              ),
              Text(
                'en impuestos               ',
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
                'Por favor indiquenos la siguiente información de sus gastos en impuestos',
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
                              'Renta', 
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
                              '${NumberFormat('#,###,###').format(_renta)}  COP',
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
                          value: _renta,
                          onChanged: (value) {
                         setState(() {
                          _renta = value;
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
                              'Predial', 
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
                              '${NumberFormat('#,###,###').format(_predial)}  COP',
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
                          value: _predial,
                          onChanged: (value) {
                         setState(() {
                          _predial = value;
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
                              'Vehículos', 
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
                              '${NumberFormat('#,###,###').format(_impuestoVehiculos)}  COP',
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
                          value: _impuestoVehiculos,
                          onChanged: (value) {
                         setState(() {
                          _impuestoVehiculos = value;
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
                      _eventosConciertos == 0 
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
