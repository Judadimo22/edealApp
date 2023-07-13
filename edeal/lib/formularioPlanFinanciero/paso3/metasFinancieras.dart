import 'dart:async';
import 'dart:convert';
import 'package:edeal/formularioPlanFinanciero/definirObjetivos.dart';
import 'package:edeal/formularioPlanFinanciero/perfilRiesgo.dart';
import 'package:edeal/views/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:edeal/widgets/barraSeleccion.dart';
import 'package:edeal/widgets/sliderPalabras.dart';
import 'package:edeal/widgets/subtitulo.dart';
import 'package:edeal/widgets/seleccion.dart';
import 'package:edeal/widgets/sliderMeses.dart';
import 'package:edeal/widgets/input.dart';

class MetasFinancieras extends StatefulWidget {
  final String token;

  MetasFinancieras({required this.token, Key? key}) : super(key: key);

  @override
  State<MetasFinancieras> createState() => _MetasFinancierasState();
}

class _MetasFinancierasState extends State<MetasFinancieras> {
  late String userId;
  Map<String, dynamic> userData = {};

  final TextEditingController _anoIniciariaController = TextEditingController();
  final TextEditingController _anosEstudiariaController = TextEditingController();
  final TextEditingController _nombreInstitucionController = TextEditingController();
  final TextEditingController _numeroHijosController = TextEditingController();
  final TextEditingController _nombreEstudianteController = TextEditingController();

 
  
  double _plazoVacaciones = 1;
  double _valorVacaciones = 0;
  String _importanciaVacaciones = 'No me importa';
  double _plazoAutomovil = 1;
  double _valorAutomovil = 0;
  String _importanciaAutomovil = 'No me importa';
  double _plazoEducacion = 1;
  double _valorEducacion = 0;
  String _importanciaEducacion = 'No me importa';
  double _plazoInmuebleColombia = 1;
  double _valorInmuebleColombia = 0;
  String _importanciaInmuebleColombia = 'No me importa';
  double _plazoInmuebleUsa = 1;
  double _valorInmuebleUsa = 0;
  String _importanciaInmuebleUsa = 'No me importa';
  double _plazoTratamientosMedicos = 1;
  double _valorTratamientosMedicos = 0;
  String _importanciaTratamientosMedicos = 'No me importa';
  double _plazoTecnologia = 1;
  double _valorTecnologia = 0;
  String _importanciaTecnologia = 'No me importa';
  double _plazoEntretenimiento = 1;
  double _valorEntretenimiento = 0;
  String _importanciaEntretenimiento = 'No me importa';
  double _plazoEventosDeportivos = 1;
  double _valorEventosDeportivos = 0;
  String _importanciaEventosDeportivos = 'No me importa';
  double _plazoOtros = 1;
  double _valorOtros = 0;
  String _importanciaOtros = 'No me importa';
  double _importanciaEdtudio = 1;
  double _montoEstimadoEstudio = 0;
  



  String _vacionesViajes = 'Vacaciones/viajes';
  String _automovil = 'Automovil';
  String _educacion = 'Educacion';
  String _inmuebleColombia = 'Inmueble en Colombia';
  String _inmuebleUsa = 'Inmueble en USA';
  String _tratamientosMedicos = 'Tratamientos medicos y esteticos';
  String _tecnologia = 'Tecnologia';
  String _entretenimiento = 'Entretenimiento';
  String _eventosDeportivos = 'Eventos deportivos internacionales';
  String _otros = 'Otros';
  String _formEducacion = 'Pagar programa';
  String _tipoInstitucion = 'Tipo de institucion educativa';
  String _ubicacion = 'Ubicacion';



  bool _showTextFieldVacacionesViajes= false;
  bool _showTextFieldAutomovil= false;
  bool _showTextFieldEducacion = false;
  bool _showTextFieldInmuebleColombia = false;
  bool _showTextFieldInmuebleUsa = false;
  bool _showTextFieldTratamientosMedicos= false;
  bool _showTextFieldTecnologia= false;
  bool _showTextFieldEntretenimiento = false;
  bool _showTextFieldEventosDeportivos = false;
  bool _showTextFieldOtros = false;
  bool _showTextFieldFormEducacion = false;

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



  void updateVacacionesViajes(String? newVacacionesViajes) {
    setState(() {
      _vacionesViajes = newVacacionesViajes!;
      if (newVacacionesViajes == 'Si') {
        _showTextFieldVacacionesViajes = true;
      } else {
        _showTextFieldVacacionesViajes = false;
      }
    });
  }

  void updateAutomovil(String? newAutomovil) {
    setState(() {
      _automovil = newAutomovil!;
      if (newAutomovil == 'Si') {
        _showTextFieldAutomovil = true;
      } else {
        _showTextFieldAutomovil = false;
      }
    });
  }

  void updateEducacion(String? newEducacion) {
    setState(() {
      _educacion = newEducacion!;
      if (newEducacion == 'Si') {
        _showTextFieldEducacion = true;
      } else {
        _showTextFieldEducacion = false;
      }
    });
  }

  void updateInmuebleColombia(String? newInmuebleColombia) {
    setState(() {
      _inmuebleColombia = newInmuebleColombia!;
      if (newInmuebleColombia == 'Si') {
        _showTextFieldInmuebleColombia = true;
      } else {
        _showTextFieldInmuebleColombia = false;
      }
    });
  }

  void updateInmuebleUsa(String? newInmuebleUsa) {
    setState(() {
      _inmuebleUsa = newInmuebleUsa!;
      if (newInmuebleUsa == 'Si') {
        _showTextFieldInmuebleUsa = true;
      } else {
        _showTextFieldInmuebleUsa = false;
      }
    });
  }

