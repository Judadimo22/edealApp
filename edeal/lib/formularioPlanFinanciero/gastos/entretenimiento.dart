import 'dart:convert';
import 'package:edeal/formularioPlanFinanciero/controlFinanzas.dart';
import 'package:edeal/formularioPlanFinanciero/informacionPersonal.dart';
import 'package:edeal/formularioPlanFinanciero/paso2/gastos.dart';
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
    var response = await http.get(Uri.parse('https://edeal-app.onrender.com/user/$userId'));

    if (response.statusCode == 200) {
      setState(() {
        userData = jsonDecode(response.body);
      });
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  void saveGastosEntretenimiento() async {

    var response = await http.put(
      Uri.parse('https://edeal-app.onrender.com/gastosEntretenimiento/$userId'),
      body: {
        'restaurantes': _restaurantesController.text,
        'cine': _cineController.text,
        'conciertos': _conciertosController.text,
        'eventosDeportivos': _eventosDeportivosController.text,
        'salidasFiestas': _salidasFiestasController.text,
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        userData['restaurantes'] = _restaurantesController.text;
        userData['cine'] = _cineController.text;
        userData['conciertos'] = _conciertosController.text;
        userData['eventosDeportivos'] = _eventosDeportivosController.text;
        userData['salidasFiestas'] = _salidasFiestasController.text;
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Gastos de entretenimiento actualizados'),
            content: Text('Tus gastos de entretenimiento han sido actualizados'),
            actions: [
              TextButton(
                  onPressed: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>Gastos(token: widget.token)));
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
             if (_restaurantesController.text.isEmpty ||
        _cineController.text.isEmpty ||
        _conciertosController.text.isEmpty ||
        _eventosDeportivosController.text.isEmpty ||
        _salidasFiestasController.text.isEmpty 
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
      saveGastosEntretenimiento()
    }
                    
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
