import 'dart:async';
import 'dart:convert';
import 'package:edeal/formularioPlanFinanciero/definirObjetivos.dart';
import 'package:edeal/views/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:velocity_x/velocity_x.dart';

class MetasFinancieras extends StatefulWidget {
  final String token;

  MetasFinancieras({required this.token, Key? key}) : super(key: key);

  @override
  State<MetasFinancieras> createState() => _MetasFinancierasState();
}

class _MetasFinancierasState extends State<MetasFinancieras> {
  late String userId;
  Map<String, dynamic> userData = {};

  final _formKey = GlobalKey<FormState>();
  TextEditingController _plazoVacacionesViajesController = TextEditingController();
  TextEditingController _valorVacacionesViajesController = TextEditingController();
  TextEditingController _importanciaVacacionesViajesController = TextEditingController();
  TextEditingController _plazoAutomovilController = TextEditingController();
  TextEditingController _valorAutomovilController = TextEditingController();
  TextEditingController _importanciaAutomovilController = TextEditingController();
  TextEditingController _plazoEducacionController = TextEditingController();
  TextEditingController _valorEducacionController = TextEditingController();
  TextEditingController _importanciaEducacionController = TextEditingController();
  TextEditingController _plazoInmuebleColombiaController = TextEditingController();
  TextEditingController _valorInmuebleColombiaController = TextEditingController();
  TextEditingController _importanciaInmuebleColombiaController = TextEditingController();
  TextEditingController _plazoInmuebleUsaController = TextEditingController();
  TextEditingController _valorInmuebleUsaController = TextEditingController();
  TextEditingController _importanciaInmuebleUsaController = TextEditingController();
  TextEditingController _plazoTratamientosMedicosController = TextEditingController();
  TextEditingController _valorTratamientosMedicosController = TextEditingController();
  TextEditingController _importanciaTratamientosMedicosController = TextEditingController();
  TextEditingController _plazoTecnologiaController = TextEditingController();
  TextEditingController _valorTecnologiaController = TextEditingController();
  TextEditingController _importanciaTecnologiaController = TextEditingController();
  TextEditingController _plazoEntretenimientoController = TextEditingController();
  TextEditingController _valorEntretenimientoController = TextEditingController();
  TextEditingController _importanciaEntretenimientoController = TextEditingController();
  TextEditingController _plazoEventosDeportivosController = TextEditingController();
  TextEditingController _valorEventosDeportivosController = TextEditingController();
  TextEditingController _importanciaEventosDeportivosController = TextEditingController();
  TextEditingController _plazoOtrosController = TextEditingController();
  TextEditingController _valorOtrosController = TextEditingController();
  TextEditingController _importanciaOtrosController = TextEditingController();

  String _vacionesViajes = 'Vacaciones/viajes';
  String _automovil = 'Automovil';
  String _educacion = 'Educacion';
  String _inmuebleColombia = 'Inmueble en Colombia';
  String _inmuebleUsa = 'Inmueble en USA';
  String _tratamientosMedicos = 'Tratamientos medicos y esteticos';
  String _tecnologia = 'Tecnologia';
  String _entretenimiento = 'Entretenimiento - conciertos y festivales';
  String _eventosDeportivos = 'Eventos deportivos internacionales';
  String _otros = 'Otros';


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

// void saveUserData() async {
//   if (_formKey.currentState!.validate()) {
//     var vacacionesViajes = _vacacionesViajesController.text;

//     var response = await http.put(
//       Uri.parse('http://192.168.1.108:3001/ahorro/$userId'),
//       body: {
//         'ahorroPara': _ahorroPara == 'Otros' ? newData : _ahorroPara,
//         'valorAhorro': _valorAhorroController.text,
//         'plazoAhorro': _plazo,
//       },
//     );

//     if (response.statusCode == 200) {
//       setState(() {
//         userData['ahorroPara'] = _ahorroPara == 'Otros' ? newData : _ahorroPara;
//         userData['valorAhorro'] = _valorAhorroController.text;
//         userData['plazoAhorro'] = _plazo;
//       });

//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Información actualizada'),
//             content: Text('Tu información se almacenó correctamente.'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('Aceptar'),
//               ),
//             ],
//           );
//         },
//       );

//       setState(() {
//         _ahorroPara = 'Quiero ahorrar para:';
//         // _valorAhorroController = '';
//         _plazo = 'Plazo(meses):';
//       });
//     } else {
//       print('Error al actualizar la información: ${response.statusCode}');
//     }
//   }
// }