  void updateTratamientosMedicos(String? newTratamientosMedicos) {
    setState(() {
      _tratamientosMedicos = newTratamientosMedicos!;
      if (newTratamientosMedicos == 'Si') {
        _showTextFieldTratamientosMedicos = true;
      } else {
        _showTextFieldTratamientosMedicos = false;
      }
    });
  }

  void updateTecnologia(String? newTecnologia) {
    setState(() {
      _tecnologia = newTecnologia!;
      if (newTecnologia == 'Si') {
        _showTextFieldTecnologia = true;
      } else {
        _showTextFieldTecnologia = false;
      }
    });
  }

  void updateEntretenimiento(String? newEntretenimiento) {
    setState(() {
      _entretenimiento = newEntretenimiento!;
      if (newEntretenimiento == 'Si') {
        _showTextFieldEntretenimiento = true;
      } else {
        _showTextFieldEntretenimiento = false;
      }
    });
  }

  void updateEventosDeportivos(String? newEventosDeportivos) {
    setState(() {
      _eventosDeportivos = newEventosDeportivos!;
      if (newEventosDeportivos == 'Si') {
        _showTextFieldEventosDeportivos = true;
      } else {
        _showTextFieldEventosDeportivos = false;
      }
    });
  }

  void updateOtros(String? newOtros) {
    setState(() {
      _otros = newOtros!;
      if (newOtros == 'Si') {
        _showTextFieldOtros = true;
      } else {
        _showTextFieldOtros = false;
      }
    });
  }

    void updateFormEducacion(String? newFormEducacion) {
    setState(() {
      _formEducacion = newFormEducacion!;
      if (newFormEducacion == 'Si') {
        _showTextFieldFormEducacion = true;
      } else {
        _showTextFieldFormEducacion = false;
      }
    });
  }

  void updateInstitucionEducativa(String? newInstitucionEducativa) {
    setState(() {
      _tipoInstitucion = newInstitucionEducativa!;
    });
  }

  void updateUbicacion(String? newUbicacion) {
    setState(() {
      _ubicacion = newUbicacion!;
    });
  }



