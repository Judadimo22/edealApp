import 'dart:convert';
import 'package:edeal/formularioPlanFinanciero/controlFinanzas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class InformacionPersonal extends StatefulWidget {
  final String token;

  const InformacionPersonal({required this.token, Key? key}) : super(key: key);

  @override
  State<InformacionPersonal> createState() => _InformacionPersonalState();
}

class _InformacionPersonalState extends State<InformacionPersonal> {
  late String userId;
  Map<String, dynamic> userData = {};
  final TextEditingController _fechaNacimientoController = TextEditingController();
  final TextEditingController _lugarResidencia = TextEditingController();
  final TextEditingController _nombreDependiente = TextEditingController();
  final TextEditingController _fechaNacimientoDependienteController = TextEditingController();
  final TextEditingController _relacionDependienteController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  DateTime ? selectedDate;
  String _planCobertura = 'Cuenta con un plan de salud';
  String _tipoPlan = 'Que tipo de plan';
  String _porcentajeCobertura = 'Porcentaje de cobertura';

  bool _showPlanCobertura = false;



  Future<void> _selectDateFechaNacimiento(BuildContext context) async {
    final DateTime? picked = await DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(1900),
      maxTime: DateTime.now(),
      locale: LocaleType.es
    );

        if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _fechaNacimientoController.text =
            "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  Future<void> _selectFechaNacimientoDependiente(BuildContext context) async {
    final DateTime? picked = await DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(1900),
      maxTime: DateTime.now(),
      locale: LocaleType.es
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _fechaNacimientoDependienteController.text =
            "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  String _estatusCivil = 'Estatus civil';

  void _updateEstatusCivil (String? newStatusCivil){
    setState(() {
      _estatusCivil = newStatusCivil!;
    });
  }

  String _situacionLaboral = 'Situacion laboral';

  void _updateSituacionLaboral (String? newSituacionLaboral){
    setState(() {
      _situacionLaboral = newSituacionLaboral!;
    });
  }


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

    void updatePlanCobertura(String? newPlanCobertura) {
    setState(() {
      _planCobertura = newPlanCobertura!;
      if (newPlanCobertura == 'Si') {
        _showPlanCobertura = true;
      } else {
        _showPlanCobertura = false;
      }
    });
  }

    void updateTipoPlan(String? newTipoPLan) {
    setState(() {
      _tipoPlan= newTipoPLan!;
    });
  }

    void updatePorcentajeCobertura(String? newPorcentajeCobertura) {
    setState(() {
      _porcentajeCobertura = newPorcentajeCobertura!;
    });
  }