  void updateVacacionesViajes(String? newVacacionesViajes) {
    setState(() {
      _vacionesViajes = newVacacionesViajes!;
      if (newVacacionesViajes == 'Vacaciones/viajes: Si') {
        _showTextFieldVacacionesViajes = true;
      } else {
        _showTextFieldVacacionesViajes = false;
      }
    });
  }

  void updateAutomovil(String? newAutomovil) {
    setState(() {
      _automovil = newAutomovil!;
      if (newAutomovil == 'Automovil: Si') {
        _showTextFieldAutomovil = true;
      } else {
        _showTextFieldAutomovil = false;
      }
    });
  }

  void updateEducacion(String? newEducacion) {
    setState(() {
      _educacion = newEducacion!;
      if (newEducacion == 'Educacion: Si') {
        _showTextFieldEducacion = true;
      } else {
        _showTextFieldEducacion = false;
      }
    });
  }

  void updateInmuebleColombia(String? newInmuebleColombia) {
    setState(() {
      _inmuebleColombia = newInmuebleColombia!;
      if (newInmuebleColombia == 'Inmueble en Colombia: Si') {
        _showTextFieldInmuebleColombia = true;
      } else {
        _showTextFieldInmuebleColombia = false;
      }
    });
  }

  void updateInmuebleUsa(String? newInmuebleUsa) {
    setState(() {
      _inmuebleUsa = newInmuebleUsa!;
      if (newInmuebleUsa == 'Inmueble en USA: Si') {
        _showTextFieldInmuebleUsa = true;
      } else {
        _showTextFieldInmuebleUsa = false;
      }
    });
  }

  void updateTratamientosMedicos(String? newTratamientosMedicos) {
    setState(() {
      _tratamientosMedicos = newTratamientosMedicos!;
      if (newTratamientosMedicos == 'Tratamientos medicos y esteticos: Si') {
        _showTextFieldTratamientosMedicos = true;
      } else {
        _showTextFieldTratamientosMedicos = false;
      }
    });
  }

  void updateTecnologia(String? newTecnologia) {
    setState(() {
      _tecnologia = newTecnologia!;
      if (newTecnologia == 'Tecnologia: Si') {
        _showTextFieldTecnologia = true;
      } else {
        _showTextFieldTecnologia = false;
      }
    });
  }

  void updateEntretenimiento(String? newEntretenimiento) {
    setState(() {
      _entretenimiento = newEntretenimiento!;
      if (newEntretenimiento == 'Entretenimiento - conciertos y festivales: Si') {
        _showTextFieldEntretenimiento = true;
      } else {
        _showTextFieldEntretenimiento = false;
      }
    });
  }

  void updateEventosDeportivos(String? newEventosDeportivos) {
    setState(() {
      _eventosDeportivos = newEventosDeportivos!;
      if (newEventosDeportivos == 'Eventos deportivos internacionales: Si') {
        _showTextFieldEventosDeportivos = true;
      } else {
        _showTextFieldEventosDeportivos = false;
      }
    });
  }

  void updateOtros(String? newOtros) {
    setState(() {
      _otros = newOtros!;
      if (newOtros == 'Otros: Si') {
        _showTextFieldOtros = true;
      } else {
        _showTextFieldOtros = false;
      }
    });
  }

