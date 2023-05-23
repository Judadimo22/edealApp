import 'dart:convert';
import 'package:edeal/formularioPlanFinanciero/controlFinanzas.dart';
import 'package:edeal/formularioPlanFinanciero/informacionPersonal.dart';
import 'package:edeal/views/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class Entretenimiento extends StatefulWidget {
  final String token;

  const Entretenimiento({required this.token, Key? key}) : super(key: key);

  @override
  State<Entretenimiento> createState() => _EntretenimientoState();
}

class _EntretenimientoState extends State<Entretenimiento> {
  late String userId;
  Map<String, dynamic> userData = {};
  final TextEditingController _restaurantesController = TextEditingController();
  final TextEditingController _cineController= TextEditingController();
  final TextEditingController _conciertosController = TextEditingController();
  final TextEditingController _eventosDeportivosController = TextEditingController();
  final TextEditingController _salidasFiestasController = TextEditingController();



  double valorRestaurantes= 0.0; 
  double valorCine = 0.0; 
  double valorConciertos = 0.0;
  double valorEventosDeportivos = 0.0;
  double valorSalidasFiestas = 0.0;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    userId = jwtDecodedToken['_id'];
    fetchUserData();
    

    _restaurantesController.addListener(() {
      setState(() {
        valorRestaurantes = double.tryParse(_restaurantesController.text) ?? 0.0;
      });
    });

    _cineController.addListener(() {
      setState(() {
        valorCine = double.tryParse(_cineController.text) ?? 0.0;
      });
    });

    _conciertosController.addListener(() {
      setState(() {
        valorConciertos = double.tryParse(_conciertosController.text) ?? 0.0;
      });
    });

    _eventosDeportivosController.addListener(() {
      setState(() {
        valorEventosDeportivos = double.tryParse(_eventosDeportivosController.text) ?? 0.0;
      });
    });

    _salidasFiestasController.addListener(() { 
      setState(() {
        valorSalidasFiestas = double.tryParse(_salidasFiestasController.text) ?? 0.0;
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
                  'Mis gastos en entretenimiento',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
                  controller: _restaurantesController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Restaurantes',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left:20, right: 20),
                child: TextField(
                  controller: _cineController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Cine',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
                  controller: _conciertosController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Conciertos',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
                  controller: _eventosDeportivosController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Eventos deportivos',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
                  controller: _salidasFiestasController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Salidas a fiestas',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Text(
                  'Total - Mis gastos en Entretenimiento \$${(valorRestaurantes + valorCine + valorConciertos + valorEventosDeportivos + valorSalidasFiestas).toStringAsFixed(2)}',
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
