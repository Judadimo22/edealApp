import 'dart:convert';
import 'package:edeal/formularioPlanFinanciero/controlFinanzas.dart';
import 'package:edeal/formularioPlanFinanciero/informacionPersonal.dart';
import 'package:edeal/formularioPlanFinanciero/paso2/gastos.dart';
import 'package:edeal/views/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class Transporte extends StatefulWidget {
  final String token;

  const Transporte({required this.token, Key? key}) : super(key: key);

  @override
  State<Transporte> createState() => _TransporteState();
}

class _TransporteState extends State<Transporte> {
  late String userId;
  Map<String, dynamic> userData = {};
  final TextEditingController _cuotaCarroController = TextEditingController();
  final TextEditingController _seguroCarroController = TextEditingController();
  final TextEditingController _gasolinaController = TextEditingController();
  final TextEditingController _transportePublicoController = TextEditingController();
  final TextEditingController _mantenimientoCarroController = TextEditingController();



  double valorCuotaCarro= 0.0; 
  double valorSeguroCarro = 0.0; 
  double valorGasolina = 0.0;
  double valorTransportePublico = 0.0;
  double valorMantenimientoCarro = 0.0;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    userId = jwtDecodedToken['_id'];
    fetchUserData();
    

    _cuotaCarroController.addListener(() {
      setState(() {
        valorCuotaCarro = double.tryParse(_cuotaCarroController.text) ?? 0.0;
      });
    });

    _seguroCarroController.addListener(() {
      setState(() {
        valorSeguroCarro = double.tryParse(_seguroCarroController.text) ?? 0.0;
      });
    });

    _gasolinaController.addListener(() {
      setState(() {
        valorGasolina = double.tryParse(_gasolinaController.text) ?? 0.0;
      });
    });

    _transportePublicoController.addListener(() {
      setState(() {
        valorTransportePublico = double.tryParse(_transportePublicoController.text) ?? 0.0;
      });
    });

    _mantenimientoCarroController.addListener(() { 
      setState(() {
        valorMantenimientoCarro = double.tryParse(_mantenimientoCarroController.text) ?? 0.0;
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

  void saveGastosTransporte() async {

    var response = await http.put(
      Uri.parse('https://edeal-app.onrender.com/gastosTransporte/$userId'),
      body: {
        'cuotaCarro': _cuotaCarroController.text,
        'seguroCarro': _seguroCarroController.text,
        'gasolina': _gasolinaController.text,
        'transportePublico': _transportePublicoController.text,
        'mantenimientoCarro': _mantenimientoCarroController.text,
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        userData['cuotaCarro'] = _cuotaCarroController.text;
        userData['seguroCarro'] = _seguroCarroController.text;
        userData['gasolina'] = _gasolinaController.text;
        userData['transportePublico'] = _transportePublicoController.text;
        userData['mantenimientoCarro'] = _mantenimientoCarroController.text;
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Gastos de transporte actualizados'),
            content: Text('Tus gastos de transporte han sido actualizados'),
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
                  'Mis gastos en transporte',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
                  controller: _cuotaCarroController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Cuota del carro',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left:20, right: 20),
                child: TextField(
                  controller: _seguroCarroController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Seguro del carro',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
                  controller: _gasolinaController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Gasolina',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
                  controller: _transportePublicoController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Transporte público',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
                  controller: _mantenimientoCarroController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Mantenimiento del carro',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Text(
                  'Total - Mis gastos en transporte \$${(valorCuotaCarro + valorSeguroCarro + valorGasolina + valorTransportePublico + valorMantenimientoCarro).toStringAsFixed(2)}',
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
           if (_cuotaCarroController.text.isEmpty ||
        _seguroCarroController.text.isEmpty ||
        _gasolinaController.text.isEmpty ||
        _transportePublicoController.text.isEmpty ||
        _mantenimientoCarroController.text.isEmpty
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
      saveGastosTransporte()
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
