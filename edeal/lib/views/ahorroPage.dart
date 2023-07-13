import 'dart:async';
import 'dart:convert';
import 'package:edeal/views/ahorroPage2.dart';
import 'package:edeal/views/ahorroPage3.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:edeal/widgets/subtitulo.dart';
import 'package:edeal/widgets/seleccion.dart';
import 'package:edeal/widgets/sliderMeses.dart';
import 'package:edeal/widgets/input.dart';
import 'package:edeal/widgets/thumb.dart';

class AhorroScreen extends StatefulWidget {
  final String token;

  AhorroScreen({required this.token, Key? key}) : super(key: key);

  @override
  State<AhorroScreen> createState() => _AhorroScreenState();
}

class _AhorroScreenState extends State<AhorroScreen> {
  late String userId;
  Map<String, dynamic> userData = {};

  final _formKey = GlobalKey<FormState>();
  TextEditingController _newDataController = TextEditingController();
  TextEditingController _valorAhorroController = TextEditingController();
  TextEditingController _valorAhorroVoluntarioController = TextEditingController();
  String _ahorroPara = 'Quiero ahorrar para:';
  String _plazo= 'Plazo(meses):';
  bool _showTextField = false;

  double _ahorro = 0;
  double _ahorroVoluntario = 0;
  double _plazoAhorro = 1;

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
  var response = await http.put(
    Uri.parse('https://edeal-app.onrender.com/ahorro/$userId'),
    body: {
      'ahorroPara': _ahorroPara,
      'valorAhorro': _ahorro.toInt().toString(),
      'plazoAhorro': _plazoAhorro.toInt().toString(),
    },
  );

