import 'dart:convert';
import 'package:edeal/formularioPlanFinanciero/controlFinanzas.dart';
import 'package:edeal/formularioPlanFinanciero/informacionPersonal.dart';
import 'package:edeal/views/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class Financieros extends StatefulWidget {
  final String token;

  const Financieros({required this.token, Key? key}) : super(key: key);

  @override
  State<Financieros> createState() => _FinancierosState();
}

class _FinancierosState extends State<Financieros> {
  late String userId;
  Map<String, dynamic> userData = {};
  final TextEditingController _seguroSaludController = TextEditingController();
  final TextEditingController _seguroVidaController= TextEditingController();
  final TextEditingController _tarjetaCreditoController = TextEditingController();
  final TextEditingController _creditoLibreInversionController = TextEditingController();
  final TextEditingController _creditoUsdController = TextEditingController();



  double valorSeguroSalud= 0.0; 
  double valorSeguroVida= 0.0; 
  double valorTarjetaCredito = 0.0;
  double valorCreditoLibreInversion = 0.0;
  double valorCreditoUsd = 0.0;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    userId = jwtDecodedToken['_id'];
    fetchUserData();
    

    _seguroSaludController.addListener(() {
      setState(() {
        valorSeguroSalud = double.tryParse(_seguroSaludController.text) ?? 0.0;
      });
    });

    _seguroVidaController.addListener(() {
      setState(() {
        valorSeguroVida= double.tryParse(_seguroVidaController.text) ?? 0.0;
      });
    });

    _tarjetaCreditoController.addListener(() {
      setState(() {
        valorTarjetaCredito = double.tryParse(_tarjetaCreditoController.text) ?? 0.0;
      });
    });

    _creditoLibreInversionController.addListener(() {
      setState(() {
        valorCreditoLibreInversion = double.tryParse(_creditoLibreInversionController.text) ?? 0.0;
      });
    });

    _creditoUsdController.addListener(() { 
      setState(() {
        valorCreditoUsd = double.tryParse(_creditoUsdController.text) ?? 0.0;
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
                  'Mis gastos financieros',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
                  controller: _seguroSaludController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Seguro de salud',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left:20, right: 20),
                child: TextField(
                  controller: _seguroVidaController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Seguro de vida',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
                  controller: _tarjetaCreditoController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Tarjeta de crédito',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
                  controller: _creditoLibreInversionController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Crédito de libre inversión',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
                  controller: _creditoUsdController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Crédito en USD',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Text(
                  'Total - Mis gastos financieros \$${(valorSeguroSalud + valorSeguroVida + valorTarjetaCredito + valorCreditoLibreInversion + valorCreditoUsd).toStringAsFixed(2)}',
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