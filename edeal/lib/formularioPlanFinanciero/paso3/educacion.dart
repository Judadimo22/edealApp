import 'dart:convert';
import 'package:edeal/formularioPlanFinanciero/controlFinanzas.dart';
import 'package:edeal/formularioPlanFinanciero/definirObjetivos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class Educacion extends StatefulWidget {
  final String token;

  const Educacion({required this.token, Key? key}) : super(key: key);

  @override
  State<Educacion> createState() => _EducacionState();
}

class _EducacionState extends State<Educacion> {
  late String userId;
  Map<String, dynamic> userData = {};
  final TextEditingController _numeroHijosController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _anoInicioController = TextEditingController();
  final TextEditingController _numeroAnosController = TextEditingController();
  final TextEditingController _importanciaController = TextEditingController();
  final TextEditingController _montoAnualController = TextEditingController();
  final TextEditingController _nombreInstitucionController = TextEditingController();
  DateTime ? selectedDate;




  String _tipoInstitucion = 'Tipo de institucion educativa';

  void _updateTipoInstitucion(String? newTipoInstitucion){
    setState(() {
      _tipoInstitucion = newTipoInstitucion!;
    });
  }

  String _ubicacion = 'Ubicacion';

  void _updateUbicacion (String? newUbicacion){
    setState(() {
      _ubicacion = newUbicacion!;
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

  void saveObjetivosEducacion() async {

    var response = await http.put(
      Uri.parse('https://edeal-app.onrender.com/objetivosEducacion/$userId'),
      body: {
        'numeroHijos': _numeroHijosController.text,
        'nombreEstudiante1': _nameController.text,
        'añoIniciara': _anoInicioController.text,
        'añosEstudiaria': _numeroAnosController.text,
        'importanciaEducacionEstudiante1': _importanciaController.text,
        'montoEstimadoEducacion': _montoAnualController.text,
        'tipoInstitucionEducativa': _tipoInstitucion,
        'ubicacionEstudiante1': _ubicacion,
        'nombreInstitucionEducativa': _nombreInstitucionController.text
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        userData['numeroHijos'] = _numeroHijosController.text;
        userData['nombreEstudiante1'] = _nameController.text;
        userData['añoIniciara'] = _anoInicioController.text;
        userData['añosEstudiaria'] = _numeroAnosController.text;
        userData['importanciaEducacionEstudiante1'] = _importanciaController.text;
        userData['montoEstimadoEducacion'] = _montoAnualController.text;
        userData['tipoInstitucionEducativa'] = _tipoInstitucion;
        userData['ubicacionEstudiante1'] = _ubicacion;
        userData['nombreInstitucionEducativa'] = _nombreInstitucionController.text;       
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Objetivos de educacion actualizados'),
            content: Text('Tus objetivos de educacion han sido actualizados'),
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

}
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFF524898) ,
      ),
      backgroundColor: const Color(0XFF524898),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: const Text(
                'Educacion',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30
                ),
              )
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20 ),
              child: const Text(
                'Complete esta sección de objetivos si planea pagar la totalidad o parte de una universidad u otro programa educativo para un hijo, nieto u otra persona.',
                style: TextStyle(
                  color: Colors.white,
                ) ,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: TextField(
                controller: _numeroHijosController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Numero de hijos o personas a cargo de su educacion',
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
                'Estudiante 1',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),
              ),
            ),
             Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: TextField(
                controller: _nameController,
                keyboardType: TextInputType.text,
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
                controller: _anoInicioController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Año en el que iniciará',
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
                controller: _numeroAnosController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Número de años que estudiaría',
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
                controller: _importanciaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Importancia: Mayor - Menor  (10 1)',
                  hintStyle: TextStyle(
                    color: Colors.white
                  )
                ),
                style: const TextStyle(
                  color: Colors.white
                ),
              ),
            ),
            SizedBox(height: 40,),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: TextField(
                controller: _montoAnualController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Monto estimado anual',
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
              width: 374,
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: DropdownButton<String>(
                dropdownColor: const Color(0XFF524898),
                value: _tipoInstitucion,
                onChanged: _updateTipoInstitucion,
                 items:<String>[
                  'Tipo de institucion educativa',
                  'Pública',
                  'Privada',
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
                value: _ubicacion,
                onChanged: _updateUbicacion,
                 items:<String>[
                  'Ubicacion',
                  'Dentro de mi ciudad',
                  'Fuera de mi ciudad',
                  'Fuera de mi país',
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
                controller: _nombreInstitucionController,
                decoration: const InputDecoration(
                  hintText: 'Nombre de la institucion educativa',
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
              margin: const EdgeInsets.only(top: 30, bottom: 30, left: 20, right: 20),
              child: ElevatedButton(
                onPressed: () =>{
                if (_numeroHijosController.text.isEmpty ||
                _nameController.text.isEmpty ||
                _anoInicioController.text.isEmpty ||
                _numeroAnosController.text.isEmpty ||
                _importanciaController.text.isEmpty ||
                _montoAnualController.text.isEmpty ||
                _tipoInstitucion == 'Tipo de institucion educativa' ||
                _ubicacion == 'Ubicacion' ||
                _nombreInstitucionController.text.isEmpty
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
      saveObjetivosEducacion()
    }
                  
                },
                child: const Text('Continuar')),
            )
          ],
        ),
        )
      ),

    );
  }

  }