import 'dart:convert';
import 'package:edeal/formularioPlanFinanciero/controlFinanzas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class Ingresos extends StatefulWidget {
  final String token;

  const Ingresos({required this.token, Key? key}) : super(key: key);

  @override
  State<Ingresos> createState() => _IngresosState();
}

class _IngresosState extends State<Ingresos> {
  late String userId;
  Map<String, dynamic> userData = {};
  final TextEditingController _salarioController = TextEditingController();
  final TextEditingController _inversionesPesosController = TextEditingController();
  final TextEditingController _inversionesDolarController = TextEditingController();
  final TextEditingController _alquilerInmobiliarioController = TextEditingController();
  final TextEditingController _dividendosController = TextEditingController();
  final TextEditingController _pensionesController = TextEditingController();
  final TextEditingController _otrosIngresosController = TextEditingController();


  double valorSalario = 0.0; 
  double valorInversionesPesos = 0.0; 
  double valorInversionesDolar = 0.0;
  double valorAlquileres = 0.0;
  double valorDividendos = 0.0;
  double valorPensiones = 0.0;
  double valorOtrosIngresos = 0.0;


  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    userId = jwtDecodedToken['_id'];
    fetchUserData();
    

    _salarioController.addListener(() {
      setState(() {
        valorSalario = double.tryParse(_salarioController.text) ?? 0.0;
      });
    });

    _inversionesPesosController.addListener(() {
      setState(() {
        valorInversionesPesos = double.tryParse(_inversionesPesosController.text) ?? 0.0;
      });
    });

    _inversionesDolarController.addListener(() {
      setState(() {
        valorInversionesDolar = double.tryParse(_inversionesDolarController.text) ?? 0.0;
      });
    });

    _alquilerInmobiliarioController.addListener(() {
      setState(() {
        valorAlquileres = double.tryParse(_alquilerInmobiliarioController.text) ?? 0.0;
      });
    });

    _dividendosController.addListener(() {
      setState(() {
        valorDividendos = double.tryParse(_dividendosController.text) ?? 0.0;
      });
    });

    _pensionesController.addListener(() { 
      setState(() {
        valorPensiones = double.tryParse(_pensionesController.text) ?? 0.0;
      });
    });

    _otrosIngresosController.addListener(() { 
      setState(() {
        valorOtrosIngresos = double.tryParse(_otrosIngresosController.text) ?? 0.0;
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

  void saveIngresos() async {
    // var newData = _newDataController.text;

    var response = await http.put(
      Uri.parse('https://edeal-app.onrender.com/ingresos/$userId'),
      body: {
        'salario': _salarioController.text,
        'inversionesPesos': _inversionesPesosController.text,
        'inversionesUsd': _inversionesDolarController.text,
        'alquileresInmobiliarios': _alquilerInmobiliarioController.text,
        'dividendos': _dividendosController.text,
        'pensiones': _pensionesController.text,
        'otrosIngresos': _otrosIngresosController.text,
        // 'totalIngresos': ({(valorSalario + valorInversionesPesos + valorInversionesDolar + valorAlquileres + valorDividendos + valorPensiones + valorOtrosIngresos).toStringAsFixed(2)})
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        userData['salario'] = _salarioController.text;
        userData['inversionesPesos'] = _inversionesPesosController.text;
        userData['inversionesUsd'] = _inversionesDolarController.text;
        userData['alquileresInmobiliarios'] = _alquilerInmobiliarioController.text;
        userData['dividendos'] = _dividendosController.text;
        userData['pensiones'] = _pensionesController.text;
        userData['otrosIngresos'] = _otrosIngresosController.text;
        // userData['totalIngresos'] = ({(valorSalario + valorInversionesPesos + valorInversionesDolar + valorAlquileres + valorDividendos + valorPensiones + valorOtrosIngresos).toStringAsFixed(2)});
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Ingresos actualizados'),
            content: Text('Tus ingresos han sido actualizados'),
            actions: [
              TextButton(
                  onPressed: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>ControlFinanzas(token: widget.token)));
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
                  'Mis ingresos',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
                  controller: _salarioController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Salario',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left:20, right: 20),
                child: TextField(
                  controller: _inversionesPesosController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Inversiones en pesos',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
                  controller: _inversionesDolarController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Inversiones en USD',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
                  controller: _alquilerInmobiliarioController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Alquileres inmobiliarios',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
                  controller: _dividendosController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Dividendos',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
                  controller: _pensionesController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Pensiones',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
                  controller: _otrosIngresosController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Otros ingresos',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Text(
                  'Total - Mis ingresos \$${(valorSalario + valorInversionesPesos + valorInversionesDolar + valorAlquileres + valorDividendos + valorPensiones + valorOtrosIngresos).toStringAsFixed(2)}',
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
                    if (_salarioController.text.isEmpty ||
        _inversionesPesosController.text.isEmpty ||
        _inversionesDolarController.text.isEmpty ||
        _alquilerInmobiliarioController.text.isEmpty ||
        _dividendosController.text.isEmpty ||
        _pensionesController.text.isEmpty ||
        _otrosIngresosController.text.isEmpty
        ) {
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
      )
    } else {
      saveIngresos()
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

