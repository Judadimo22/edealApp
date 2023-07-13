import 'dart:async';
import 'dart:convert';
import 'package:edeal/dashboard.dart';
import 'package:edeal/views/homeScreen.dart';
import 'package:edeal/views/planeacionScreen.dart';
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
import 'package:edeal/widgets/enumeracion.dart';
import 'package:edeal/widgets/seleccionMultiple.dart';

class FuentesAdicionales extends StatefulWidget {
  final String token;

  FuentesAdicionales({required this.token, Key? key}) : super(key: key);

  @override
  State<FuentesAdicionales> createState() => _FuentesAdicionalesState();
}

class _FuentesAdicionalesState extends State<FuentesAdicionales> {
  late String userId;
  Map<String, dynamic> userData = {};

  final _formKey = GlobalKey<FormState>();

  String _habilidadEspecial = 'Habilidad para generar ingresos';
  String _desarrollarHabilidades = 'Desarrollar habilidades';
  String _trabajarMas = 'Muy viable';
  String _ahorrarMas = 'Muy viable';
  String _gastarMenos = 'muy viable';
  String _viviendaPropia = 'Tiene vivienda propia';
  String _venderiaPropiedad = 'Venderia esta propiedad';
  String _productosGustaria= 'Productos que me gustaria tener';
  String _analisisAsegurabilidad = 'Analisis de asegurabilidad';
  String _migracion = 'Migracion (estoy pensando migrar)';
  String _planHerencia = 'Plan de herencia';
  String _seguroVida = 'Seguro de vida';
  String _seguroMedico = 'Seguro medico';
  String _seguroIncapacidad = 'Seguro de incapacidad';
  String _heredarPatrimonio = 'Heredar mi patrimonio';

  TextEditingController _habilidadEspecialController = TextEditingController();
  TextEditingController _otrosProductosController = TextEditingController();

  bool _showTextFieldHabilidadEspecial = false;
  

  final List<String> options = [
    'Cuenta en USD',
    'Plan de ahorro en USD',
    'Tarjeta de credito en USD',
    'Otros',
  ];

  List<String> selectedOptions = [];
  bool showTextFieldOtros = false;


  double _opcionTrabajarMas = 1;
  double _opcionAhorrarMas = 1;
  double _opcionGastarMenos = 1;

  bool _showTextFieldOtrosProductos= false;

  TextEditingController _otrosProductoController = TextEditingController();


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



  void updateHabilidadEspecial(String? newHabilidadEspecial) {
    setState(() {
      _habilidadEspecial = newHabilidadEspecial!;
      if (newHabilidadEspecial == 'Si') {
        _showTextFieldHabilidadEspecial = true;
      } else {
        _showTextFieldHabilidadEspecial = false;
      }
    });
  }

  void updateDesarrollarHabilidades(String? newDesarrollarHabilidades) {
    setState(() {
      _desarrollarHabilidades = newDesarrollarHabilidades!;
    });
  }

  void updateTrabajarMas(String? newTrabajarMas) {
    setState(() {
      _trabajarMas = newTrabajarMas!;
    });
  }

  void updateAhorrarMas(String? newAhorrarMas) {
    setState(() {
      _ahorrarMas = newAhorrarMas!;
    });
  }

  void updateGastarMenos(String? newGastarMenos) {
    setState(() {
      _gastarMenos = newGastarMenos!;
    });
  }


  void updateViviendaPropia(String? newViviendaPropia) {
    setState(() {
      _viviendaPropia = newViviendaPropia!;
    });
  }

  void updateVenderiaPropiedad(String? newVenderiaPropiedad) {
    setState(() {
      _venderiaPropiedad = newVenderiaPropiedad!;
    });
  }


  void updateProductosGustaria(String? newProductosGustaria) {
    setState(() {
      _productosGustaria = newProductosGustaria!;
      if (newProductosGustaria == 'Cuenta en USD') {
        _showTextFieldOtrosProductos == true;
      } else {
        _showTextFieldOtrosProductos = false;
      }
    });
  }

  void updateAnalisisAsegurabilidad(String? newAnalisiAsegurabilidad) {
    setState(() {
      _analisisAsegurabilidad = newAnalisiAsegurabilidad!;
    });
  }

  void updateMigracion(String? newMigracion) {
    setState(() {
      _migracion = newMigracion!;
    });
  }

  void updatePlanHerencia(String? newPlanHerencia) {
    setState(() {
      _planHerencia = newPlanHerencia!;
    });
  }

  void updateSeguroVida(String? newSeguroVida) {
    setState(() {
      _seguroVida = newSeguroVida!;
    });
  }

