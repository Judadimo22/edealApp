import 'dart:async';
import 'dart:convert';
import 'package:edeal/views/ahorroPage2.dart';
import 'package:edeal/views/ahorroPage3.dart';
import 'package:edeal/views/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:edeal/widgets/barraSeleccion.dart';
import 'package:edeal/widgets/sliderPalabras.dart';
import 'package:edeal/widgets/subtitulo.dart';
import 'package:edeal/widgets/seleccion.dart';
import 'package:edeal/widgets/sliderMeses.dart';
import 'package:edeal/widgets/input.dart';
import 'package:edeal/widgets/grafico.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:edeal/widgets/sliderUsd.dart';
import 'dart:math';


class FincaRaizScreen extends StatefulWidget {
  final String token;

  const FincaRaizScreen({required this.token, Key? key}) : super(key: key);

  @override
  State<FincaRaizScreen> createState() => FincaRaizScreenState();
}

class FincaRaizScreenState extends State<FincaRaizScreen> {
  late String userId;
  Map<String, dynamic> userData = {};

  bool animate = true;

  List<charts.Series<SalesData, String>> seriesList = [];

  final _formKey = GlobalKey<FormState>();
  TextEditingController _newDataController = TextEditingController();
  TextEditingController _valorAhorroController = TextEditingController();
  TextEditingController _valorAhorroVoluntarioController = TextEditingController();

  String _propiedadIdentificada = 'Propiedad identificada';
  String _plazo= 'Plazo(meses):';
  String _ubicacionPropiedad = 'Ubicacion';
  String _tipoPropiedad = 'Tipo de propiedad';
  String _financiamientoDolares = 'Financiamiento en dolares';

  double _precioPropiedad = 100000;
  double _montoInvertir = 1000;
  



  bool _showTextField = false;

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
      if (_valorAhorroController.text.isEmpty ||
          _plazo == 'Plazo(meses):' ||
          _propiedadIdentificada == 'Quiero ahorrar para:'
      ) {
        String errorMessage = '';

        if (_propiedadIdentificada == 'Quiero ahorrar para:') {
          errorMessage = 'Por favor, selecciona una opción en Quiero ahorrar para';
        } else if (_valorAhorroController.text.isEmpty) {
          errorMessage = 'Por favor, ingresa el monto del ahorro';
        } else if (_plazo == 'Plazo(meses):') {
          errorMessage = 'Por favor, selecciona una opción en Plazo';
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
          Uri.parse('https://edeal-app.onrender.com/ahorro/$userId'),
          body: {
            'ahorroPara': _propiedadIdentificada == 'Otros' ? newData : _propiedadIdentificada,
            'valorAhorro': _valorAhorroController.text,
            'plazoAhorro': _plazo,
          },
        );

        if (response.statusCode == 200) {
          setState(() {
            userData['ahorroPara'] = _propiedadIdentificada == 'Otros' ? newData : _propiedadIdentificada;
            userData['valorAhorro'] = _valorAhorroController.text;
            userData['plazoAhorro'] = _plazo;
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

          setState(() {
            _propiedadIdentificada = 'Proppiedad identificada';
            _plazo = 'Plazo(meses):';
          });
        } else {
          print('Error al actualizar la información: ${response.statusCode}');
        }
      }
    }
  }

  void updateSelectedOption(String? newValue) {
    setState(() {
      _propiedadIdentificada = newValue!;
      if (newValue == 'Otros') {
        _showTextField = true;
      } else {
        _showTextField = false;
      }
    });
  }

  void updatePlazoOption(String? newValue) {
    if (newValue != null && newValue != 'Plazo(meses):') {
      setState(() {
        _plazo = newValue;
      });
    }
  }

  void updateTipoPropiedad(String? newTipoPropiedad) {
    if (newTipoPropiedad != null && newTipoPropiedad != 'Tipo propiedad') {
      setState(() {
        _tipoPropiedad = newTipoPropiedad;
      });
    }
  }

  void updateUbicacionPropiedad(String? newUbicacionPropiedad) {
    if (newUbicacionPropiedad != null && newUbicacionPropiedad != 'Ubicacion') {
      setState(() {
        _ubicacionPropiedad = newUbicacionPropiedad;
      });
    }
  }

