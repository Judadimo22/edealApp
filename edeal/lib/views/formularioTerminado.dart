
import 'dart:convert';
import 'package:edeal/formularioPlanFinanciero/informacionPersonal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:google_fonts/google_fonts.dart';


class FormularioTerminado extends StatefulWidget {
  final String token;

  FormularioTerminado ({required this.token, Key? key}) : super(key: key);

  @override
  State<FormularioTerminado > createState() => _FormularioTerminadoState();
}

class _FormularioTerminadoState extends State<FormularioTerminado > {
  late String userId;
  Map<String, dynamic> userData = {};

  final _formKey = GlobalKey<FormState>();
  TextEditingController _newDataController = TextEditingController();
  TextEditingController _valorAhorroController = TextEditingController();
  TextEditingController _valorAhorroVoluntarioController = TextEditingController();
  String _ahorroPara = 'Quiero ahorrar para:';
  String _plazo= 'Plazo(meses):';
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
          _ahorroPara == 'Quiero ahorrar para:'
      ) {
        String errorMessage = '';

        if (_ahorroPara == 'Quiero ahorrar para:') {
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
            'ahorroPara': _ahorroPara == 'Otros' ? newData : _ahorroPara,
            'valorAhorro': _valorAhorroController.text,
            'plazoAhorro': _plazo,
          },
        );

        if (response.statusCode == 200) {
          setState(() {
            userData['ahorroPara'] = _ahorroPara == 'Otros' ? newData : _ahorroPara;
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
            _ahorroPara = 'Quiero ahorrar para:';
            _plazo = 'Plazo(meses):';
          });
        } else {
          print('Error al actualizar la información: ${response.statusCode}');
        }
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.090),
        child: Column(
          children: [
            Center(
              child:
              Text(
                'Formulario completado ',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF444C52),
                  fontSize: MediaQuery.of(context).size.height * 0.030,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  letterSpacing: -0.01
                )
              ),
            ),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 20, left: MediaQuery.of(context).size.height * 0.050, right: MediaQuery.of(context).size.height * 0.050 ),
              child: Text(
                'Gracias por completar el formulario de planeación financiera',
                style: GoogleFonts.inter(
                  color: const Color(0xFF817F7F),
                  fontSize: MediaQuery.of(context).size.height * 0.020,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  letterSpacing: -0.01
                )
              ),
            ),
          ),
          SizedBox(height: 400,),
          Center(
                    child: Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.030, bottom:MediaQuery.of(context).size.height * 0.020,),
                      child: ElevatedButton(
                        onPressed: (){
                          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InformacionPersonal(token: widget.token)),
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
                              EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.20, vertical: MediaQuery.of(context).size.height * 0.005),
                          ),
                        ),
                         child: Text(
                              'Editar formulario', 
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
              Center(
                    child: Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.030, bottom:MediaQuery.of(context).size.height * 0.020,),
                      child: ElevatedButton(
                        onPressed: (){
                          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InformacionPersonal(token: widget.token)),
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
                              EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.20, vertical: MediaQuery.of(context).size.height * 0.005),
                          ),
                        ),
                         child: Text(
                              'Nuevo formulario', 
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
        );
  }
}