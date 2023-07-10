import 'dart:async';
import 'dart:convert';
import 'package:edeal/formularioPlanFinanciero/fuentesAdicionales.dart';
import 'package:edeal/views/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:edeal/widgets/barraSeleccion.dart';
import 'package:edeal/widgets/sliderPalabras.dart';
import 'package:edeal/widgets/subtitulo.dart';
import 'package:edeal/widgets/seleccion.dart';
import 'package:edeal/widgets/sliderMeses.dart';
import 'package:edeal/widgets/input.dart';

class PerfilRiesgo extends StatefulWidget {
  final String token;

  PerfilRiesgo({required this.token, Key? key}) : super(key: key);

  @override
  State<PerfilRiesgo> createState() => _PerfilRiesgoState();
}

class _PerfilRiesgoState extends State<PerfilRiesgo> {
  late String userId;
  Map<String, dynamic> userData = {};

  final _formKey = GlobalKey<FormState>();

  String _experienciaInversiones= 'Cual es su nivel de experiencia';
  String _poseo = 'He invertido o poseo algun activo';
  String _generarIngresos = 'Enumere la opcion';
  String _arriesgarCapital = 'Enumere la opcion';
  String _incrementarPatrimonio = 'Enumere la opcion';
  String _protegerPatrimonio = 'Enumere la opcion';
  String _perfil = 'Seleccione perfil';
  String _prioridades = 'Seleccione prioridades';
  String _anosRetiros = 'Seleccione años retiros';
  String _tiempoRetiros = 'Seleccione tiempo retiros';
  // String _valorAhorro = 'Valor del ahorro(millones):';
  String _plazo= 'Plazo(meses):';

  double _importanciaGenerarIngresos = 1;
  double _importanciaArriesgarCapital = 1;
  double _importanciaIncrementarPatrimonio = 1;
  double _importanciaProtegerPatrimonio = 1;
  String _perfilInversionista = 'Especulacion';
  String _prioridadFinanciera = 'Como aumentar mi patrimonio';
  String _iniciarRetiros = 'Corto plazo (menos de 2 años)';
  String _continuarRetiros = 'Corto plazo (menos de 2 años)';


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

  void updateExperienciaInversiones(String? newExperienciaInversiones) {
    setState(() {
      _experienciaInversiones = newExperienciaInversiones!;
    });
  }

  void updatePoseo(String? newPoseo) {
    setState(() {
      _poseo = newPoseo!;
    });
  }

  void updateGenrarIngresos(String? newGenerarIngresos) {
    setState(() {
      _generarIngresos = newGenerarIngresos!;
    });
  }

  void updateArriesgarCapital(String? newArriegarCapital) {
    setState(() {
      _arriesgarCapital = newArriegarCapital!;
    });
  }

  void updateIncrementarPatrimonio(String? newIncrementarPatrimonio) {
    setState(() {
      _incrementarPatrimonio = newIncrementarPatrimonio!;
    });
  }

  void updateProtegerPatrimonio(String? newProtegerPatrimonio) {
    setState(() {
      _protegerPatrimonio = newProtegerPatrimonio!;
    });
  }

  void updatePerfil(String? newPerfil) {
    setState(() {
      _perfil = newPerfil!;
    });
  }

  void updatePrioridades(String? newPrioridades) {
    setState(() {
      _prioridades = newPrioridades!;
    });
  }

  void updateAnosRetiros(String? newAnosRetiros) {
    setState(() {
      _anosRetiros = newAnosRetiros!;
    });
  }

  void updateTiempoRetiros(String? newTiempoRetiros) {
    setState(() {
      _tiempoRetiros = newTiempoRetiros!;
    });
  }

