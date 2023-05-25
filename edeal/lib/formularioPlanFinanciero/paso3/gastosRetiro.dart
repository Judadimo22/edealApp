import 'dart:convert';
import 'package:edeal/formularioPlanFinanciero/controlFinanzas.dart';
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


  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    userId = jwtDecodedToken['_id'];
    fetchUserData();
  }

  void fetchUserData() async {
    var response = await http.get(Uri.parse('http://192.168.1.108:3001/user/$userId'));

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
                keyboardType: TextInputType.text,
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
                keyboardType: TextInputType.text,
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
                keyboardType: TextInputType.text,
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
                keyboardType: TextInputType.text,
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
                keyboardType: TextInputType.text,
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
                keyboardType: TextInputType.text,
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
                keyboardType: TextInputType.text,
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
                keyboardType: TextInputType.text,
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
                keyboardType: TextInputType.text,
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
                keyboardType: TextInputType.text,
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