  void saveMetasFinancieras() async {

    var response = await http.put(
      Uri.parse('https://edeal-app.onrender.com/metasFinancieras/$userId'),
      body: {
        'plazoVacaciones': _plazoVacaciones.toInt().toString(),
        'valorVacaciones': _valorVacaciones.toInt().toString(),
        'importanciaVacaciones': _importanciaVacaciones,
        'plazoAutomovil': _plazoAutomovil.toInt().toString(),
        'valorAutomovil': _valorAutomovil.toInt().toString(),
        'importanciaAutomovil': _importanciaAutomovil,
        'plazoEducacion': _plazoEducacion.toInt().toString(),
        'valorEducacion': _valorEducacion.toInt().toString(),
        'importanciaEducacion': _importanciaEducacion,
        'plazoInmuebleColombia': _plazoInmuebleColombia.toInt().toString(),
        'valorInmuebleColombia': _valorInmuebleColombia.toInt().toString(),
        'importanciaInmuebleColombia': _importanciaInmuebleColombia,
        'plazoInmuebleUsa': _plazoInmuebleUsa.toInt().toString(),
        'valorInmuebleUsa': _valorInmuebleUsa.toInt().toString(),
        'importanciaInmuebleUsa': _importanciaInmuebleUsa,
        'plazoTratamientosMedicos': _plazoTratamientosMedicos.toInt().toString(),
        'valorTratamientosMedicos': _valorTratamientosMedicos.toInt().toString(),
        'importanciaTratamientosMedicos': _importanciaTratamientosMedicos,
        'plazoTecnologia': _plazoTecnologia.toInt().toString(),
        'valorTecnologia': _valorTecnologia.toInt().toString(),
        'importanciaTecnologia': _importanciaTecnologia,
        'plazoEntretenimiento': _plazoEntretenimiento.toInt().toString(),
        'valorEntretenimiento': _valorEntretenimiento.toInt().toString(),
        'importanciaEntretenimiento': _importanciaEntretenimiento,
        'plazoEventosDeportivos': _plazoEventosDeportivos.toInt().toString(),
        'valorEventosDeportivos': _valorEventosDeportivos.toInt().toString(),
        'importanciaEventosDeportivos': _importanciaEventosDeportivos,
        'plazoOtros': _plazoOtros.toInt().toString(),
        'valorOtros': _valorOtros.toInt().toString(),
        'importanciaOtros': _importanciaOtros,
        'numeroHijos': _numeroHijosController.text,
        'nombreEstudiante1': _nombreEstudianteController.text,
        'añoIniciara': _anoIniciariaController.text,
        'añosEstudiaria': _anosEstudiariaController.text,
        'importanciaEducacionEstudiante1': _importanciaEdtudio.toInt().toString(),
        'montoEstimadoEducacion': _montoEstimadoEstudio.toInt().toString(),
        'tipoInstitucionEducativa': _tipoInstitucion,
        'ubicacionEstudiante1': _ubicacion,
        'nombreInstitucionEducativa': _nombreInstitucionController.text
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        userData['plazoVacaciones'] = _plazoVacaciones.toInt().toString();
        userData['valorVacaciones'] = _valorVacaciones.toInt().toString();
        userData['importanciaVacaciones'] = _importanciaVacaciones;
        userData['plazoAutomovil'] = _plazoAutomovil.toInt().toString();
        userData['valorAutomovil'] = _valorAutomovil.toInt().toString();
        userData['importanciaAutomovil'] = _importanciaAutomovil;
        userData['plazoEducacion'] = _plazoEducacion.toInt().toString();
        userData['valorEducacion'] = _valorEducacion.toInt().toString();
        userData['importanciaEducacion'] = _importanciaEducacion;
        userData['plazoInmuebleColombia'] = _plazoInmuebleColombia.toInt().toString();
        userData['valorInmuebleColombia'] = _valorInmuebleColombia.toInt().toString();
        userData['importanciaInmuebleColombia'] = _importanciaInmuebleColombia;
        userData['plazoInmuebleUsa'] = _plazoInmuebleUsa.toInt().toString();
        userData['valorInmuebleUsa'] = _valorInmuebleUsa.toInt().toString();
        userData['importanciaInmuebleUsa'] = _importanciaInmuebleUsa;
        userData['plazoTratamientosMedicos'] = _plazoTratamientosMedicos.toInt().toString();
        userData['valorTratamientosMedicos'] = _valorTratamientosMedicos.toInt().toString();
        userData['importanciaTratamientosMedicos'] = _importanciaTratamientosMedicos;
        userData['plazoTecnologia'] = _plazoTecnologia.toInt().toString();
        userData['valorTecnologia'] = _valorTecnologia.toInt().toString();
        userData['importanciaTecnologia'] = _importanciaTecnologia;
        userData['plazoEntretenimiento'] = _plazoEntretenimiento.toInt().toString();
        userData['valorEntretenimiento'] = _valorEntretenimiento.toInt().toString();
        userData['importanciaEntretenimiento'] = _importanciaEntretenimiento;
        userData['plazoEventosDeportivos'] = _plazoEventosDeportivos.toInt().toString();
        userData['valorEventosDeportivos'] = _valorEventosDeportivos.toInt().toString();
        userData['importanciaEventosDeportivos'] = _importanciaEventosDeportivos;
        userData['plazoOtros'] = _plazoOtros.toInt().toString();
        userData['valorOtros'] = _valorOtros.toInt().toString();
        userData['importanciaOtros'] = _importanciaOtros;
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Metas financieras atualizadas'),
            content: Text('Tus Metas financieras han sido actualizadas'),
            actions: [
              TextButton(
                  onPressed: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>PerfilRiesgo(token: widget.token)));
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
      body:SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.050 ),
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
              Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.080, left: MediaQuery.of(context).size.height * 0.040),
              child: Column(
                children: [
                  Text(
                'Metas                  ',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF444C52),
                  fontSize: MediaQuery.of(context).size.height * 0.035,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  letterSpacing: -0.01
                )
              ),
              Text(
                ' financieras        ',
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
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.020, bottom: MediaQuery.of(context).size.height * 0.035 ),
              child:Text(
                '1/4',
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
                'Por favor indiquenos la siguiente información sobre sus metas financieras',
                style: GoogleFonts.inter(
                  color: const Color(0xFF817F7F),
                  fontSize: MediaQuery.of(context).size.height * 0.020,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  letterSpacing: -0.01
                )
              ),
            ),
            CustomTextWidget(
              text: 'Vacaciones/ viajes', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ),
                    CustomDropdownWidget(
                      value: _vacionesViajes, 
                      onChanged: updateVacacionesViajes, 
                      items: const [
                        'Vacaciones/viajes',
                        'Si',
                        'No'
                      ]), 
      if (_showTextFieldVacacionesViajes)
                    Column(
                      children: [
            Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.030, ),
                    child: Column(
                      children: [ 
                        CustomTextWidget(
                          text: 'Plazo de la meta', 
                          fontSize: MediaQuery.of(context).size.height * 0.016, 
                          fontWeight: FontWeight.w500
                          ),
                        SliderMeses(
                          value: _plazoVacaciones,
                          min: 1,
                          max: 24,
                          divisions: 20,
                          onChanged: (value) {
                            setState(() {
                              _plazoVacaciones = value;
                            });
                          },
                          ),
                        Container(
                        margin: EdgeInsets.only(left:MediaQuery.of(context).size.height * 0.040, right: MediaQuery.of(context).size.height * 0.040  ),
                        child: Row(
                          children: [Expanded(
                              child: Text(
                              '1 mes', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
                              ),
                              Text(
                              '24 meses', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
         
                          ],
                        ),
                       ), 
                      ],
                    )
                  ),
              Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.000, ),
                    child: Column(
                      children: [ 
                        CustomTextWidget(
                          text: 'Valor de las meta', 
                          fontSize: MediaQuery.of(context).size.height * 0.016, 
                          fontWeight: FontWeight.w500
                          ),
                        CustomSliderWidget(
                          value: _valorVacaciones, 
                          min: 0, 
                          max: 20000000, 
                          divisions: 20, 
                          onChanged: (value) {
                            setState(() {
                              _valorVacaciones = value;
                            });
                          },
                          ),
                        Container(
                        margin: EdgeInsets.only(left:MediaQuery.of(context).size.height * 0.050, right: MediaQuery.of(context).size.height * 0.045, bottom: MediaQuery.of(context).size.height * 0.020   ),
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
                    )
                  ),
                  Container(
                          margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.050, right:MediaQuery.of(context).size.height * 0.050, bottom: MediaQuery.of(context).size.height * 0.015 ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Importancia de la meta', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.016,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
                          ) ,
                        ), 
                     CustomWordSliderWidget(
                      value: _importanciaVacaciones, 
                      words: const ['No me importa', 'Me importa poco', 'Me importa', 'Me importa mucho', 'Indispensable'], 
                      onChanged: (value) {
                            setState(() {
                              _importanciaVacaciones = value;
                            });
                          },
                      ),
                      
                      ],
                    ),
                    CustomTextWidget(
                      text: 'Automovil', 
                      fontSize: MediaQuery.of(context).size.height * 0.016 , 
                      fontWeight: FontWeight.w500
                    ),
                    CustomDropdownWidget(
                      value: _automovil, 
                      onChanged: updateAutomovil, 
                      items: const [
                        'Automovil', 
                        'Si',
                        'No'
                      ]),
                if(_showTextFieldAutomovil)
                 Column(
                    children: [
                  CustomTextWidget(
                  text: 'PLazo de la meta', 
                  fontSize: MediaQuery.of(context).size.height * 0.016 , 
                  fontWeight: FontWeight.w500
                  ),
                SliderMeses(
                  value: _plazoAutomovil, 
                  min: 1, 
                  max: 24, 
                  divisions: 24, 
                  onChanged: (value) {
                    setState(() {
                      _plazoAutomovil = value;
                    });
                },),
              Container(
                        margin: EdgeInsets.only(left:MediaQuery.of(context).size.height * 0.040, right: MediaQuery.of(context).size.height * 0.040  ),
                        child: Row(
                          children: [Expanded(
                              child: Text(
                              '1 mes', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
                              ),
                              Text(
                              '24 meses', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
         
                          ],
                        ),
                       ), 
                CustomTextWidget(
                  text: 'Valor de la meta', 
                  fontSize: MediaQuery.of(context).size.height * 0.016 , 
                  fontWeight: FontWeight.w500
                  ),
                CustomSliderWidget(
                  value: _valorAutomovil, 
                  min: 0, 
                  max: 20000000, 
                  divisions: 20, 
                  onChanged: (value) {
                    setState(() {
                      _valorAutomovil = value;
                    });
                }),
                Container(
                        margin: EdgeInsets.only(left:MediaQuery.of(context).size.height * 0.050, right: MediaQuery.of(context).size.height * 0.045, bottom: MediaQuery.of(context).size.height * 0.010   ),
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
                       ),
                CustomTextWidget(
                  text: 'Importancia de la meta', 
                  fontSize: MediaQuery.of(context).size.height * 0.016 , 
                  fontWeight: FontWeight.w500
                  ),
                CustomWordSliderWidget(
                  value: _importanciaAutomovil, 
                  words: const ['No me importa', 'Me importa poco', 'Me importa', 'Me importa mucho', 'Indispensable'], 
                  onChanged: (value) {
                            setState(() {
                              _importanciaAutomovil = value;
                            });
                          },
                  )
                    ],
                  ),
              
              CustomTextWidget(
                text: 'Educacion', 
                fontSize: MediaQuery.of(context).size.height * 0.016 , 
                fontWeight: FontWeight.w500
                ),
              CustomDropdownWidget(
                value: _educacion, 
                onChanged: updateEducacion, 
                items: const [
                  'Educacion',
                  'Si',
                  'No'
                ]
                ),
              if(_showTextFieldEducacion)
              Column(
                children: [
                  CustomTextWidget(
                    text: 'Plazo de la meta', 
                    fontSize: MediaQuery.of(context).size.height * 0.016, 
                    fontWeight: FontWeight.w500
                    ),
                  SliderMeses(
                    value: _plazoEducacion, 
                    min: 1, 
                    max: 24, 
                    divisions: 24, 
                    onChanged: (value) {
                    setState(() {
                      _plazoEducacion = value;
                    });
                },
                    ),
                  Container(
                        margin: EdgeInsets.only(left:MediaQuery.of(context).size.height * 0.040, right: MediaQuery.of(context).size.height * 0.040  ),
                        child: Row(
                          children: [Expanded(
                              child: Text(
                              '1 mes', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
                              ),
                              Text(
                              '24 meses', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
         
                          ],
                        ),
                       ), 
                  CustomTextWidget(
                    text: 'Valor de la meta', 
                    fontSize: MediaQuery.of(context).size.height * 0.016, 
                    fontWeight: FontWeight.w500
                    ),
                  CustomSliderWidget(
                    value: _valorEducacion, 
                    min: 0, 
                    max: 20000000, 
                    divisions: 20, 
                    onChanged: (value) {
                    setState(() {
                      _valorEducacion = value;
                    });
                }
                    ),
                  Container(
                        margin: EdgeInsets.only(left:MediaQuery.of(context).size.height * 0.050, right: MediaQuery.of(context).size.height * 0.045, bottom: MediaQuery.of(context).size.height * 0.010   ),
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
                       ),
                  CustomTextWidget(
                    text: 'Importancia de la meta', 
                    fontSize: MediaQuery.of(context).size.height * 0.016, 
                    fontWeight: FontWeight.w500
                    ),
                  CustomWordSliderWidget(
                    value: _importanciaEducacion, 
                    words: const ['No me importa', 'Me importa poco', 'Me importa', 'Me importa mucho', 'Indispensable'], 
                    onChanged: (value) {
                      setState(() {
                      _importanciaEducacion = value;
                     });
                   },
                    )
                ],
              ),
              CustomTextWidget(
                text: 'Inmueble en Colombia', 
                fontSize: MediaQuery.of(context).size.height * 0.016, 
                fontWeight: FontWeight.w500
                ),
              CustomDropdownWidget(
                value: _inmuebleColombia, 
                onChanged: updateInmuebleColombia, 
                items: const [
                  'Inmueble en Colombia',
                  'Si',
                  'No'
                ]
                ),
              if(_showTextFieldInmuebleColombia)
              Column(
                children: [
                  CustomTextWidget(
                    text: 'Plazo de la meta', 
                    fontSize: MediaQuery.of(context).size.height * 0.016, 
                    fontWeight: FontWeight.w500
                    ),
                  SliderMeses(
                    value: _plazoInmuebleColombia, 
                    min: 1, 
                    max: 24, 
                    divisions: 24,
                     onChanged: (value) {
                    setState(() {
                      _plazoInmuebleColombia = value;
                    });
                },
                     ),
                  Container(
                        margin: EdgeInsets.only(left:MediaQuery.of(context).size.height * 0.040, right: MediaQuery.of(context).size.height * 0.040  ),
                        child: Row(
                          children: [Expanded(
                              child: Text(
                              '1 mes', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
                              ),
                              Text(
                              '24 meses', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
         
                          ],
                        ),
                       ), 
                  CustomTextWidget(
                    text: 'Valor de la meta', 
                    fontSize: MediaQuery.of(context).size.height * 0.016 , 
                    fontWeight: FontWeight.w500
                    ),
                  CustomSliderWidget(
                    value: _valorInmuebleColombia, 
                    min: 0, 
                    max: 20000000, 
                    divisions: 20, 
                    onChanged: (value) {
                    setState(() {
                      _valorInmuebleColombia = value;
                    });
                } 
                    ),
                  Container(
                        margin: EdgeInsets.only(left:MediaQuery.of(context).size.height * 0.050, right: MediaQuery.of(context).size.height * 0.045, bottom: MediaQuery.of(context).size.height * 0.010   ),
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
                       ),
                  CustomTextWidget(
                    text: 'Importancia de la meta', 
                    fontSize: MediaQuery.of(context).size.height * 0.016, 
                    fontWeight: FontWeight.w500
                    ),
                  CustomWordSliderWidget(
                    value: _importanciaInmuebleColombia, 
                    words: const ['No me importa', 'Me importa poco', 'Me importa', 'Me importa mucho', 'Indispensable'] , 
                    onChanged: (value) {
                      setState(() {
                      _importanciaInmuebleColombia = value;
                     });
                   },
                    )
                ],
              ),
              CustomTextWidget(
                text: 'Inmueble en Usa', 
                fontSize: MediaQuery.of(context).size.height * 0.016, 
                fontWeight: FontWeight.w500
                ),
              CustomDropdownWidget(
                value: _inmuebleUsa, 
                onChanged: updateInmuebleUsa, 
                items: const [
                  'Inmueble en USA',
                  'Si',
                  'No'
                ]
                ),
              if(_showTextFieldInmuebleUsa)
              Column(
                children: [
                  CustomTextWidget(
                    text: 'Plazo de la meta', 
                    fontSize: MediaQuery.of(context).size.height * 0.016, 
                    fontWeight: FontWeight.w500
                    ),
                  SliderMeses(
                    value: _plazoInmuebleUsa, 
                    min: 1, 
                    max: 24, 
                    divisions: 24, 
                    onChanged: (value) {
                    setState(() {
                      _plazoInmuebleUsa = value;
                    });
                },
                    ),
                Container(
                        margin: EdgeInsets.only(left:MediaQuery.of(context).size.height * 0.040, right: MediaQuery.of(context).size.height * 0.040  ),
                        child: Row(
                          children: [Expanded(
                              child: Text(
                              '1 mes', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
                              ),
                              Text(
                              '24 meses', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
         
                          ],
                        ),
                       ), 
                  CustomTextWidget(
                    text: 'Valor de la meta', 
                    fontSize: MediaQuery.of(context).size.height * 0.016, 
                    fontWeight: FontWeight.w500
                    ),
                  CustomSliderWidget(
                    value: _valorInmuebleUsa, 
                    min: 0, 
                    max: 20000000, 
                    divisions: 20, 
                    onChanged: (value) {
                    setState(() {
                      _valorInmuebleUsa = value;
                    });
                } 
                    ),
                  Container(
                        margin: EdgeInsets.only(left:MediaQuery.of(context).size.height * 0.050, right: MediaQuery.of(context).size.height * 0.045, bottom: MediaQuery.of(context).size.height * 0.010   ),
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
                       ),
                  CustomTextWidget(
                    text: 'Importancia de la meta', 
                    fontSize: MediaQuery.of(context).size.height * 0.016, 
                    fontWeight: FontWeight.w500
                    ),
                  CustomWordSliderWidget(
                    value: _importanciaInmuebleUsa, 
                    words: const ['No me importa', 'Me importa poco', 'Me importa', 'Me importa mucho', 'Indispensable']  , 
                    onChanged: (value) {
                      setState(() {
                      _importanciaInmuebleUsa = value;
                     });
                   },
                    )

                ],
              ),
            CustomTextWidget(
              text: 'Tratamientos médicos y estéticos', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ),
            CustomDropdownWidget(
              value: _tratamientosMedicos, 
              onChanged: updateTratamientosMedicos, 
              items: const[
                'Tratamientos medicos y esteticos',
                'Si',
                'No'
              ] 
              ),
            if(_showTextFieldTratamientosMedicos)
            Column(
              children: [
                CustomTextWidget(
                  text: 'Plazo de la meta', 
                  fontSize: MediaQuery.of(context).size.height * 0.016, 
                  fontWeight: FontWeight.w500
                  ),
                SliderMeses(
                  value: _plazoTratamientosMedicos, 
                  min: 1, 
                  max: 24, 
                  divisions: 24, 
                  onChanged: (value) {
                    setState(() {
                      _plazoTratamientosMedicos = value;
                    });
                },
                  ),
              Container(
                        margin: EdgeInsets.only(left:MediaQuery.of(context).size.height * 0.040, right: MediaQuery.of(context).size.height * 0.040  ),
                        child: Row(
                          children: [Expanded(
                              child: Text(
                              '1 mes', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
                              ),
                              Text(
                              '24 meses', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
         
                          ],
                        ),
                       ), 
                CustomTextWidget(
                  text: 'Valor de la meta', 
                  fontSize: MediaQuery.of(context).size.height * 0.016, 
                  fontWeight: FontWeight.w500
                  ),
                CustomSliderWidget(
                  value: _valorTratamientosMedicos, 
                  min: 0, 
                  max: 20000000, 
                  divisions: 20, 
                  onChanged: (value) {
                    setState(() {
                      _valorTratamientosMedicos = value;
                    });
                } 
                  ),
                Container(
                        margin: EdgeInsets.only(left:MediaQuery.of(context).size.height * 0.050, right: MediaQuery.of(context).size.height * 0.045, bottom: MediaQuery.of(context).size.height * 0.010   ),
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
                       ),
                CustomTextWidget(
                  text: 'Importancia de la meta', 
                  fontSize: MediaQuery.of(context).size.height * 0.016, 
                  fontWeight: FontWeight.w500
                  ),
                CustomWordSliderWidget(
                  value: _importanciaTratamientosMedicos, 
                  words: const ['No me importa', 'Me importa poco', 'Me importa', 'Me importa mucho', 'Indispensable'], 
                  onChanged: (value) {
                      setState(() {
                      _importanciaTratamientosMedicos = value;
                     });
                   },
                  )
              ],
            ),
            CustomTextWidget(
              text: 'Tecnologia', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ),
            CustomDropdownWidget(
              value: _tecnologia, 
              onChanged: updateTecnologia, 
              items: const[
                'Tecnologia',
                'Si',
                'No'
              ]
              ),
            if(_showTextFieldTecnologia)
            Column(
              children: [
                CustomTextWidget(
                  text: 'Plazo de la meta', 
                  fontSize: MediaQuery.of(context).size.height * 0.016, 
                  fontWeight: FontWeight.w500
                  ),
                SliderMeses(
                  value: _plazoTecnologia, 
                  min: 1, 
                  max: 24, 
                  divisions: 24, 
                  onChanged: (value) {
                    setState(() {
                      _plazoTecnologia = value;
                    });
                },
                  ),
              Container(
                        margin: EdgeInsets.only(left:MediaQuery.of(context).size.height * 0.040, right: MediaQuery.of(context).size.height * 0.040  ),
                        child: Row(
                          children: [Expanded(
                              child: Text(
                              '1 mes', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
                              ),
                              Text(
                              '24 meses', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
         
                          ],
                        ),
                       ), 
                CustomTextWidget(
                  text: 'Valor de la meta', 
                  fontSize: MediaQuery.of(context).size.height * 0.016, 
                  fontWeight: FontWeight.w500
                  ),
                CustomSliderWidget(
                  value: _valorTecnologia, 
                  min: 0, 
                  max: 20000000, 
                  divisions: 20, 
                  onChanged: (value) {
                    setState(() {
                      _valorTecnologia = value;
                    });
                } 
                  ),
                Container(
                        margin: EdgeInsets.only(left:MediaQuery.of(context).size.height * 0.050, right: MediaQuery.of(context).size.height * 0.045, bottom: MediaQuery.of(context).size.height * 0.010   ),
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
                       ),
                CustomTextWidget(
                  text: 'Importancia de la meta', 
                  fontSize: MediaQuery.of(context).size.height * 0.016, 
                  fontWeight: FontWeight.w500
                  ),
                CustomWordSliderWidget(
                  value: _importanciaTecnologia, 
                  words: const ['No me importa', 'Me importa poco', 'Me importa', 'Me importa mucho', 'Indispensable'],  
                  onChanged: (value) {
                      setState(() {
                      _importanciaTecnologia = value;
                     });
                   },
                  )
              ],
            ),
            CustomTextWidget(
              text: 'Entretenimiento - Conciertos y festivales', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ),
            CustomDropdownWidget(
              value: _entretenimiento, 
              onChanged: updateEntretenimiento, 
              items: const [
                'Entretenimiento',
                'Si',
                'No'
              ]
              ),
            if(_showTextFieldEntretenimiento)
            Column(
              children: [
                CustomTextWidget(
                  text: 'Plazo de la meta', 
                  fontSize: MediaQuery.of(context).size.height * 0.016, 
                  fontWeight: FontWeight.w500
                  ),
                SliderMeses(
                  value: _plazoEntretenimiento, 
                  min: 1, 
                  max: 24, 
                  divisions: 24, 
                  onChanged: (value) {
                    setState(() {
                      _plazoEntretenimiento = value;
                    });
                },
                  ),
              Container(
                        margin: EdgeInsets.only(left:MediaQuery.of(context).size.height * 0.040, right: MediaQuery.of(context).size.height * 0.040  ),
                        child: Row(
                          children: [Expanded(
                              child: Text(
                              '1 mes', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
                              ),
                              Text(
                              '24 meses', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
         
                          ],
                        ),
                       ), 
                CustomTextWidget(
                  text: 'Valor de la meta', 
                  fontSize: MediaQuery.of(context).size.height * 0.016, 
                  fontWeight: FontWeight.w500
                  ),
                CustomSliderWidget(
                  value: _valorEntretenimiento, 
                  min: 0, 
                  max: 20000000, 
                  divisions: 20, 
                  onChanged: (value) {
                    setState(() {
                      _valorEntretenimiento = value;
                    });
                } 
                  ),
                Container(
                        margin: EdgeInsets.only(left:MediaQuery.of(context).size.height * 0.050, right: MediaQuery.of(context).size.height * 0.045, bottom: MediaQuery.of(context).size.height * 0.010   ),
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
                       ),
                CustomTextWidget(
                  text: 'Importancia de la meta', 
                  fontSize: MediaQuery.of(context).size.height * 0.016, 
                  fontWeight: FontWeight.w500
                  ),
                CustomWordSliderWidget(
                  value: _importanciaEntretenimiento, 
                  words: const ['No me importa', 'Me importa poco', 'Me importa', 'Me importa mucho', 'Indispensable'], 
                  onChanged: (value) {
                      setState(() {
                      _importanciaEntretenimiento = value;
                     });
                   },
                  )
              ],
            ),
            CustomTextWidget(
              text: 'Eventos deportivos internacionales', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ),
            CustomDropdownWidget(
              value: _eventosDeportivos, 
              onChanged: updateEventosDeportivos, 
              items: const [
                'Eventos deportivos internacionales',
                'Si',
                'No'
              ] 
              ),
            if(_showTextFieldEventosDeportivos)
            Column(
              children: [
                CustomTextWidget(
                  text: 'Plazo de la meta', 
                  fontSize: MediaQuery.of(context).size.height * 0.016, 
                  fontWeight: FontWeight.w500
                  ),
                SliderMeses(
                  value: _plazoEventosDeportivos, 
                  min: 1, 
                  max: 24, 
                  divisions: 24, 
                  onChanged: (value) {
                    setState(() {
                      _plazoEventosDeportivos = value;
                    });
                },
                  ),
              Container(
                        margin: EdgeInsets.only(left:MediaQuery.of(context).size.height * 0.040, right: MediaQuery.of(context).size.height * 0.040  ),
                        child: Row(
                          children: [Expanded(
                              child: Text(
                              '1 mes', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
                              ),
                              Text(
                              '24 meses', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
         
                          ],
                        ),
                       ), 
                CustomTextWidget(
                  text: 'Valor de la meta', 
                  fontSize: MediaQuery.of(context).size.height * 0.016, 
                  fontWeight: FontWeight.w500
                  ),
                CustomSliderWidget(
                  value: _valorEventosDeportivos, 
                  min: 0, 
                  max: 20000000, 
                  divisions: 20, 
                  onChanged: (value) {
                    setState(() {
                      _valorEventosDeportivos = value;
                    });
                } 
                  ),
                Container(
                        margin: EdgeInsets.only(left:MediaQuery.of(context).size.height * 0.050, right: MediaQuery.of(context).size.height * 0.045, bottom: MediaQuery.of(context).size.height * 0.010   ),
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
                       ),
                CustomTextWidget(
                  text: 'Importancia de la meta', 
                  fontSize: MediaQuery.of(context).size.height * 0.016, 
                  fontWeight: FontWeight.w500
                  ),
                CustomWordSliderWidget(
                  value: _importanciaEventosDeportivos, 
                  words: const ['No me importa', 'Me importa poco', 'Me importa', 'Me importa mucho', 'Indispensable'], 
                  onChanged: (value) {
                      setState(() {
                      _importanciaEventosDeportivos= value;
                     });
                   },
                  )

              ],
            ),
            CustomTextWidget(
              text: 'Otros', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ),
            CustomDropdownWidget(
              value: _otros, 
              onChanged: updateOtros, 
              items: const [
                'Otros',
                'Si',
                'No'
              ]
              ),
            if(_showTextFieldOtros)
            Column(
              children: [
                CustomTextWidget(
                  text: 'Plazo de la meta', 
                  fontSize: MediaQuery.of(context).size.height * 0.016, 
                  fontWeight: FontWeight.w500
                  ),
                SliderMeses(
                  value: _plazoOtros, 
                  min: 1, 
                  max: 24, 
                  divisions: 24, 
                  onChanged: (value) {
                    setState(() {
                      _plazoOtros = value;
                    });
                },
                  ),
              Container(
                        margin: EdgeInsets.only(left:MediaQuery.of(context).size.height * 0.040, right: MediaQuery.of(context).size.height * 0.040  ),
                        child: Row(
                          children: [Expanded(
                              child: Text(
                              '1 mes', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
                              ),
                              Text(
                              '24 meses', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
         
                          ],
                        ),
                       ), 
                CustomTextWidget(
                  text: 'Valor de la meta', 
                  fontSize: MediaQuery.of(context).size.height * 0.016, 
                  fontWeight: FontWeight.w500
                  ),
                CustomSliderWidget(
                  value: _valorOtros, 
                  min: 0, 
                  max: 20000000, 
                  divisions: 20, 
                  onChanged: (value) {
                    setState(() {
                      _valorOtros = value;
                    });
                } 
                  ),
                Container(
                        margin: EdgeInsets.only(left:MediaQuery.of(context).size.height * 0.050, right: MediaQuery.of(context).size.height * 0.045, bottom: MediaQuery.of(context).size.height * 0.010   ),
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
                       ),
                CustomTextWidget(
                  text: 'Importancia de la meta', 
                  fontSize: MediaQuery.of(context).size.height * 0.016, 
                  fontWeight: FontWeight.w500
                ),
                CustomWordSliderWidget(
                  value: _importanciaOtros, 
                  words: const ['No me importa', 'Me importa poco', 'Me importa', 'Me importa mucho', 'Indispensable'], 
                  onChanged: (value) {
                      setState(() {
                      _importanciaOtros= value;
                     });
                   },)
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.050 ),
              child: Text(
                'Educación                     ',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF444C52),
                  fontSize: MediaQuery.of(context).size.height * 0.035,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  letterSpacing: -0.01
                )
              ),
            ),
          Container(
              margin: EdgeInsets.only(top: 20, left: MediaQuery.of(context).size.height * 0.050, right: MediaQuery.of(context).size.height * 0.050, bottom: MediaQuery.of(context).size.height * 0.010  ),
              child: Text(
                'Complete esta sección de objetivos si planea pagar la totalidad o parte de una universidad u otro programa educativo para un hijo, nieto u otra persona.',
                style: GoogleFonts.inter(
                  color: const Color(0xFF817F7F),
                  fontSize: MediaQuery.of(context).size.height * 0.020,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  letterSpacing: -0.01
                )
              ),
            ),
          CustomTextWidget(
            text: 'Desea pagar algún programa educativo', 
            fontSize: MediaQuery.of(context).size.height * 0.016, 
            fontWeight: FontWeight.w500
            ),
          CustomDropdownWidget(
            value: _formEducacion, 
            onChanged: updateFormEducacion, 
            items: const [
              'Pagar programa',
              'Si',
              'No'
            ]
            ),
          if(_showTextFieldFormEducacion)
          Column(
            children: [
              CustomTextWidget(
                text: 'Numero de hijos o personas a cargo de su educación', 
                fontSize: MediaQuery.of(context).size.height * 0.016, 
                fontWeight: FontWeight.w500
                ),
              CustomTextField(
                controller: _numeroHijosController, 
                keyboardType: TextInputType.number, 
                hintText: 'Número de personas a cargo de su educación'
                ),
              CustomTextWidget(
                text: 'Nombre del estudiante', 
                fontSize: MediaQuery.of(context).size.height * 0.016, 
                fontWeight: FontWeight.w500
                ),
              CustomTextField(
                controller: _nombreEstudianteController, 
                keyboardType: TextInputType.text, 
                hintText: 'Nombre del estudiante'
                ),
              CustomTextWidget(
                text: 'Año en el que iniciaría', 
                fontSize: MediaQuery.of(context).size.height * 0.016 , 
                fontWeight: FontWeight.w500
                ),
              CustomTextField(
                controller: _anoIniciariaController, 
                keyboardType: TextInputType.number, 
                hintText: 'Año en el que iniciaría'
                ),
              CustomTextWidget(
                text: 'Número de años que estudiaría', 
                fontSize: MediaQuery.of(context).size.height * 0.016, 
                fontWeight: FontWeight.w500
                ),
              CustomTextField(
                controller: _anosEstudiariaController, 
                keyboardType: TextInputType.number, 
                hintText: 'Años que estudiaría'
                ),
              CustomTextWidget(
                text: 'Importancia: mayor - menor (10-1)', 
                fontSize: MediaQuery.of(context).size.height * 0.016, 
                fontWeight: FontWeight.w500
                ),
              CustomSliderWidget(
                value: _importanciaEdtudio, 
                min: 1, 
                max: 10, 
                divisions: 9, 
                onChanged: (value) {
                    setState(() {
                      _importanciaEdtudio = value;
                    });
                }
                ),
              Container(
                        margin: EdgeInsets.only(left:MediaQuery.of(context).size.height * 0.050, right: MediaQuery.of(context).size.height * 0.045, bottom: MediaQuery.of(context).size.height * 0.010   ),
                        child: Row(
                          children: [Expanded(
                              child: Text(
                              '10', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
                              ),
                              Text(
                              '1', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.012,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
         
                          ],
                        ),
                       ),
              CustomTextWidget(
                text: 'Monto estimado anual', 
                fontSize: MediaQuery.of(context).size.height * 0.016, 
                fontWeight: FontWeight.w500
                ),
              CustomSliderWidget(
                value: _montoEstimadoEstudio, 
                min: 0, 
                max: 20000000, 
                divisions: 20, 
                onChanged: (value) {
                    setState(() {
                      _montoEstimadoEstudio = value;
                    });
                }
                ),
              Container(
                        margin: EdgeInsets.only(left:MediaQuery.of(context).size.height * 0.050, right: MediaQuery.of(context).size.height * 0.045, bottom: MediaQuery.of(context).size.height * 0.010   ),
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
                       ),
              CustomTextWidget(
                text: 'Tipo de institucion educativa', 
                fontSize: MediaQuery.of(context).size.height * 0.016, 
                fontWeight: FontWeight.w500
                ),
              CustomDropdownWidget(
                value: _tipoInstitucion, 
                onChanged: updateInstitucionEducativa, 
                items: const [
                  'Tipo de institucion educativa',
                  'Publica',
                  'Privada'
                ]
                ),
              CustomTextWidget(
                text: 'Ubicacion', 
                fontSize: MediaQuery.of(context).size.height * 0.016, 
                fontWeight: FontWeight.w500
                ),
              CustomDropdownWidget(
                value: _ubicacion, 
                onChanged: updateUbicacion, 
                items: const [
                  'Ubicacion',
                  'Dentro de mi ciudad',
                  'Fuera de mi ciudad',
                  'Fuera de mi país'
                ]
                ),
              CustomTextWidget(
                text: 'Nombre de la institucion educativa', 
                fontSize: MediaQuery.of(context).size.height * 0.016, 
                fontWeight: FontWeight.w500
                ),
              CustomTextField(
                controller: _nombreInstitucionController, 
                keyboardType: TextInputType.text, 
                hintText: 'Nombre de la institución'
                ),
              
            ],
          ),
          Center(
                    child: Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.030, bottom:MediaQuery.of(context).size.height * 0.020,),
                      child: ElevatedButton(
                        onPressed: (){
                          if (_vacionesViajes == 'Vacaciones/viajes') {
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
        } ,
      );
    } else {
      saveMetasFinancieras();
    }
                        } ,
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            )
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF0C67B0)
                          ),
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.33, vertical: MediaQuery.of(context).size.height * 0.005),
                          ),
                        ),
                         child: Text(
                              'Siguiente', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.width * 0.05,
                                fontWeight: FontWeight.w400,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
                      )
                    ),
                  ),
          ],
        ),
      
      ),
        )
      )
    );
  }
}