  void saveInfoPersonal() async {
    var response = await http.put(
      Uri.parse('https://edeal-app.onrender.com/infoPersonal/$userId'),
      body: {
        'estadoCivilCliente1': _estatusCivil,
        'situacionLaboralCliente1': _situacionLaboral,
        'lugarResidenciaCLiente1': _lugarResidencia.text,
        'phone': _phoneController.text,
        'cuentaConPlanSalud': _planCobertura,
        'tipoPlanSalud': _tipoPlan,
        'porcentajeCoberturaPlan': _porcentajeCobertura
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        userData['estadoCivilCliente1'] = _estatusCivil;
        userData['situacionLaboralCliente1'] = _situacionLaboral;
        userData['lugarResidenciaCLiente1'] = _lugarResidencia.text;
        userData['phone'] = _phoneController.text;
        userData['cuentaConPlanSalud'] = _planCobertura;
        userData['tipoPlanSalud'] = _tipoPlan;
        userData['porcentajeCoberturaPlan'] = _porcentajeCobertura;
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Información personal actualizada'),
            content: Text('Gracias por completar el paso núnero 1.'),
            actions: [
              TextButton(
                  onPressed: (){
                    if (userData['estadoCivilCliente1'] == null){
                              showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Completa todos los campos antes de continuar'),
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
                    }
            else {
             Navigator.push(context, MaterialPageRoute(builder: (context)=>ControlFinanzas(token: widget.token)));
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

  void addDependiente1() async {
    var response = await http.put(
      Uri.parse('https://edeal-app.onrender.com/dependiente1/$userId'),
      body: {
        'nombreDependiente': _nombreDependiente.text,
        'relacionDependiente': _relacionDependienteController.text,
        'fechaNacimientoDependiente': _fechaNacimientoDependienteController.text,
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        userData['nombreDependiente'] = _nombreDependiente.text;
        userData['relacionDependiente'] = _relacionDependienteController.text;
        userData['fechaNacimientoDependiente'] = _fechaNacimientoDependienteController.text;
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Información dependiente actualizada'),
            content: Text('Has añadido la informacíon de una persona dependiente'),
            actions: [
              TextButton(
                  onPressed: (){
                    if (userData['nombreDependiente'] == null){
                              showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Completa todos los campos antes de continuar'),
              content: Text('Por favor diligencia los datos '),
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
             Navigator.push(context, MaterialPageRoute(builder: (context)=>InformacionPersonal(token: widget.token)));
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

  void addDependiente2() async {
    var response = await http.put(
      Uri.parse('https://edeal-app.onrender.com/dependiente2/$userId'),
      body: {
        'nombreDependiente2': _nombreDependiente.text,
        'relacionDependiente2': _relacionDependienteController.text,
        'fechaNacimientoDependiente2': _fechaNacimientoDependienteController.text,
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        userData['nombreDependiente2'] = _nombreDependiente.text;
        userData['relacionDependiente2'] = _relacionDependienteController.text;
        userData['fechaNacimientoDependiente2'] = _fechaNacimientoDependienteController.text;
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Información dependiente actualizada'),
            content: Text('Has añadido la informacíon de una persona dependiente'),
            actions: [
              TextButton(
                  onPressed: (){
                    if (userData['nombreDependiente2'] == null){
                              showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Completa todos los campos antes de continuar'),
              content: Text('Por favor diligencia los datos '),
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
             Navigator.push(context, MaterialPageRoute(builder: (context)=>InformacionPersonal(token: widget.token)));
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

  void addDependiente3() async {
    var response = await http.put(
      Uri.parse('https://edeal-app.onrender.com/dependiente3/$userId'),
      body: {
        'nombreDependiente3': _nombreDependiente.text,
        'relacionDependiente3': _relacionDependienteController.text,
        'fechaNacimientoDependiente3': _fechaNacimientoDependienteController.text,
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        userData['nombreDependiente3'] = _nombreDependiente.text;
        userData['relacionDependiente3'] = _relacionDependienteController.text;
        userData['fechaNacimientoDependiente3'] = _fechaNacimientoDependienteController.text;
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Información dependiente actualizada'),
            content: Text('Has añadido la informacíon de una persona dependiente'),
            actions: [
              TextButton(
                  onPressed: (){
                    if (userData['nombreDependiente2'] == null){
                              showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Completa todos los campos antes de continuar'),
              content: Text('Por favor diligencia los datos '),
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
             Navigator.push(context, MaterialPageRoute(builder: (context)=>InformacionPersonal(token: widget.token)));
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
                'Información',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF444C52),
                  fontSize: MediaQuery.of(context).size.height * 0.035,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  letterSpacing: -0.01
                )
              ),
              Text(
                ' personal        ',
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
                'Por favor indiquenos la siguiente información de usted y de otras personas que soporten sus gastos y metas financieras',
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
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.040 ),
                    child: Column(
                      children: [ 
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.050),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Fecha de nacimiento', 
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
                      controller: _fechaNacimientoController,
                      readOnly: true,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Fecha de nacimiento",
                        hintStyle: const TextStyle(
                          color: Color(0xFFABB3B8)
                        ),
                        suffixIcon: IconButton(
                          onPressed: (){
                            _selectDateFechaNacimiento(context);
                          },
                          icon: const Icon(
                            color: Color(0xFF0C67B0),
                            Icons.calendar_today
                            ),
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
            Column(children: [
              Container(
                          margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.050, right: MediaQuery.of(context).size.height * 0.050, top: MediaQuery.of(context).size.height * 0.020 ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Estatus civil', 
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
                width: MediaQuery.of(context).size.height * 1,
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.005, left: MediaQuery.of(context).size.height * 0.045, right: MediaQuery.of(context).size.height * 0.045, bottom: MediaQuery.of(context).size.height * 0.009 ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF0C67B0),
                    width: 1
                  )
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.008, horizontal: MediaQuery.of(context).size.height * 0.010),
                  child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    dropdownColor: Colors.white,
                    value: _estatusCivil,
                    onChanged: _updateEstatusCivil,
                    items: <String>[
                      'Estatus civil',
                      'Soltero',
                      'Casado',
                      'En convivencia'
                    ].map<DropdownMenuItem<String>>((String value){
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.002),
                          child: Text(
                            value,
                            style: const TextStyle(
                              color: Color(0xFFABB3B8),
                            ),
                          ),
                          )
                          ,
                      );
                    }).toList(),
                    underline: null,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Color(0xFF0C67B0)
                    ),
                  )
                  ),
                )
              ),
                            Container(
                          margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.050, right: MediaQuery.of(context).size.height * 0.050, top: MediaQuery.of(context).size.height * 0.020 ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Situación laboral', 
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
                width: MediaQuery.of(context).size.height * 1,
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.005, left: MediaQuery.of(context).size.height * 0.045, right: MediaQuery.of(context).size.height * 0.045),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF0C67B0),
                    width: 1
                  )
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.008, horizontal: MediaQuery.of(context).size.height * 0.010),
                  child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    dropdownColor: Colors.white,
                    value: _situacionLaboral,
                    onChanged: _updateSituacionLaboral,
                    items: <String>[
                      'Situacion laboral',
                      'Jubilado',
                      'Dedicado al hogar',
                      'Desempleado',
                      'Empleado',
                      'Empresa propia'
                    ].map<DropdownMenuItem<String>>((String value){
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.002),
                          child: Text(
                            value,
                            style: const TextStyle(
                              color: Color(0xFFABB3B8),
                            ),
                          ),
                          )
                          ,
                      );
                    }).toList(),
                    underline: null,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Color(0xFF0C67B0)
                    ),
                  )
                  ),
                )
              ),
            ],),
            Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.030 ),
                    child: Column(
                      children: [ 
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.050),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Lugar de residencia', 
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
                      controller: _lugarResidencia,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Lugar de residencia",
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
                              'Teléfono', 
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
                      controller: _phoneController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Ingresa tu teléfono",
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
                    margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.010 , right: MediaQuery.of(context).size.height * 0.050, top: MediaQuery.of(context).size.height * 0.020  ),
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                        onPressed: (){
                          if(userData['nombreDependiente'] == null) {
                          showDialog(
                            context: context, 
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title:Text(
                              'Agregar dependiente', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.016,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ), 
                            content: Container(
                              child: Column(
                                children: [
                                              Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: TextField(
                controller: _nombreDependiente,
                decoration: const InputDecoration(
                  hintText: 'Nombre',
                  hintStyle: TextStyle(
                    color: Colors.black
                  )
                ),
                style: const TextStyle(
                  color: Colors.black
                ),
              ),
            ),
                        Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: TextField(
                controller: _relacionDependienteController,
                decoration: const InputDecoration(
                  hintText: 'Relación',
                  hintStyle: TextStyle(
                    color: Colors.black
                  )
                ),
                style: const TextStyle(
                  color: Colors.black
                ),
              ),
            ),
                        Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: TextField(
                controller: _fechaNacimientoDependienteController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Fecha de nacimiento',
                  hintStyle: const TextStyle(
                    color: Colors.white
                  ),
                  suffixIcon: IconButton(
                    onPressed: (){
                      _selectFechaNacimientoDependiente(context);
                    }, 
                    icon: const Icon(
                      color: Colors.black,
                      Icons.calendar_today
                    ))
                ),
                style: const TextStyle(
                  color: Colors.black
                ),
              ) ,
            ),
                                ],
                              ),
                            ),
            actions: [
              ElevatedButton(
                onPressed: (){
                  addDependiente1();
                }, 
                child: const Text('Añadir')),
            ],
                              );
                            }
                            );
                          }

  
                          else if(userData['nombreDependiente'] != null && userData['nombreDependiente2'] == null) {
                          showDialog(
                            context: context, 
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title:Text(
                              'Agregar dependiente 2', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.016,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ), 
                            content: Container(
                              child: Column(
                                children: [
                                              Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: TextField(
                controller: _nombreDependiente,
                decoration: const InputDecoration(
                  hintText: 'Nombre',
                  hintStyle: TextStyle(
                    color: Colors.black
                  )
                ),
                style: const TextStyle(
                  color: Colors.black
                ),
              ),
            ),
                        Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: TextField(
                controller: _relacionDependienteController,
                decoration: const InputDecoration(
                  hintText: 'Relación',
                  hintStyle: TextStyle(
                    color: Colors.black
                  )
                ),
                style: const TextStyle(
                  color: Colors.black
                ),
              ),
            ),
                        Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: TextField(
                controller: _fechaNacimientoDependienteController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Fecha de nacimiento',
                  hintStyle: const TextStyle(
                    color: Colors.white
                  ),
                  suffixIcon: IconButton(
                    onPressed: (){
                      _selectFechaNacimientoDependiente(context);
                    }, 
                    icon: const Icon(
                      color: Colors.black,
                      Icons.calendar_today
                    ))
                ),
                style: const TextStyle(
                  color: Colors.black
                ),
              ) ,
            ),
                                ],
                              ),
                            ),
            actions: [
              ElevatedButton(
                onPressed: (){
                  addDependiente2();
                }, 
                child: const Text('Añadir')),
            ],
                              );
                            }
                            );
                          }
          
            else if(userData['nombreDependiente'] != null && userData['nombreDependiente2'] != null && userData['nombreDependiente3'] == null) {
                          showDialog(
                            context: context, 
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title:Text(
                              'Agregar dependiente 3', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.016,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ), 
                            content: Container(
                              child: Column(
                                children: [
                                              Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: TextField(
                controller: _nombreDependiente,
                decoration: const InputDecoration(
                  hintText: 'Nombre',
                  hintStyle: TextStyle(
                    color: Colors.black
                  )
                ),
                style: const TextStyle(
                  color: Colors.black
                ),
              ),
            ),
                        Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: TextField(
                controller: _relacionDependienteController,
                decoration: const InputDecoration(
                  hintText: 'Relación',
                  hintStyle: TextStyle(
                    color: Colors.black
                  )
                ),
                style: const TextStyle(
                  color: Colors.black
                ),
              ),
            ),
                        Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: TextField(
                controller: _fechaNacimientoDependienteController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Fecha de nacimiento',
                  hintStyle: const TextStyle(
                    color: Colors.white
                  ),
                  suffixIcon: IconButton(
                    onPressed: (){
                      _selectFechaNacimientoDependiente(context);
                    }, 
                    icon: const Icon(
                      color: Colors.black,
                      Icons.calendar_today
                    ))
                ),
                style: const TextStyle(
                  color: Colors.black
                ),
              ) ,
            ),
                                ],
                              ),
                            ),
            actions: [
              ElevatedButton(
                onPressed: (){
                  addDependiente3();
                }, 
                child: const Text('Añadir')),
            ],
                              );
                            }
                            );
                          }
                        },
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
                              EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05, vertical: MediaQuery.of(context).size.height * 0.008),
                          ),
                        ),
                         child: Text(
                              '+ Añadir', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.width * 0.04,
                                fontWeight: FontWeight.w400,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
                      )
                  ),
            Container(
              margin: EdgeInsets.only(top:MediaQuery.of(context).size.width * 0.05, left: MediaQuery.of(context).size.width * 0.1, right: MediaQuery.of(context).size.width * 0.1, bottom: MediaQuery.of(context).size.width * 0.03),
              child: Text(
                'Familia y otros dependientes',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF444C52),
                  fontSize: MediaQuery.of(context).size.height * 0.020,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  letterSpacing: -0.01
                )
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFFEDE5E5),
                  width: 0.5
                ),
                borderRadius: BorderRadius.circular(12)
              ),
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03, right: MediaQuery.of(context).size.width * 0.03, top: MediaQuery.of(context).size.width * 0.03, bottom: MediaQuery.of(context).size.width * 0.03  ) ,
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1, right: MediaQuery.of(context).size.width * 0.1  ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(
                    '${userData['nombreDependiente']}', 
                    style: GoogleFonts.poppins(
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                    letterSpacing: -0.01,
                    color: const Color(0xFF444C52)
                    ),                   
                  ),
                  Text(
                    '${userData['relacionDependiente']}', 
                    style: GoogleFonts.poppins(
                    fontSize: MediaQuery.of(context).size.width * 0.025,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                    letterSpacing: -0.01,
                    color: const Color(0xFF444C52)
                    ),                   
                  ),
                ],
              )
              
            ),
            if(userData['nombreDependiente2'] != null)
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFFEDE5E5),
                  width: 0.5
                ),
                borderRadius: BorderRadius.circular(12)
              ),
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03, right: MediaQuery.of(context).size.width * 0.03, top: MediaQuery.of(context).size.width * 0.03, bottom: MediaQuery.of(context).size.width * 0.03  ) ,
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1, right: MediaQuery.of(context).size.width * 0.1, top: MediaQuery.of(context).size.width * 0.01   ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(
                    '${userData['nombreDependiente2']}', 
                    style: GoogleFonts.poppins(
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                    letterSpacing: -0.01,
                    color: const Color(0xFF444C52)
                    ),                   
                  ),
                  Text(
                    '${userData['relacionDependiente2']}', 
                    style: GoogleFonts.poppins(
                    fontSize: MediaQuery.of(context).size.width * 0.025,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                    letterSpacing: -0.01,
                    color: const Color(0xFF444C52)
                    ),                   
                  ),
                ],
              )
              
            ),
            if(userData['nombreDependiente3'] != null)
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFFEDE5E5),
                  width: 0.5
                ),
                borderRadius: BorderRadius.circular(12)
              ),
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03, right: MediaQuery.of(context).size.width * 0.03, top: MediaQuery.of(context).size.width * 0.03, bottom: MediaQuery.of(context).size.width * 0.03  ) ,
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1, right: MediaQuery.of(context).size.width * 0.1, top: MediaQuery.of(context).size.width * 0.01   ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(
                    '${userData['nombreDependiente3']}', 
                    style: GoogleFonts.poppins(
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                    letterSpacing: -0.01,
                    color: const Color(0xFF444C52)
                    ),                   
                  ),
                  Text(
                    '${userData['relacionDependiente3']}', 
                    style: GoogleFonts.poppins(
                    fontSize: MediaQuery.of(context).size.width * 0.025,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                    letterSpacing: -0.01,
                    color: const Color(0xFF444C52)
                    ),                   
                  ),
                ],
              )
              
            ),
            Container(
              margin: EdgeInsets.only(top:MediaQuery.of(context).size.width * 0.09, left: MediaQuery.of(context).size.width * 0.02, right: MediaQuery.of(context).size.width * 0.02, bottom: MediaQuery.of(context).size.width * 0.01),
              child: Text(
                'Salud                                                  ',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF444C52),
                  fontSize: MediaQuery.of(context).size.height * 0.020,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  letterSpacing: -0.01
                )
              ),
            ),
             Container(
                          margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.050, right: MediaQuery.of(context).size.height * 0.050, top: MediaQuery.of(context).size.height * 0.020 ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Cuenta con un plan de salud', 
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
                width: MediaQuery.of(context).size.height * 1,
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.005, left: MediaQuery.of(context).size.height * 0.045, right: MediaQuery.of(context).size.height * 0.045),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF0C67B0),
                    width: 1
                  )
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.008, horizontal: MediaQuery.of(context).size.height * 0.010),
                  child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    dropdownColor: Colors.white,
                    value: _planCobertura,
                    onChanged: updatePlanCobertura,
                    items: <String>[
                      'Cuenta con un plan de salud',
                      'Si',
                      'No',
                    ].map<DropdownMenuItem<String>>((String value){
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.002),
                          child: Text(
                            value,
                            style: const TextStyle(
                              color: Color(0xFFABB3B8),
                            ),
                          ),
                          )
                          ,
                      );
                    }).toList(),
                    underline: null,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Color(0xFF0C67B0)
                    ),
                  )
                  ),
                )
              ),
            if (_showPlanCobertura)
                    Column(
                      children: [
                Container(
                          margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.050, right: MediaQuery.of(context).size.height * 0.050, top: MediaQuery.of(context).size.height * 0.020 ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Que tipo de plan', 
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
                width: MediaQuery.of(context).size.height * 1,
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.005, left: MediaQuery.of(context).size.height * 0.045, right: MediaQuery.of(context).size.height * 0.045),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF0C67B0),
                    width: 1
                  )
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.008, horizontal: MediaQuery.of(context).size.height * 0.010),
                  child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    dropdownColor: Colors.white,
                    value: _tipoPlan,
                    onChanged: updateTipoPlan,
                    items: <String>[
                      'Que tipo de plan',
                      'Publico',
                      'Privado',
                    ].map<DropdownMenuItem<String>>((String value){
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.002),
                          child: Text(
                            value,
                            style: const TextStyle(
                              color: Color(0xFFABB3B8),
                            ),
                          ),
                          )
                          ,
                      );
                    }).toList(),
                    underline: null,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Color(0xFF0C67B0)
                    ),
                  )
                  ),
                )
              ),
              Container(
                          margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.050, right: MediaQuery.of(context).size.height * 0.050, top: MediaQuery.of(context).size.height * 0.020 ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Porcentaje de cobertura de su plan', 
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
                width: MediaQuery.of(context).size.height * 1,
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.005, left: MediaQuery.of(context).size.height * 0.045, right: MediaQuery.of(context).size.height * 0.045),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF0C67B0),
                    width: 1
                  )
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.008, horizontal: MediaQuery.of(context).size.height * 0.010),
                  child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    dropdownColor: Colors.white,
                    value: _porcentajeCobertura,
                    onChanged: updatePorcentajeCobertura,
                    items: <String>[
                      'Porcentaje de cobertura',
                      '0 a 25 %',
                      '25 a 50 %',
                      '50 a 75 %',
                      '100%'
                    ].map<DropdownMenuItem<String>>((String value){
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.002),
                          child: Text(
                            value,
                            style: const TextStyle(
                              color: Color(0xFFABB3B8),
                            ),
                          ),
                          )
                          ,
                      );
                    }).toList(),
                    underline: null,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Color(0xFF0C67B0)
                    ),
                  )
                  ),
                )
              ),

                      ],
                    ),

            Center(
                    child: Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.030, bottom:MediaQuery.of(context).size.height * 0.020,),
                      child: ElevatedButton(
                        onPressed: (){
                          if (_estatusCivil == 'Estatus civil' ||
        _situacionLaboral == 'Situacion laboral' ||
        _lugarResidencia.text.isEmpty ||
        _phoneController.text.isEmpty ) {
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
      saveInfoPersonal();
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
                              'Ingresar', 
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

    );
  }

  }