  void updateSeguroMedico(String? newSeguroMedico) {
    setState(() {
      _seguroMedico = newSeguroMedico!;
    });
  }

  void updateSeguroIncapacidad(String? newSeguroIncapacidad) {
    setState(() {
      _seguroIncapacidad= newSeguroIncapacidad!;
    });
  }
  
  void updateHeredarPatrimonio(String? newHeredarPatrimonio) {
    setState(() {
      _heredarPatrimonio= newHeredarPatrimonio!;
    });
  }


  void saveFuentesAdicionales() async {

    var response = await http.put(
      Uri.parse('https://edeal-app.onrender.com/fuentesAdicionales/$userId'),
      body: {
        'trabajarMas': _opcionTrabajarMas.toInt().toString(),
        'ahorrarMas': _opcionAhorrarMas.toInt().toString(),
        'gastarMenos': _opcionGastarMenos.toInt().toString(),
        'habilidadGenerarIngresos': _habilidadEspecial,
        'desarrollarHabilidades': _desarrollarHabilidades,
        'viviendaPropia': _viviendaPropia,
        'productosGustariaTener': _productosGustaria,
        'analisisAsegurabilidad': _analisisAsegurabilidad,
        'migracion': _migracion,
        'planHerencia': _planHerencia
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        userData['trabajarMas'] = _opcionTrabajarMas.toInt().toString();
        userData['ahorrarMas'] = _opcionAhorrarMas.toInt().toString();
        userData['gastarMenos'] = _opcionGastarMenos.toInt().toString();
        userData['habilidadGenerarIngresos'] = _habilidadEspecial;
        userData['desarrollarHabilidades'] = _desarrollarHabilidades;
        userData['viviendaPropia'] = _viviendaPropia;
        userData['productosGustariaTener'] = _productosGustaria;
        userData['analisisAsegurabilidad'] = _analisisAsegurabilidad;
        userData['migracion'] = _migracion;      
        userData['planHerencia'] = _planHerencia;  
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Formulario completado'),
            content: Text('Gracias por completar el formulario de plan financiero'),
            actions: [
              TextButton(
                  onPressed: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard(token: widget.token)));
        

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
     double porcentajeAvance = 90;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.050 ),
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
                ' Fuentes adcionales ',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF444C52),
                  fontSize: MediaQuery.of(context).size.height * 0.030,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  letterSpacing: -0.01
                )
              ),
              Text(
                ' de ingreso                     ',
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
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.020, bottom: MediaQuery.of(context).size.height * 0.035 ),
              child:Text(
                '6/6',
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
                'Si sus activos actuales y sus fuentes de ingresos no alcanzan sus objetivos, exploremos algunas formas en las que podría compensar la diferencia. ',
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
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.070, left: MediaQuery.of(context).size.height * 0.050, right: MediaQuery.of(context).size.height * 0.050 ),
              child: Text(
                'Enumere en nivel de viabilidad de las siguientes posibles para aumentar ingresos.  ',
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
              text: 'Trabajar más', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ),
            CustomWordSliderWidget(
            value: _trabajarMas, 
            words: const ['Muy viable', 'Lo contemplaría', 'No muy viable'], 
            onChanged: (value) {
                            setState(() {
                              _trabajarMas = value;
                            });
                          },
            ),
            Container(
            margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.040),
            child: Row(
  children: [
    Expanded(child: Text('Muy viable')),
    Expanded(child: Text('Lo contemplaría')),
    Expanded(child: Text('   No muy viable')),
  ],
),
          ),
            CustomTextWidget(
              text: 'Ahorrar más', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ),
            CustomWordSliderWidget(
            value: _ahorrarMas, 
            words: const ['Muy viable', 'Lo contemplaría', 'No muy viable'], 
            onChanged: (value) {
                            setState(() {
                              _ahorrarMas = value;
                            });
                          },
            ),
            Container(
            margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.040),
            child: Row(
  children: [
    Expanded(child: Text('Muy viable')),
    Expanded(child: Text('Lo contemplaría')),
    Expanded(child: Text('   No muy viable')),
  ],
),
          ),
            CustomTextWidget(
              text: 'Gastar menos', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ),
            CustomWordSliderWidget(
            value: _trabajarMas, 
            words: const ['Muy viable', 'Lo contemplaría', 'No muy viable'], 
            onChanged: (value) {
                            setState(() {
                              _trabajarMas = value;
                            });
                          },
            ),
            Container(
            margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.040),
            child: Row(
  children: [
    Expanded(child: Text('Muy viable')),
    Expanded(child: Text('Lo contemplaría')),
    Expanded(child: Text('   No muy viable')),
  ],
),
          ),
            CustomTextWidget(
              text: 'Creo que tengo una habilidad especial que puediera permitirme generar ingresos ', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ),
            CustomDropdownWidget(
              value: _habilidadEspecial, 
              onChanged: updateHabilidadEspecial, 
              items: const [
                'Habilidad para generar ingresos',
                'Si',
                'No'
                ]
              ),
            if(_showTextFieldHabilidadEspecial)
            Column(
              children: [
                CustomTextWidget(
              text: 'Cual habilidad especial tengo ? ', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ),
              CustomTextField(
                controller: _habilidadEspecialController, 
                keyboardType: TextInputType.text, 
                hintText: 'Cual habilidad especial'
                )
              ],
            ),
            CustomTextWidget(
              text: 'Quisiera desarrollar nuevas habilidades que me permitieran para generar ingresos  ', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ),
            CustomDropdownWidget(
              value: _desarrollarHabilidades, 
              onChanged: updateDesarrollarHabilidades, 
              items: const [
                'Desarrollar habilidades',
                'Si',
                'No'
                ]
              ),
            CustomTextWidget(
              text: 'Posee vivienda propia  ', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ),
            CustomDropdownWidget(
              value: _viviendaPropia, 
              onChanged: updateViviendaPropia, 
              items: const [
                'Tiene vivienda propia',
                'Si',
                'No'
                ]
              ),
            CustomTextWidget(
              text: 'Venderia esta propiedad para cubrir sus necesidades financieras futuras ', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ),
            CustomDropdownWidget(
              value: _venderiaPropiedad, 
              onChanged: updateVenderiaPropiedad, 
              items: const [
                'Venderia esta propiedad',
                'Si',
                'No'
                ]
              ),
            Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.040 ),
                    child: Column(
                children: [
                  Text(
                'Consideraciones        ',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF444C52),
                  fontSize: MediaQuery.of(context).size.height * 0.035,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  letterSpacing: -0.01
                )
              ),
              Text(
                'especiales                     ',
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
              CustomTextWidget(
              text: 'Productos financieros que me gustaría tener', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ),
              MultiSelectWidget(
                options: options, 
                selectedOptions: selectedOptions, 
                onChanged: (selected){
                  setState(() {
                    selectedOptions = selected;
                    showTextFieldOtros = selected.contains('Otros');
                  });
                }
                ),
              if(showTextFieldOtros)
              Column(
                children: [
                  CustomTextWidget(
              text: 'Cuál otro producto te gustaría ?', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ),
                  CustomTextField(
                controller: _otrosProductosController, 
                keyboardType: TextInputType.text, 
                hintText: 'Cual otro producto'),
                ],
              ),
            Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.040 ),
                    child: Column(
                children: [
                  Text(
                'Análisis de                     ',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF444C52),
                  fontSize: MediaQuery.of(context).size.height * 0.035,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  letterSpacing: -0.01
                )
              ),
              Text(
                'asegurabilidad           ',
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
              CustomTextWidget(
              text: 'Seguro de vida', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ),
              CustomDropdownWidget(
                value: _seguroVida, 
                onChanged: updateSeguroVida, 
                items: const [
                  'Seguro de vida',
                  'Si me gustaría',
                  'No me gustaría'
                ]
                ),
              CustomTextWidget(
              text: 'Seguro médico', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ),
              CustomDropdownWidget(
                value: _seguroMedico, 
                onChanged: updateSeguroMedico, 
                items: const [
                  'Seguro medico',
                  'Si me gustaría',
                  'No me gustaría'
                ]
                ),
              CustomTextWidget(
              text: 'Seguro de incapacidad', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ),
              CustomDropdownWidget(
                value: _seguroIncapacidad, 
                onChanged: updateSeguroIncapacidad, 
                items: const [
                  'Seguro de incapacidad',
                  'Si me gustaría',
                  'No me gustaría'
                ]
                ),
            Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.040 ),
                    child: Column(
                children: [
                  Text(
                'Plan de                             ',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF444C52),
                  fontSize: MediaQuery.of(context).size.height * 0.035,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  letterSpacing: -0.01
                )
              ),
              Text(
                'herencia                          ',
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
              CustomTextWidget(
              text: 'Alternativas para heredar mi patrimonio', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ),
              CustomDropdownWidget(
                value: _heredarPatrimonio, 
                onChanged: updateHeredarPatrimonio, 
                items: const [
                  'Heredar mi patrimonio',
                  'Si me gustaría',
                  'No me gustaría'
                ]
                ),
            Center(
                    child: Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.030, bottom:MediaQuery.of(context).size.height * 0.020,),
                      child: ElevatedButton(
                        onPressed: (){
                          if (_habilidadEspecial == 'Habilidad para generar ingresos') {
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
      saveFuentesAdicionales();
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