  if (response.statusCode == 200) {
    setState(() {
      userData['ahorroPara'] = _ahorroPara;
      userData['valorAhorro'] = _ahorro.toInt().toString();
      userData['plazoAhorro'] = _plazoAhorro.toInt().toString();
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
      _ahorroPara = 'Quiero ahorrar para:';
    });
  } else {
    print('Error al actualizar la información: ${response.statusCode}');
  }
}

  void updateSelectedOption(String? newValue) {
    setState(() {
      _ahorroPara = newValue!;
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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.075),
        child: Column(
          children: [
            Text(
                'Mi meta                        ',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF444C52),
                  fontSize: MediaQuery.of(context).size.height * 0.035,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  letterSpacing: -0.01
                )
              ),
              Text(
                ' de ahorro                      ',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF444C52),
                  fontSize: MediaQuery.of(context).size.height * 0.035,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  letterSpacing: -0.01
                )
              ),
              if(userData['ahorroPara'] == null && userData['plazoAhorro'] == null && userData['valorAhorro'] == null)
              Column(
                children: [
                   CustomTextWidget(
              text: 'Quiero ahorrar para', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ),
            CustomDropdownWidget(
              value: _ahorroPara, 
              onChanged: updateSelectedOption, 
              items: const [
                              'Quiero ahorrar para:',
                              'Viaje',
                              'Celular',
                              'Evento',
                              'Estudios',
                              'Carro',
                              'Comprar un inmueble en COL',
                              'Comprar inmueble en EEUU',
                              'Otros'
                            ]
              ),
             if(_showTextField)
             Column(
              children: [
                CustomTextWidget(
              text: 'Cual', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ),
            CustomTextField(
              controller: _newDataController, 
              keyboardType: TextInputType.text, 
              hintText: 'Ingrese el objetivo del ahorro'
              )
              ],
             ),
            CustomTextWidget(
              text: 'Valor de mi meta de ahorro', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ),
            Container(
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.035, right:MediaQuery.of(context).size.height * 0.035, bottom:MediaQuery.of(context).size.height * 0.002 ),
                         child: Column(
                           children: [
                               Text(
                              '${NumberFormat('#,###,###').format(_ahorro)}  COP',
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
                          value: _ahorro,
                          onChanged: (value) {
                         setState(() {
                          _ahorro = value;
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
             CustomTextWidget(
              text: 'Plazo de mi meta de ahorro', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ),
            SliderMeses(
                  value: _plazoAhorro, 
                  min: 1, 
                  max: 24, 
                  divisions: 24, 
                  onChanged: (value) {
                    setState(() {
                      _plazoAhorro = value;
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
            Center(
                    child: Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.030, bottom:MediaQuery.of(context).size.height * 0.020,),
                      child: ElevatedButton(
                        onPressed: (){
                          if (_ahorroPara == 'Quiero ahorrar para:') {
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
      saveUserData();
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
                              EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.25, vertical: MediaQuery.of(context).size.height * 0.005),
                          ),
                        ),
                         child: Text(
                              'Crear ahorro', 
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

              if(userData['ahorroPara'] != null && userData['plazoAhorro'] != null && userData['valorAhorro'] != null && userData['ahorro2Para'] == null && userData['plazoAhorro2'] == null && userData['valorAhorro2'] == null)
              Column(
                children: [
                  Container(
              margin: EdgeInsets.only(top: 20, left: MediaQuery.of(context).size.height * 0.050, right: MediaQuery.of(context).size.height * 0.050 ),
              child: Text(
                'Has creado una meta de ahorro correctamente',
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
              text: 'Meta de ahorro para ${userData['ahorroPara']}', 
              fontSize: MediaQuery.of(context).size.height * 0.020, 
              fontWeight: FontWeight.w500
              ),
            ElevatedButton(
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
                              EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.10, vertical: MediaQuery.of(context).size.height * 0.005),
                          ),
                        ),
                onPressed: () {
showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      title: Text('Información meta de ahorro 1'),
      content: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 150),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Valor del ahorro: ${userData['valorAhorro']}'),
              SizedBox(height: 10,),
              Text('El objetivo del ahorro es para: ${userData['ahorroPara']}'),
              SizedBox(height: 10,),
              Text('El plazo del ahorro es de: ${userData['plazoAhorro']} meses'),
              SizedBox(height: 20,),
              Text(
                'La meta de ahorro es de: \$${(double.parse(userData['valorAhorro'])/int.parse(userData['plazoAhorro']) ).toInt()}',
                style: TextStyle(fontSize: 20),
                ),
            ],
          ),
        ),
      ),
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
                },
                child: Text('Ver información'),
              ),
              Center(
                    child: Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.030, bottom:MediaQuery.of(context).size.height * 0.020,),
                      child: ElevatedButton(
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Ahorro2Screen(token: widget.token)),
                        );
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
                              EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.10, vertical: MediaQuery.of(context).size.height * 0.005),
                          ),
                        ),
                         child: Text(
                              'Crear nueva meta de  ahorro ', 
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

      if(userData['ahorroPara'] != null && userData['plazoAhorro'] != null && userData['valorAhorro'] != null && userData['ahorro2Para'] != null && userData['plazoAhorro2'] != null && userData['valorAhorro2'] != null)
              Column(
                children: [
                  Container(
              margin: EdgeInsets.only(top: 20, left: MediaQuery.of(context).size.height * 0.050, right: MediaQuery.of(context).size.height * 0.050 ),
              child: Text(
                'Has creado 2 metas de ahorro correctamente',
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
              text: 'Meta de ahorro para ${userData['ahorroPara']}', 
              fontSize: MediaQuery.of(context).size.height * 0.020, 
              fontWeight: FontWeight.w500
              ),
            ElevatedButton(
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
                              EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.10, vertical: MediaQuery.of(context).size.height * 0.005),
                          ),
                        ),
                onPressed: () {
showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      title: Text('Información meta de ahorro 1'),
      content: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 150),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Valor del ahorro: ${userData['valorAhorro']}'),
              SizedBox(height: 10,),
              Text('El objetivo del ahorro es para: ${userData['ahorroPara']}'),
              SizedBox(height: 10,),
              Text('El plazo del ahorro es de: ${userData['plazoAhorro']} meses'),
              SizedBox(height: 20,),
              Text(
                'La meta de ahorro es de: \$${(double.parse(userData['valorAhorro'])/int.parse(userData['plazoAhorro']) ).toInt()}',
                style: TextStyle(fontSize: 20),
                ),
            ],
          ),
        ),
      ),
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
                },
                child: Text('Ver información'),
              ),
              CustomTextWidget(
              text: 'Meta de ahorro para ${userData['ahorro2Para']}', 
              fontSize: MediaQuery.of(context).size.height * 0.020, 
              fontWeight: FontWeight.w500
              ),
            ElevatedButton(
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
                              EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.10, vertical: MediaQuery.of(context).size.height * 0.005),
                          ),
                        ),
                onPressed: () {
showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialog(
      title: Text('Información meta de ahorro 2'),
      content: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 150),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Valor del ahorro: ${userData['valorAhorro2']}'),
              SizedBox(height: 10,),
              Text('El objetivo del ahorro es para: ${userData['ahorro2Para']}'),
              SizedBox(height: 10,),
              Text('El plazo del ahorro es de: ${userData['plazoAhorro2']} meses'),
              SizedBox(height: 20,),
              Text(
                'La meta de ahorro es de: \$${(double.parse(userData['valorAhorro2'])/int.parse(userData['plazoAhorro2']) ).toInt()}',
                style: TextStyle(fontSize: 20),
                ),
            ],
          ),
        ),
      ),
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
                },
                child: Text('Ver información'),
              ),
              Center(
                    child: Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.030, bottom:MediaQuery.of(context).size.height * 0.020,),
                      child: ElevatedButton(
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Ahorro3Screen(token: widget.token)),
                        );
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
                              EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.10, vertical: MediaQuery.of(context).size.height * 0.005),
                          ),
                        ),
                         child: Text(
                              'Crear nueva meta de  ahorro ', 
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


              Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.020, left: MediaQuery.of(context).size.height * 0.040),
              child: Column(
                children: [
                  Text(
                ' Mi ahorro                               ',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF444C52),
                  fontSize: MediaQuery.of(context).size.height * 0.035,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  letterSpacing: -0.01
                )
              ),
              Text(
                ' voluntario                            ',
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
          CustomTextWidget(
              text: 'Quiero ahorrar mensualmente', 
              fontSize: MediaQuery.of(context).size.height * 0.016, 
              fontWeight: FontWeight.w500
              ),
          Container(
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.035, right:MediaQuery.of(context).size.height * 0.035, bottom:MediaQuery.of(context).size.height * 0.002 ),
                         child: Column(
                           children: [
                               Text(
                              '${NumberFormat('#,###,###').format(_ahorroVoluntario)}  COP',
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
                          value: _ahorroVoluntario,
                          onChanged: (value) {
                         setState(() {
                          _ahorroVoluntario = value;
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
            margin: EdgeInsets.only(bottom: 20),
            child: Center(
                    child: Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.030, bottom:MediaQuery.of(context).size.height * 0.020,),
                      child: ElevatedButton(
                        onPressed: (){
      saveUserData();
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
                              'Crear ahorro ', 
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
          )
              
            ],
          ),
        
        ),
      )
        );
  }
}