  void updateFinanciamientoDolares(String? newFinanciamientoDolares) {
    if (newFinanciamientoDolares != null && newFinanciamientoDolares != 'Financiamiento en dolares') {
      setState(() {
        _financiamientoDolares = newFinanciamientoDolares;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    double _montoAno1 = ((_montoInvertir*0.06) + (_montoInvertir));
    double _montoAno2 = ((_montoAno1) + (_montoInvertir*0.06));
    double _valorVenta = _montoInvertir * pow(1 + 0.06, 3);
    double _ingresoVenta = ((_valorVenta) - (_montoInvertir));
    double _montoAno3 = ((_montoAno2) + (_montoAno2*0.06) + (_ingresoVenta) );

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.075, bottom:MediaQuery.of(context).size.height * 0.075 ),
        child: Column(
          children: [
            Text(
                'Inmobiliario                  ',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF444C52),
                  fontSize: MediaQuery.of(context).size.height * 0.035,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  letterSpacing: -0.01
                )
              ),
            Container(
              margin: EdgeInsets.only(top: 20, left: MediaQuery.of(context).size.height * 0.050, right: MediaQuery.of(context).size.height * 0.050 ),
              child: Text(
                'Quiero comprar una propiedad en Estados Unidos',
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
              text: 'Tiene identificada la propiedad que desea comprar en EEUU', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ),
            CustomDropdownWidget(
              value: _propiedadIdentificada, 
              onChanged: updateSelectedOption, 
              items: const [
                              'Propiedad identificada',
                              'Si',
                              'No',
                            ]
              ),
            CustomTextWidget(
              text: 'Que tipo de propiedad desea adquirir', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ),
            CustomDropdownWidget(
              value: _tipoPropiedad, 
              onChanged: updateTipoPropiedad, 
              items: const [
                              'Tipo de propiedad',
                              'Casa',
                              'Apartamento',
                              'Local comercial'
                            ]
              ),

             CustomTextWidget(
              text: 'Ubicacion', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ),
             CustomDropdownWidget(
              value: _ubicacionPropiedad, 
              onChanged: updateUbicacionPropiedad, 
              items: const [
                              'Ubicacion',
                              'Alabama', 'Alaska', 'Arizona', 'Arkansas', 'California', 'Carolina del Norte', 'Carolina del Sur',
                              'Colorado', 'Connecticut', 'Dakota del Norte', 'Dakota del Sur', 'Delaware', 'Florida', 'Georgia', 'Hawai', 'Idaho', 'Illinois', 'Inidiana', 'Iowa', 'Kansas', 'Kentucky', 'Luisiana', ''
                            ]
              ),
            CustomTextWidget(
              text: 'Precio estimado de la propiedad', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ),
            SliderUsd(
              value: _precioPropiedad, 
              min: 100000, 
              max: 10000000, 
              divisions: 20, 
              onChanged: (value) {
                            setState(() {
                              _precioPropiedad = value;
                            });
                          },
              ),
            CustomTextWidget(
              text: 'Estaria interesado en financiamiento en Dolares para adquirir la propiedad', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ),
            CustomDropdownWidget(
              value: _financiamientoDolares, 
              onChanged: updateFinanciamientoDolares, 
              items: const [
                              'Financiamiento en dolares',
                              'Si',
                              'No',
                            ]
              ),
            Center(
                    child: Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.030, bottom:MediaQuery.of(context).size.height * 0.020,),
                      child: ElevatedButton(
                        onPressed: (){
                          if (_propiedadIdentificada== 'Propiedad identificada') {
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
      saveUserData;
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
                              EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.13, vertical: MediaQuery.of(context).size.height * 0.005),
                          ),
                        ),
                         child: Text(
                              'Solicitar información', 
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
          Container(
              margin: EdgeInsets.only(top: 20, left: MediaQuery.of(context).size.height * 0.050, right: MediaQuery.of(context).size.height * 0.050 ),
              child: Text(
                'Quiero invertir en el sector inmobiliario de Estados Unidos ',
                style: GoogleFonts.inter(
                  color: Colors.black,
                  fontSize: MediaQuery.of(context).size.height * 0.020,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  letterSpacing: -0.01
                )
              ),
            ),
          Container(
              margin: EdgeInsets.only(top: 20, left: MediaQuery.of(context).size.height * 0.050, right: MediaQuery.of(context).size.height * 0.050 ),
              child: Text(
                'Inversión en Condominies y  Proyectos Multifamiliares en Estados Unidos que generan un ingreso a los propietarios por los alquileres de las unidades  y un ingreso adicional por la valorización de la propiedad en el momento de su venta',
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
              text: 'Seleccione el monto a invertir', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ), 
          SliderUsd(
              value: _montoInvertir, 
              min: 1000, 
              max: 1000000, 
              divisions: 10, 
              onChanged: (value) {
                            setState(() {
                              _montoInvertir = value;
                            });
                          },
              ),
          Center(
                    child: Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.010, bottom:MediaQuery.of(context).size.height * 0.020,),
                      child: ElevatedButton(
                        onPressed: (){
                          if (_propiedadIdentificada== 'Propiedad identificada') {
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
      saveUserData;
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
                              EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.13, vertical: MediaQuery.of(context).size.height * 0.005),
                          ),
                        ),
                         child: Text(
                              'Solicitar información', 
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
                Container(
              height: 400, 
              padding: EdgeInsets.all(16),
              child: BarChartWidget(getChartData(_montoInvertir), animate: animate, montoInvertir: _montoInvertir,),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.010),
              child: Table(
  children: [
    TableRow(
      children: [
        TableCell(
          child: Container(
            padding: EdgeInsets.all(8),
            color: Color(0xFF0C67B0),
            child: Text(
                              '.', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.013,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01,
                                color: Color(0xFF0C67B0)
                              ),                   
                            ),
          ),
        ),
        TableCell(
          child: Container(
            padding: EdgeInsets.all(8),
            color: Color(0xFF0C67B0),
            child: Text(
                              'Inicial', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.013,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01,
                                color: Colors.white
                              ),                   
                            ),
          ),
        ),
        TableCell(
          child: Container(
            padding: EdgeInsets.all(8),
            color: Color(0xFF0C67B0),
            child: Text(
                              'Año 1 USD', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.013,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01,
                                color: Colors.white
                              ),                   
                            ),
          ),
        ),
        TableCell(
          child: Container(
            padding: EdgeInsets.all(8),
            color: Color(0xFF0C67B0),
            child: Text(
                              'Año 2 USD', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.013,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01,
                                color: Colors.white
                              ),                   
                            ),
          ),
        ),
        TableCell(
          child: Container(
            padding: EdgeInsets.all(8),
            color: Color(0xFF0C67B0),
            child: Text(
                              'Año 3 USD', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.013,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01,
                                color: Colors.white
                              ),                   
                            ),
          ),
        ),
      ],
    ),
    TableRow(
      children: [
        TableCell(
          child: Container(
            padding: EdgeInsets.all(8),
            color: Color(0xFF0C67B0),
            child: Text(
                              'Balance', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.013,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01,
                                color: Colors.white
                              ),                   
                            ),
          ),
        ),
        TableCell(
          child: Container(
            padding: EdgeInsets.all(8),
            color: Color(0xFF0C67B0),
            child:Text(
                              '${_montoInvertir.toInt()}', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.013,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01,
                                color: Colors.white
                              ),                   
                            ),
          ),
        ),
        TableCell(
          child: Container(
            padding: EdgeInsets.all(8),
            color: Color(0xFF0C67B0),
            child: Text(
                              '${_montoAno1.toInt()}', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.013,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01,
                                color: Colors.white
                              ),                   
                            ),
          ),
        ),
        TableCell(
          child: Container(
            padding: EdgeInsets.all(8),
            color: Color(0xFF0C67B0),
            child: Text(
                              '${_montoAno2.toInt()}', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.013,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01,
                                color: Colors.white
                              ),                   
                            ),
          ),
        ),
        TableCell(
          child: Container(
            padding: EdgeInsets.all(8),
            color: Color(0xFF0C67B0),
            child: Text(
                              '${_montoAno3.toInt()}', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.013,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01,
                                color: Colors.white
                              ),                   
                            ),
          ),
        ),
      ],
    ),
    TableRow(
      children: [
        TableCell(
          child: Container(
            padding: EdgeInsets.all(8),
            color: Color(0xFF0C67B0),
            child: Text(
                              'Ingreso', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.013,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01,
                                color: Colors.white
                              ),                   
                            ),
          ),
        ),
        TableCell(
          child: Container(
            padding: EdgeInsets.all(8),
            color: Color(0xFF0C67B0),
            child: Text(
                              '.', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.013,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01,
                                color: Color(0xFF0C67B0),
                              ),                   
                            ),
          ),
        ),
        TableCell(
          child: Container(
            padding: EdgeInsets.all(8),
            color: Color(0xFF0C67B0),
            child: Text(
                              '${(_montoInvertir*0.06).toInt()}', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.013,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01,
                                color: Colors.white,
                              ),                   
                            ),
          ),
        ),
        TableCell(
          child: Container(
            padding: EdgeInsets.all(8),
            color: Color(0xFF0C67B0),
            child: Text(
                              '${(_montoAno1*0.06).toInt()}', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.013,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01,
                                color: Colors.white,
                              ),                   
                            ),
          ),
        ),
        TableCell(
          child: Container(
            padding: EdgeInsets.all(8),
            color: Color(0xFF0C67B0),
            child: Text(
                              '${(_montoAno2*0.06).toInt()}', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.013,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01,
                                color: Colors.white,
                              ),                   
                            ),
          ),
        ),
      ],
    ),
    TableRow(
      children: [
        TableCell(
          child: Container(
            padding: EdgeInsets.all(8),
            color: Color(0xFF0C67B0),
            child: Text(
                              'Venta', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.013,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01,
                                color: Colors.white,
                              ),                   
                            ),
          ),
        ),
        TableCell(
          child: Container(
            padding: EdgeInsets.all(8),
            color: Color(0xFF0C67B0),
            child: Text(
                              '.', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.013,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01,
                                color: Color(0xFF0C67B0),
                              ),                   
                            ),
          ),
        ),
        TableCell(
          child: Container(
            padding: EdgeInsets.all(8),
            color: Color(0xFF0C67B0),
            child: Text(
                              '.', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.013,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01,
                                color: Color(0xFF0C67B0),
                              ),                   
                            ),
          ),
        ),
        TableCell(
          child: Container(
            padding: EdgeInsets.all(8),
            color: Color(0xFF0C67B0),
            child: Text(
                              '.', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.013,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01,
                                color: Color(0xFF0C67B0),
                              ),                   
                            ),
          ),
        ),
        TableCell(
          child: Container(
            padding: EdgeInsets.all(8),
            color: Color(0xFF0C67B0),
            child: Text(
                              '${_valorVenta.toInt()}', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.013,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01,
                                color: Colors.white,
                              ),                   
                            ),
          ),
        ),
      ],
    ),
  ],
)
            ),


            Container(
              margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.010, vertical: MediaQuery.of(context).size.height * 0.020),
              child: Table(
  children: [
    TableRow(
      children: [
        TableCell(
          child: Container(
            padding: EdgeInsets.all(8),
            color: Color(0xFF0C67B0),
            child: Text(
                              'Valor final', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.013,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01,
                                color: Colors.white
                              ),                   
                            ),
          ),
        ),
        TableCell(
          child: Container(
            padding: EdgeInsets.all(8),
            color: Color(0xFF0C67B0),
            child: Text(
                              '${_montoAno3.toInt()} USD', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.013,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01,
                                color: Colors.white
                              ),                   
                            ),
          ),
        ),
        
      ],
    ),
    TableRow(
      children: [
        TableCell(
          child: Container(
            padding: EdgeInsets.all(8),
            color: Color(0xFF0C67B0),
            child: Text(
                              'Ganancia', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.013,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01,
                                color: Colors.white
                              ),                   
                            ),
          ),
        ),
        TableCell(
          child: Container(
            padding: EdgeInsets.all(8),
            color: Color(0xFF0C67B0),
            child: Text(
                              '${((_montoAno3) - (_montoInvertir)).toInt()} USD', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.013,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01,
                                color: Colors.white,
                              ),                   
                            ),
          ),
        ),
      
      ],
    ),
  
  ],
)
            ),

      Container(
              margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.010,),
              child: Table(
  children: [
    TableRow(
      children: [
        TableCell(
          child: Container(
            padding: EdgeInsets.all(8),
            color: Color(0xFF0C67B0),
            child: Text(
                              'Rentabilidad neta', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.013,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01,
                                color: Colors.white
                              ),                   
                            ),
          ),
        ),
        TableCell(
          child: Container(
            padding: EdgeInsets.all(8),
            color: Color(0xFF0C67B0),
            child: Text(
                              '${(((_montoAno3 - _montoInvertir) / _montoInvertir) * 100).toStringAsFixed(2)}%', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.013,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01,
                                color: Colors.white
                              ),                   
                            ),
          ),
        ),
        
      ],
    ),
    TableRow(
      children: [
        TableCell(
          child: Container(
            padding: EdgeInsets.all(8),
            color: Color(0xFF0C67B0),
            child: Text(
                              'Rentabilidad promedio anual', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.013,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01,
                                color: Colors.white
                              ),                   
                            ),
          ),
        ),
        TableCell(
          child: Container(
            padding: EdgeInsets.all(8),
            color: Color(0xFF0C67B0),
            child: Text(
                              '${((((_montoAno3 - _montoInvertir) / _montoInvertir)) / 4 * 100).toStringAsFixed(2)}%', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.013,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01,
                                color: Colors.white,
                              ),                   
                            ),
          ),
        ),
      
      ],
    ),
  
  ],
)
            )
            ],
          ),
        
        ),
      )
        );
  }
}