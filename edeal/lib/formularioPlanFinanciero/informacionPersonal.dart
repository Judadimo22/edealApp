import 'dart:convert';
import 'package:edeal/formularioPlanFinanciero/controlFinanzas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class InformacionPersonal extends StatefulWidget {
  final String token;

  const InformacionPersonal({required this.token, Key? key}) : super(key: key);

  @override
  State<InformacionPersonal> createState() => _InformacionPersonalState();
}

class _InformacionPersonalState extends State<InformacionPersonal> {
  late String userId;
  Map<String, dynamic> userData = {};
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _fechaNacimientoController = TextEditingController();
  final TextEditingController _lugarResidencia = TextEditingController();
  final TextEditingController _nombreDependiente = TextEditingController();
  final TextEditingController _fechaNacimientoDependienteController = TextEditingController();
  final TextEditingController _relacionDependienteController = TextEditingController();
  DateTime ? selectedDate;


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

  void saveInfoPersonal() async {
    // var newData = _newDataController.text;

    var response = await http.put(
      Uri.parse('https://edeal-app.onrender.com/infoPersonal/$userId'),
      body: {
        'estadoCivilCliente1': _estatusCivil,
        'situacionLaboralCliente1': _situacionLaboral,
        'lugarResidenciaCLiente1': _lugarResidencia.text,
        'nombreDependiente': _nombreDependiente.text,
        'relacionDependiente': _relacionDependienteController.text,
        'fechaNacimientoDependiente': _fechaNacimientoDependienteController.text
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        userData['estadoCivilCliente1'] = _estatusCivil;
        userData['situacionLaboralCliente1'] = _situacionLaboral;
        userData['lugarResidenciaCLiente1'] = _lugarResidencia.text;
        userData['nombreDependiente'] = _nombreDependiente.text;
        userData['relacionDependient'] = _relacionDependienteController.text;
        userData['fechaNacimientoDependiente'] = _fechaNacimientoDependienteController.text;
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
      backgroundColor: const Color(0XFF524898),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 80),
              child: const Text(
                'Paso1 : Mi perfil',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30
                ),
              )
            ),
            Container(
              margin: const EdgeInsets.only(top: 50),
              child: const Text(
                'Información personal',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30
                ),
              )
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20 ),
              child: const Text(
                'Por favor indiquenos la siguiente información de usted y de otras personas que soporten sus gastos y metas financieras',
                style: TextStyle(
                  color: Colors.white,
                ) ,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, right: 20,left: 20),
              child: const Text(
                'CLIENTE 1',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),
              ),
            ),
            Container(
              width: 370,
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Text(
                'Nombre: ${userData['name']}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16
                )
                )
            ),
            Container(
              width: 370,
              margin: const EdgeInsets.only(top: 25, left: 20, right: 20),
              child: Text(
                'Fecha de nacimiento: ${userData['fechaNacimiento']}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16
                ),
                ) ,
            ),
            Container(
              width: 374,
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
              child: DropdownButton<String>(
                dropdownColor: const Color(0XFF524898),
                value: _estatusCivil,
                onChanged: _updateEstatusCivil,
                 items:<String>[
                  'Estatus civil',
                  'Soltero',
                  'Casado',
                  'En convivencia'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(
                        color: Colors.white
                      ),
                      ),
                  );
                }).toList(),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              width: 374,
              margin: const EdgeInsets.only(top: 20, right: 20, left: 20),
              child: DropdownButton<String>(
                dropdownColor: const Color(0XFF524898),
                value: _situacionLaboral,
                onChanged: _updateSituacionLaboral,
                 items:<String>[
                  'Situacion laboral',
                  'Jubilado',
                  'Desempleado',
                  'Empleado',
                  'Empresa propia'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(
                        color: Colors.white
                      ),
                      ),
                  );
                }).toList(),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: TextField(
                controller: _lugarResidencia,
                decoration: const InputDecoration(
                  hintText: 'Lugar de residencia',
                  hintStyle: TextStyle(
                    color: Colors.white
                  )
                ),
                style: const TextStyle(
                  color: Colors.white
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: const Text(
                'Familia y otros dependientes',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: const Text(
                'Por favor indique si tiene hijos, nietos u otras personas cercanas que dependn financieramente de usted',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: TextField(
                controller: _nombreDependiente,
                decoration: const InputDecoration(
                  hintText: 'Nombre',
                  hintStyle: TextStyle(
                    color: Colors.white
                  )
                ),
                style: const TextStyle(
                  color: Colors.white
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
                    color: Colors.white
                  )
                ),
                style: const TextStyle(
                  color: Colors.white
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
                      color: Colors.white,
                      Icons.calendar_today
                    ))
                ),
                style: const TextStyle(
                  color: Colors.white
                ),
              ) ,
            ),
            Container(
              margin: const EdgeInsets.only(top: 30, bottom: 30, left: 20, right: 20),
              child: ElevatedButton(
  onPressed: () {
    if (_estatusCivil == 'Estatus civil' ||
        _situacionLaboral == 'Situacion laboral' ||
        _lugarResidencia.text.isEmpty ||
        _nombreDependiente.text.isEmpty ||
        _relacionDependienteController.text.isEmpty ||
        _fechaNacimientoDependienteController.text.isEmpty) {
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
    } else {
      saveInfoPersonal();
    }
  },
  child: const Text('Continuar'),
),
            )
          ],
        ),
        )
      ),

    );
  }

  }

