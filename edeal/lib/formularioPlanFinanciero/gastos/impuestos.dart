import 'dart:convert';
import 'package:edeal/formularioPlanFinanciero/controlFinanzas.dart';
import 'package:edeal/formularioPlanFinanciero/informacionPersonal.dart';
import 'package:edeal/formularioPlanFinanciero/paso2/gastos.dart';
import 'package:edeal/views/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class Impuestos extends StatefulWidget {
  final String token;

  const Impuestos({required this.token, Key? key}) : super(key: key);

  @override
  State<Impuestos> createState() => _ImpuestosState();
}

class _ImpuestosState extends State<Impuestos> {
  late String userId;
  Map<String, dynamic> userData = {};
  final TextEditingController _rentaController = TextEditingController();
  final TextEditingController _predialController= TextEditingController();
  final TextEditingController _vehiculosController = TextEditingController();




  double valorRenta= 0.0; 
  double valorPredial= 0.0; 
  double valorVehiculos = 0.0;


  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    userId = jwtDecodedToken['_id'];
    fetchUserData();
    

    _rentaController.addListener(() {
      setState(() {
        valorRenta = double.tryParse(_rentaController.text) ?? 0.0;
      });
    });

    _predialController.addListener(() {
      setState(() {
        valorPredial= double.tryParse(_predialController.text) ?? 0.0;
      });
    });

    _vehiculosController.addListener(() {
      setState(() {
        valorVehiculos = double.tryParse(_vehiculosController.text) ?? 0.0;
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

  void saveGastosImpuestos() async {
    // var newData = _newDataController.text;

    var response = await http.put(
      Uri.parse('http://192.168.1.108:3001/gastosImpuestos/$userId'),
      body: {
        'renta': _rentaController.text,
        'predial': _predialController.text,
        'impuestoVehiculos': _vehiculosController.text,
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        userData['renta'] = _rentaController.text;
        userData['predial'] = _predialController.text;
        userData['impuestoVehiculos'] = _vehiculosController.text;
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Gastos en impuestos actualizados'),
            content: Text('Tus gastos en impuestos han sido actualizados'),
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
                  'Mis gastos en impuestos',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
                  controller: _rentaController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Renta',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left:20, right: 20),
                child: TextField(
                  controller: _predialController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Predial',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
                  controller: _vehiculosController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Vehículos',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Text(
                  'Total - Mis gastos en impuestos \$${(valorRenta + valorPredial + valorVehiculos).toStringAsFixed(2)}',
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
                    saveGastosImpuestos()
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