  void saveMetasFinancieras() async {
    // var newData = _newDataController.text;

    var response = await http.put(
      Uri.parse('https://edeal-app.onrender.com/metasFinancieras/$userId'),
      body: {
        'plazoVacaciones': _plazoVacacionesViajesController.text,
        'valorVacaciones': _valorVacacionesViajesController.text,
        'importanciaVacaciones': _importanciaVacacionesViajesController.text,
        'plazoAutomovil': _plazoAutomovilController.text,
        'valorAutomovil': _valorAutomovilController.text,
        'importanciaAutomovil': _importanciaAutomovilController.text,
        'plazoEducacion': _plazoEducacionController.text,
        'valorEducacion': _valorEducacionController.text,
        'importanciaEducacion': _importanciaEducacionController.text,
        'plazoInmuebleColombia': _plazoInmuebleColombiaController.text,
        'valorInmuebleColombia': _valorInmuebleColombiaController.text,
        'importanciaInmuebleColombia': _importanciaInmuebleColombiaController.text,
        'plazoInmuebleUsa': _plazoInmuebleUsaController.text,
        'valorInmuebleUsa': _valorInmuebleUsaController.text,
        'importanciaInmuebleUsa': _importanciaInmuebleUsaController.text,
        'plazoTratamientosMedicos': _plazoTratamientosMedicosController.text,
        'valorTratamientosMedicos': _valorTratamientosMedicosController.text,
        'importanciaTratamientosMedicos': _importanciaTratamientosMedicosController.text,
        'plazoTecnologia': _plazoTecnologiaController.text,
        'valorTecnologia': _valorTecnologiaController.text,
        'importanciaTecnologia': _importanciaTecnologiaController.text,
        'plazoEntretenimiento': _plazoEntretenimientoController.text,
        'valorEntretenimiento': _valorEntretenimientoController.text,
        'importanciaEntretenimiento': _importanciaEntretenimientoController.text,
        'plazoEventosDeportivos': _plazoEventosDeportivosController.text,
        'valorEventosDeportivos': _valorEventosDeportivosController.text,
        'importanciaEventosDeportivos': _importanciaEventosDeportivosController.text,
        'plazoOtros': _plazoOtrosController.text,
        'valorOtros': _valorOtrosController.text,
        'importanciaOtros': _importanciaOtrosController.text
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        userData['plazoVacaciones'] = _plazoVacacionesViajesController.text;
        userData['valorVacaciones'] = _valorVacacionesViajesController.text;
        userData['importanciaVacaciones'] = _importanciaVacacionesViajesController.text;
        userData['plazoAutomovil'] = _plazoAutomovilController.text;
        userData['valorAutomovil'] = _valorAutomovilController.text;
        userData['importanciaAutomovil'] = _importanciaAutomovilController.text;
        userData['plazoEducacion'] = _plazoEducacionController.text;
        userData['valorEducacion'] = _valorEducacionController.text;
        userData['importanciaEducacion'] = _importanciaEducacionController.text;
        userData['plazoInmuebleColombia'] = _plazoInmuebleColombiaController.text;
        userData['valorInmuebleColombia'] = _valorInmuebleColombiaController.text;
        userData['importanciaInmuebleColombia'] = _importanciaInmuebleColombiaController.text;
        userData['plazoInmuebleUsa'] = _plazoInmuebleUsaController.text;
        userData['valorInmuebleUsa'] = _valorInmuebleUsaController.text;
        userData['importanciaInmuebleUsa'] = _importanciaInmuebleUsaController.text;
        userData['plazoTratamientosMedicos'] = _plazoTratamientosMedicosController.text;
        userData['valorTratamientosMedicos'] = _valorTratamientosMedicosController.text;
        userData['importanciaTratamientosMedicos'] = _importanciaTratamientosMedicosController.text;
        userData['plazoTecnologia'] = _plazoTecnologiaController.text;
        userData['valorTecnologia'] = _valorTecnologiaController.text;
        userData['importanciaTecnologia'] = _importanciaTecnologiaController.text;
        userData['plazoEntretenimiento'] = _plazoEntretenimientoController.text;
        userData['valorEntretenimiento'] = _valorEntretenimientoController.text;
        userData['importanciaEntretenimiento'] = _importanciaEntretenimientoController.text;
        userData['plazoEventosDeportivos'] = _plazoEventosDeportivosController.text;
        userData['valorEventosDeportivos'] = _valorEventosDeportivosController.text;
        userData['importanciaEventosDeportivos'] = _importanciaEventosDeportivosController.text;
        userData['plazoOtros'] = _plazoOtrosController.text;
        userData['valorOtros'] = _valorOtrosController.text;
        userData['importanciaOtros'] = _importanciaOtrosController.text;
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
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>DefinirObjetivo(token: widget.token)));
                  },
                child: Text('Aceptar'),
              ),
            ],
          );
        },
      );

      // setState(() {
      //   _ahorroPara = 'Quiero ahorrar para:';
      //   // _valorAhorroController = '';
      //   _plazo = 'Plazo(meses):';
      // });
}
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0XFF524898) ,
      ),
      backgroundColor: Color(0XFF524898),
      body:SingleChildScrollView(
        child:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  color: Color(0XFF524898),
                  padding: EdgeInsets.symmetric(vertical: 50),
                  child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 50),
                      child: Text(
                        'Mis metas financieras',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 50, left: 20, right: 20),
                      child: Text(
                        'Además de los objetivos principales, como su retiro, educación y la atención médica, es posible que tenga otros objetivos que desee incluir.  Utilice esta sección para enumerar estas otras necesidades, deseos futuros ',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 374,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      color: Color(0XFF524898),
                      child: DropdownButton<String>(
                        dropdownColor: Color(0XFF524898),
                        value: _vacionesViajes,
                        onChanged: updateVacacionesViajes,
                        items: <String>[
                          'Vacaciones/viajes',
                          'Vacaciones/viajes: Si',
                          'Vacaciones/viajes: No'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                          );
                        }).toList(),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    if (_showTextFieldVacacionesViajes)
                    Column(
                      children: [
                      Container(
                        width: 374,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          controller: _plazoVacacionesViajesController,
                          decoration: InputDecoration(
                            hintText: 'Plazo de las meta (meses y años)',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingrese el objetivo de ahorro';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        width: 374,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _valorVacacionesViajesController,
                          decoration: InputDecoration(
                            hintText: 'Valor de la meta',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingrese el objetivo de ahorro';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        width: 374,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _importanciaVacacionesViajesController,
                          decoration: InputDecoration(
                            hintText: 'Nivel de importancia',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingrese el objetivo de ahorro';
                            }
                            return null;
                          },
                        ),
                      ),
                      ],
                    ),


                    SizedBox(height: 20),

                    Container(
                      width: 374,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      color: Color(0XFF524898),
                      child: DropdownButton<String>(
                        dropdownColor: Color(0XFF524898),
                        value: _automovil,
                        onChanged: updateAutomovil,
                        items: <String>[
                          'Automovil',
                          'Automovil: Si',
                          'Automovil: No'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                          );
                        }).toList(),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    if (_showTextFieldAutomovil)
                    Column(
                      children: [
                      Container(
                        width: 374,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          controller: _plazoAutomovilController,
                          decoration: InputDecoration(
                            hintText: 'Plazo de las meta (meses y años)',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingrese el objetivo de ahorro';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        width: 374,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _valorAutomovilController,
                          decoration: InputDecoration(
                            hintText: 'Valor de la meta',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingrese el objetivo de ahorro';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        width: 374,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _importanciaAutomovilController,
                          decoration: InputDecoration(
                            hintText: 'Nivel de importancia',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingrese el objetivo de ahorro';
                            }
                            return null;
                          },
                        ),
                      ),
                      ],
                    ),


                    SizedBox(height: 20),


                    Container(
                      width: 374,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      color: Color(0XFF524898),
                      child: DropdownButton<String>(
                        dropdownColor: Color(0XFF524898),
                        value: _educacion,
                        onChanged: updateEducacion,
                        items: <String>[
                          'Educacion',
                          'Educacion: Si',
                          'Educacion: No'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                          );
                        }).toList(),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    if (_showTextFieldEducacion)
                    Column(
                      children: [
                      Container(
                        width: 374,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          controller: _plazoEducacionController,
                          decoration: InputDecoration(
                            hintText: 'Plazo de las meta (meses y años)',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingrese el objetivo de ahorro';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        width: 374,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _valorEducacionController,
                          decoration: InputDecoration(
                            hintText: 'Valor de la meta',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingrese el objetivo de ahorro';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        width: 374,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _importanciaEducacionController,
                          decoration: InputDecoration(
                            hintText: 'Nivel de importancia',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingrese el objetivo de ahorro';
                            }
                            return null;
                          },
                        ),
                      ),
                      ],
                    ),


                    SizedBox(height: 20),


                    Container(
                      width: 374,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      color: Color(0XFF524898),
                      child: DropdownButton<String>(
                        dropdownColor: Color(0XFF524898),
                        value: _inmuebleColombia,
                        onChanged: updateInmuebleColombia,
                        items: <String>[
                          'Inmueble en Colombia',
                          'Inmueble en Colombia: Si',
                          'Inmueble en Colombia: No'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                          );
                        }).toList(),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    if (_showTextFieldInmuebleColombia)
                    Column(
                      children: [
                      Container(
                        width: 374,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          controller: _plazoInmuebleColombiaController,
                          decoration: InputDecoration(
                            hintText: 'Plazo de las meta (meses y años)',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingrese el objetivo de ahorro';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        width: 374,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _valorInmuebleColombiaController,
                          decoration: InputDecoration(
                            hintText: 'Valor de la meta',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingrese el objetivo de ahorro';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        width: 374,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _importanciaInmuebleColombiaController,
                          decoration: InputDecoration(
                            hintText: 'Nivel de importancia',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingrese el objetivo de ahorro';
                            }
                            return null;
                          },
                        ),
                      ),
                      ],
                    ),


                    SizedBox(height: 20),


                    Container(
                      width: 374,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      color: Color(0XFF524898),
                      child: DropdownButton<String>(
                        dropdownColor: Color(0XFF524898),
                        value: _inmuebleUsa,
                        onChanged: updateInmuebleUsa,
                        items: <String>[
                          'Inmueble en USA',
                          'Inmueble en USA: Si',
                          'Inmueble en USA: No'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                          );
                        }).toList(),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    if (_showTextFieldInmuebleUsa)
                    Column(
                      children: [
                      Container(
                        width: 374,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          controller: _plazoInmuebleUsaController,
                          decoration: InputDecoration(
                            hintText: 'Plazo de las meta (meses y años)',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingrese el objetivo de ahorro';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        width: 374,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _valorInmuebleUsaController,
                          decoration: InputDecoration(
                            hintText: 'Valor de la meta',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingrese el objetivo de ahorro';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        width: 374,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _importanciaInmuebleUsaController,
                          decoration: InputDecoration(
                            hintText: 'Nivel de importancia',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingrese el objetivo de ahorro';
                            }
                            return null;
                          },
                        ),
                      ),
                      ],
                    ),


                    SizedBox(height: 20),


                    Container(
                      width: 374,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      color: Color(0XFF524898),
                      child: DropdownButton<String>(
                        dropdownColor: Color(0XFF524898),
                        value: _tratamientosMedicos,
                        onChanged: updateTratamientosMedicos,
                        items: <String>[
                          'Tratamientos medicos y esteticos',
                          'Tratamientos medicos y esteticos: Si',
                          'TratamientosMedicos y esteticos: No'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                          );
                        }).toList(),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    if (_showTextFieldTratamientosMedicos)
                    Column(
                      children: [
                      Container(
                        width: 374,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          controller: _plazoTratamientosMedicosController,
                          decoration: InputDecoration(
                            hintText: 'Plazo de las meta (meses y años)',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingrese el objetivo de ahorro';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        width: 374,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _valorTratamientosMedicosController,
                          decoration: InputDecoration(
                            hintText: 'Valor de la meta',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingrese el objetivo de ahorro';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        width: 374,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _importanciaTratamientosMedicosController,
                          decoration: InputDecoration(
                            hintText: 'Nivel de importancia',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingrese el objetivo de ahorro';
                            }
                            return null;
                          },
                        ),
                      ),
                      ],
                    ),


                    SizedBox(height: 20),


                    Container(
                      width: 374,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      color: Color(0XFF524898),
                      child: DropdownButton<String>(
                        dropdownColor: Color(0XFF524898),
                        value: _tecnologia,
                        onChanged: updateTecnologia,
                        items: <String>[
                          'Tecnologia',
                          'Tecnologia: Si',
                          'Tecnologia: No'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                          );
                        }).toList(),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    if (_showTextFieldTecnologia)
                    Column(
                      children: [
                      Container(
                        width: 374,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          controller: _plazoTecnologiaController,
                          decoration: InputDecoration(
                            hintText: 'Plazo de las meta (meses y años)',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingrese el objetivo de ahorro';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        width: 374,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _valorTecnologiaController,
                          decoration: InputDecoration(
                            hintText: 'Valor de la meta',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingrese el objetivo de ahorro';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        width: 374,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _importanciaTecnologiaController,
                          decoration: InputDecoration(
                            hintText: 'Nivel de importancia',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingrese el objetivo de ahorro';
                            }
                            return null;
                          },
                        ),
                      ),
                      ],
                    ),


                    SizedBox(height: 20),


                    Container(
                      width: 374,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      color: Color(0XFF524898),
                      child: DropdownButton<String>(
                        dropdownColor: Color(0XFF524898),
                        value: _entretenimiento,
                        onChanged: updateEntretenimiento,
                        items: <String>[
                          'Entretenimiento - conciertos y festivales',
                          'Entretenimiento - conciertos y festivales: Si',
                          'Entretenimiento - conciertos y festivales: No'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                          );
                        }).toList(),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    if (_showTextFieldEntretenimiento)
                    Column(
                      children: [
                      Container(
                        width: 374,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          controller: _plazoEntretenimientoController,
                          decoration: InputDecoration(
                            hintText: 'Plazo de las meta (meses y años)',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingrese el objetivo de ahorro';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        width: 374,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _valorEntretenimientoController,
                          decoration: InputDecoration(
                            hintText: 'Valor de la meta',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingrese el objetivo de ahorro';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        width: 374,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _importanciaEntretenimientoController,
                          decoration: InputDecoration(
                            hintText: 'Nivel de importancia',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingrese el objetivo de ahorro';
                            }
                            return null;
                          },
                        ),
                      ),
                      ],
                    ),


                    SizedBox(height: 20),


                    Container(
                      width: 374,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      color: Color(0XFF524898),
                      child: DropdownButton<String>(
                        dropdownColor: Color(0XFF524898),
                        value: _eventosDeportivos,
                        onChanged: updateEventosDeportivos,
                        items: <String>[
                          'Eventos deportivos internacionales',
                          'Eventos deportivos internacionales: Si',
                          'Eventos deportivos internacionales: No'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                          );
                        }).toList(),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    if (_showTextFieldEventosDeportivos)
                    Column(
                      children: [
                      Container(
                        width: 374,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          controller: _plazoEventosDeportivosController,
                          decoration: InputDecoration(
                            hintText: 'Plazo de las meta (meses y años)',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingrese el objetivo de ahorro';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        width: 374,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _valorEventosDeportivosController,
                          decoration: InputDecoration(
                            hintText: 'Valor de la meta',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingrese el objetivo de ahorro';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        width: 374,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _importanciaEventosDeportivosController,
                          decoration: InputDecoration(
                            hintText: 'Nivel de importancia',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingrese el objetivo de ahorro';
                            }
                            return null;
                          },
                        ),
                      ),
                      ],
                    ),


                    SizedBox(height: 20),


                    Container(
                      width: 374,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      color: Color(0XFF524898),
                      child: DropdownButton<String>(
                        dropdownColor: Color(0XFF524898),
                        value: _otros,
                        onChanged: updateOtros,
                        items: <String>[
                          'Otros',
                          'Otros: Si',
                          'Otros: No'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                          );
                        }).toList(),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    if (_showTextFieldOtros)
                    Column(
                      children: [
                      Container(
                        width: 374,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          controller: _plazoOtrosController,
                          decoration: InputDecoration(
                            hintText: 'Plazo de las meta (meses y años)',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingrese el objetivo de ahorro';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        width: 374,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _valorOtrosController,
                          decoration: InputDecoration(
                            hintText: 'Valor de la meta',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingrese el objetivo de ahorro';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        width: 374,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: _importanciaOtrosController,
                          decoration: InputDecoration(
                            hintText: 'Nivel de importancia',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor, ingrese el objetivo de ahorro';
                            }
                            return null;
                          },
                        ),
                      ),
                      ],
                    ),


                    SizedBox(height: 40),



                    ElevatedButton(
                      onPressed: (){
              if (_vacionesViajes == 'Vacaciones/viajes' ||
              _automovil == 'Automovil' ||
                _educacion == 'Educacion' ||
                _inmuebleColombia == 'Inmueble en Colombia' ||
                _inmuebleUsa == 'Inmueble en USA' || 
                _tratamientosMedicos == 'Tratamientos medicos y esteticos' ||
                _tecnologia == 'Tecnologia' ||
                _entretenimiento == 'Entretenimiento-conciertos y festivales' ||
                _eventosDeportivos == 'Eventos deportivos internacionales' ||
                _otros == 'Otros'
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
      );
    } else {
      saveMetasFinancieras();
    }
                        
                      },
                      child: Text('Guardar metas financieras', style: TextStyle(fontSize: 18)),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0XFFE8E112),
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
                ),
              ),
            ),
          ],
        ),
      ),
      )
    );
  }
}


