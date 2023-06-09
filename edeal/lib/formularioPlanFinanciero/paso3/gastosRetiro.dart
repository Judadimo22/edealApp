import 'dart:convert';
import 'package:edeal/formularioPlanFinanciero/controlFinanzas.dart';
import 'package:edeal/formularioPlanFinanciero/definirObjetivos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class GastosRetiro extends StatefulWidget {
  final String token;

  const GastosRetiro ({required this.token, Key? key}) : super(key: key);

  @override
  State<GastosRetiro > createState() => _GastosRetiroState();
}

class _GastosRetiroState extends State<GastosRetiro > {
  late String userId;
  Map<String, dynamic> userData = {};
  final TextEditingController _valorViviendaController = TextEditingController();
  final TextEditingController _importanciaViviendaController = TextEditingController();
  final TextEditingController _valorViajesController = TextEditingController();
  final TextEditingController _importanciaViajesController = TextEditingController();
  final TextEditingController _valorSaludController = TextEditingController();
  final TextEditingController _importanciaSaludController = TextEditingController();
  final TextEditingController _valorDependientesController = TextEditingController();
  final TextEditingController _importanciaDependientesController = TextEditingController();
  final TextEditingController _valorOtrosController = TextEditingController();
  final TextEditingController _importanciaOtrosController = TextEditingController();

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

  void saveObjetivosRetiro() async {

    var response = await http.put(
      Uri.parse('https://edeal-app.onrender.com/objetivosRetiro/$userId'),
      body: {
        'valorViviendaRetiro': _valorViviendaController.text,
        'importanciaViviendaRetiro': _importanciaViviendaController.text,
        'valorViajesRetiro': _valorViajesController.text,
        'importanciaViajesRetiro': _importanciaViajesController.text,
        'valorSaludRetiro': _valorSaludController.text,
        'importanciaSaludRetiro': _importanciaSaludController.text,
        'valorDependientesRetiro': _valorDependientesController.text,
        'importanciaDependientesRetiro': _importanciaDependientesController.text,
        'valorOtrosRetiro': _valorOtrosController.text,
        'importanciaOtrosRetiro': _importanciaOtrosController.text
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        userData['valorViviendaRetiro'] = _valorViviendaController.text;
        userData['importanciaViviendaRetiro'] = _importanciaViviendaController.text;
        userData['valorViajesRetiro'] = _valorViajesController.text;
        userData['importanciaViajesRetiro'] = _importanciaViajesController.text;
        userData['valorSaludRetiro'] = _valorSaludController.text;
        userData['importanciaSaludRetiro'] = _importanciaSaludController.text;
        userData['valorDependientesRetiro'] = _valorDependientesController.text;
        userData['importanciaDependientesRetiro'] = _importanciaDependientesController.text;
        userData['valorOtrosRetiro'] = _valorOtrosController.text;  
        userData['importanciaOtrosRetiro'] = _importanciaOtrosController.text; 

      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Objetivos de retiro actualizados'),
            content: Text('Tus objetivos de retiro han sido actualizados'),
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
                'Gastos para mi retiro',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30
                ),
              )
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20 ),
              child: const Text(
                ' Enumere de 1 al 10 las siguientes objeticos de inversión donde (10) es MUY IMPORTANTE Y  (1)  MENOS IMPORTANTE ',
                style: TextStyle(
                  color: Colors.white,
                ) ,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20 ),
              child: const Text(
                'Enumere sus gastos recurrentes anuales planedos durante su retiro y clasifique su importancia. Incluya los gastos esenciales (p. ej., el pago mensual de la hipoteca) y algunos de los no esenciales que considere más importantes para su estilo de vida deseado (p. ej., entretenimiento general). ',
                style: TextStyle(
                  color: Colors.white,
                ) ,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: const Text(
                'Vivienda',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),
              ),
            ),
             Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: TextField(
                controller: _valorViviendaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Valor de la meta',
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
                controller: _importanciaViviendaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Nivel de importancia',
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
                'Viajes',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),
              ),
            ),
             Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: TextField(
                controller: _valorViajesController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Valor de la meta',
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
                controller: _importanciaViajesController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Nivel de importancia',
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
                'Salud',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),
              ),
            ),
             Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: TextField(
                controller: _valorSaludController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Valor de la meta',
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
                controller: _importanciaSaludController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Nivel de importancia',
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
                'Dependientes',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),
              ),
            ),
             Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: TextField(
                controller: _valorDependientesController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Valor de la meta',
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
                controller: _importanciaDependientesController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Nivel de importancia',
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
                'Otros',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),
              ),
            ),
             Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: TextField(
                controller: _valorOtrosController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Valor de la meta',
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
                controller: _importanciaOtrosController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Nivel de importancia',
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
              if (_valorViviendaController.text.isEmpty ||
                _importanciaViviendaController.text.isEmpty ||
                _valorViajesController.text.isEmpty ||
                _importanciaViajesController.text.isEmpty ||
                _valorSaludController.text.isEmpty ||
                _importanciaViviendaController.text.isEmpty ||
                _valorDependientesController.text.isEmpty ||
                _importanciaDependientesController.text.isEmpty ||
                _valorOtrosController.text.isEmpty ||
                _importanciaOtrosController.text.isEmpty
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
      saveObjetivosRetiro()
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