  void savePerfilRiesgo() async {
    // var newData = _newDataController.text;

    var response = await http.put(
      Uri.parse('https://edeal-app.onrender.com/perfilRiesgo/$userId'),
      body: {
        'experienciaInversiones': _experienciaInversiones,
        'poseoAlgunActivo': _poseo,
        'generarIngresos': _importanciaGenerarIngresos.toInt().toString(),
        'arriesgarMiCapital': _importanciaArriesgarCapital.toInt().toString(),
        'incrementarPatrimonio': _importanciaIncrementarPatrimonio.toInt().toString(),
        'protegerPatrimonio': _importanciaProtegerPatrimonio.toInt().toString(),
        'perfilActitudInversionista': _perfilInversionista,
        'prioridadesFinancieras': _prioridadFinanciera,
        'iniciarRetiros': _iniciarRetiros,
        'continuarRetiros': _continuarRetiros
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        userData['experienciaInversiones'] = _experienciaInversiones;
        userData['poseoAlgunActivo'] = _poseo;
        userData['generarIngresos'] = _generarIngresos;
        userData['arriesgarMiCapital'] = _arriesgarCapital;
        userData['incrementarPatrimonio'] = _incrementarPatrimonio;
        userData['protegerPatrimonio'] = _protegerPatrimonio;
        userData['perfilActitudInversionista'] = _perfil;
        userData['prioridadesFinancieras'] = _prioridades;
        userData['iniciarRetiros'] = _anosRetiros;      
        userData['continuarRetiros'] = _tiempoRetiros;       
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Perfil de riesgo actualizado'),
            content: Text('Gracias por completar el paso núnero 4.'),
            actions: [
              TextButton(
                  onPressed: (){
                    if (userData['experienciaInversiones'] == null){
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
                    }
            else {
             Navigator.push(context, MaterialPageRoute(builder: (context)=>FuentesAdicionales(token: widget.token)));
            }

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
      body: Container(
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.050),
        child: Center(
        child: SingleChildScrollView(
          child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
              Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.080, left: MediaQuery.of(context).size.height * 0.040),
              child: Column(
                children: [
                  Text(
                ' Perfil de                     ',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF444C52),
                  fontSize: MediaQuery.of(context).size.height * 0.035,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  letterSpacing: -0.01
                )
              ),
              Text(
                ' riesgo                         ',
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
                '4/5',
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
                'Por favor indiquenos la siguiente información sobre su perfil de riesgo ',
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
              text: 'Cual es su nivel de experiencia en inversiones', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ),
            CustomDropdownWidget(
              value: _experienciaInversiones, 
              onChanged: updateExperienciaInversiones, 
              items: const [
                'Cual es su nivel de experiencia',
                'Alta',
                'Media',
                'Baja'
                ]
              ),
            CustomTextWidget(
              text: 'He invertido o poseo algún activo', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ),
            CustomDropdownWidget(
              value: _poseo, 
              onChanged: updatePoseo, 
              items: const [
                'He invertido o poseo algun activo',
                'CDT',
                'Bonos',
                'Acciones',
                'Inmueble'
              ]
              ),
            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.040, left: MediaQuery.of(context).size.height * 0.050, right: MediaQuery.of(context).size.height * 0.050 ),
              child: Text(
                'Enumere del mas importante (1) al menos importante (4) cuales de los siguientes objetivos de inversión son mas importantes para usted',
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
              text: 'Arriesgar mi capital para tener posibiliades de altas ganancias', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ),
            CustomSliderWidget(
              value: _importanciaArriesgarCapital, 
              min: 1, 
              max: 4, 
              divisions: 3, 
              onChanged: (value) {
                    setState(() {
                      _importanciaArriesgarCapital = value;
                    });
                }
              ),
            CustomTextWidget(
              text: 'Generar ingresos', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ),
            CustomSliderWidget(
              value: _importanciaGenerarIngresos, 
              min: 1, 
              max: 4, 
              divisions: 3, 
              onChanged: (value) {
                    setState(() {
                      _importanciaGenerarIngresos = value;
                    });
                }
              ),
            CustomTextWidget(
              text: 'Incrementar mi patrimonio', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ),
            CustomSliderWidget(
              value: _importanciaIncrementarPatrimonio, 
              min: 1, 
              max: 4, 
              divisions: 3, 
              onChanged: (value) {
                    setState(() {
                      _importanciaIncrementarPatrimonio = value;
                    });
                }
              ),
            CustomTextWidget(
              text: 'Proteger mi patrimonio', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ),
            CustomSliderWidget(
              value: _importanciaProtegerPatrimonio, 
              min: 1, 
              max: 4, 
              divisions: 3, 
              onChanged: (value) {
                    setState(() {
                      _importanciaProtegerPatrimonio = value;
                    });
                }
              ),
            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.040, left: MediaQuery.of(context).size.height * 0.050, right: MediaQuery.of(context).size.height * 0.050 ),
              child: Text(
                'Seleccione cual perfil considera usted que describe si actitud como inversionista',
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
              text: 'Cual perfil lo describe como inversionista', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ),
          CustomWordSliderWidget(
            value: _perfilInversionista, 
            words: const ['Especulacion', 'Conservador', 'Moderado', 'Agresivo'], 
            onChanged: (value) {
                            setState(() {
                              _perfilInversionista = value;
                            });
                          },
            ),
            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.020, left: MediaQuery.of(context).size.height * 0.050, right: MediaQuery.of(context).size.height * 0.050 ),
              child: Text(
                'Selecciones cuales es la prioridad financiera que desearia revisar con este analisis',
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
              text: 'Prioridad financiera', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ),
            CustomWordSliderWidget(
            value: _prioridadFinanciera, 
            words: const ['Como aumentar mi patrimonio', 'Como crear un Plan de ahorro para mi retiro', 'Generar Ingresos en USD', 'Como cubrir las necesidades de mi familia con un seguro de vida', 'Como invertir en bienes raices en USD', 'Filantropia'], 
            onChanged: (value) {
                            setState(() {
                              _prioridadFinanciera = value;
                            });
                          },
            ),
          Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.020, left: MediaQuery.of(context).size.height * 0.050, right: MediaQuery.of(context).size.height * 0.050 ),
              child: Text(
                'En aproximadamente cuantos años espera que iniciara retiros para sus principal necesidad financiera a cubrir',
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
              text: 'En cuantos años espera iniciar sus retiros', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ),
          CustomWordSliderWidget(
            value: _iniciarRetiros, 
            words: const ['Corto plazo (menos de 2 años)', 'Mediano plazo (2-5 años)', 'Mediano plazo (6-10 años)', 'Largo plazo (11-20 años)', 'Largo plazo (más de 20 años)'], 
            onChanged: (value) {
                            setState(() {
                              _iniciarRetiros = value;
                            });
                          },
            ),
          Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.020, left: MediaQuery.of(context).size.height * 0.050, right: MediaQuery.of(context).size.height * 0.050 ),
              child: Text(
                'Una vez que comience a retirar fondos para su necesidad financiera principal, ¿durante cuánto tiempo planea que continuarán los retiros?',
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
              text: 'Durante cuanto tiempo planea continuar los retiros', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ),
            CustomWordSliderWidget(
            value: _continuarRetiros, 
            words: const ['Corto plazo (menos de 2 años)', 'Mediano plazo (2-5 años)', 'Mediano plazo (6-10 años)', 'Largo plazo (11-20 años)', 'Largo plazo (más de 20 años)'], 
            onChanged: (value) {
                            setState(() {
                              _continuarRetiros = value;
                            });
                          },
            ),
          Center(
                    child: Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.030, bottom:MediaQuery.of(context).size.height * 0.020,),
                      child: ElevatedButton(
                        onPressed: (){
                          if (_experienciaInversiones == 'Cual es su nivel de experiencia') {
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
      savePerfilRiesgo();
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
        
        
        )
      ),
      
      )
    );
  }
}
