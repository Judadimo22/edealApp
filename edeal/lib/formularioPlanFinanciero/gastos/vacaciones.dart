import 'dart:convert';
import 'package:edeal/formularioPlanFinanciero/controlFinanzas.dart';
import 'package:edeal/formularioPlanFinanciero/informacionPersonal.dart';
import 'package:edeal/formularioPlanFinanciero/paso2/gastos.dart';
import 'package:edeal/views/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class Vacaciones extends StatefulWidget {
  final String token;

  const Vacaciones({required this.token, Key? key}) : super(key: key);

  @override
  State<Vacaciones> createState() => _VacacionesState();
}

class _VacacionesState extends State<Vacaciones> {
  late String userId;
  Map<String, dynamic> userData = {};
  final TextEditingController _tiquetesAereosController = TextEditingController();
  final TextEditingController _hotelesController= TextEditingController();
  final TextEditingController _gastosViajeController = TextEditingController();




  double valorTiquetesAereos= 0.0; 
  double valorHoteles= 0.0; 
  double valorGastosViaje = 0.0;


  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    userId = jwtDecodedToken['_id'];
    fetchUserData();
    

    _tiquetesAereosController.addListener(() {
      setState(() {
        valorTiquetesAereos = double.tryParse(_tiquetesAereosController.text) ?? 0.0;
      });
    });

    _hotelesController.addListener(() {
      setState(() {
        valorHoteles= double.tryParse(_hotelesController.text) ?? 0.0;
      });
    });

    _gastosViajeController.addListener(() {
      setState(() {
        valorGastosViaje = double.tryParse(_gastosViajeController.text) ?? 0.0;
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

  void saveGastosVacaciones() async {
    // var newData = _newDataController.text;

    var response = await http.put(
      Uri.parse('http://192.168.1.108:3001/gastosVacaciones/$userId'),
      body: {
        'tiquetesAereos': _tiquetesAereosController.text,
        'hoteles': _hotelesController.text,
        'gastosViaje': _gastosViajeController.text,
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        userData['tiquetesAereos'] = _tiquetesAereosController.text;
        userData['hoteles'] = _hotelesController.text;
        userData['gastosViaje'] = _gastosViajeController.text;
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Gastos de vacaciones actualizados'),
            content: Text('Tus gastos de vacaciones han sido actualizados'),
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
                  'Mis gastos en vacaciones',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
                  controller: _tiquetesAereosController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Tiquetes aéreos',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left:20, right: 20),
                child: TextField(
                  controller: _hotelesController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Hoteles',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
                  controller: _gastosViajeController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Gastos de viaje',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Text(
                  'Total - Mis gastos en vacaciones \$${(valorTiquetesAereos + valorHoteles + valorGastosViaje).toStringAsFixed(2)}',
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
                    saveGastosVacaciones()
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
