import 'dart:convert';
import 'package:edeal/formularioPlanFinanciero/controlFinanzas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class Ahorros extends StatefulWidget {
  final String token;

  const Ahorros({required this.token, Key? key}) : super(key: key);

  @override
  State<Ahorros> createState() => _AhorrosState();
}

class _AhorrosState extends State<Ahorros> {
  late String userId;
  Map<String, dynamic> userData = {};
  final TextEditingController _aportesEmergenciaController = TextEditingController();
  final TextEditingController _aportesAhorroController = TextEditingController();
  final TextEditingController _aportesRetiroController = TextEditingController();
  final TextEditingController _inversionesController = TextEditingController();
  final TextEditingController _otrosAhorrosController = TextEditingController();


  double valorAportesEmergencia = 0.0; 
  double valorAportesAhorro = 0.0; 
  double valorAportesRetiro = 0.0;
  double valorInversiones = 0.0;
  double valorOtrosAhorros = 0.0;


  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    userId = jwtDecodedToken['_id'];
    fetchUserData();
    

    _aportesEmergenciaController.addListener(() {
      setState(() {
        valorAportesEmergencia = double.tryParse(_aportesEmergenciaController.text) ?? 0.0;
      });
    });

    _aportesAhorroController.addListener(() {
      setState(() {
        valorAportesAhorro = double.tryParse(_aportesAhorroController.text) ?? 0.0;
      });
    });

    _aportesRetiroController.addListener(() {
      setState(() {
        valorAportesRetiro = double.tryParse(_aportesRetiroController.text) ?? 0.0;
      });
    });

    _inversionesController.addListener(() {
      setState(() {
        valorInversiones = double.tryParse(_inversionesController.text) ?? 0.0;
      });
    });

    _otrosAhorrosController.addListener(() { 
      setState(() {
        valorOtrosAhorros = double.tryParse(_otrosAhorrosController.text) ?? 0.0;
      });
    });




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
        backgroundColor: const Color(0XFF524898),
      ),
      backgroundColor: const Color(0XFF524898),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 40),
                child: const Text(
                  'Mis ahorros',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
                  controller: _aportesEmergenciaController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Aportes a mi fondo de emergencia',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left:20, right: 20),
                child: TextField(
                  controller: _aportesAhorroController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Aportes a mi fondo de ahorro',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
                  controller: _aportesRetiroController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Aportes a mi fondo e retiro',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
                  controller: _inversionesController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Inversiones',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
                  controller: _otrosAhorrosController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Otros ahorros',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Text(
                  'Total - Mis ingresos \$${(valorAportesEmergencia + valorAportesAhorro + valorAportesRetiro + valorInversiones + valorOtrosAhorros).toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30, bottom: 30, left: 20, right: 20),
                child: ElevatedButton(
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ControlFinanzas(token: widget.token)),
                    ),
                  },
                  child: const Text('Continuar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

