import 'dart:convert';
import 'package:edeal/formularioPlanFinanciero/gastos/creditos.dart';
import 'package:edeal/formularioPlanFinanciero/gastos/entretenimiento.dart';
import 'package:edeal/formularioPlanFinanciero/gastos/financieros.dart';
import 'package:edeal/formularioPlanFinanciero/gastos/hogar.dart';
import 'package:edeal/formularioPlanFinanciero/gastos/impuestos.dart';
import 'package:edeal/formularioPlanFinanciero/gastos/transporte.dart';
import 'package:edeal/formularioPlanFinanciero/gastos/vacaciones.dart';
import 'package:edeal/formularioPlanFinanciero/informacionPersonal.dart';
import 'package:edeal/formularioPlanFinanciero/paso2/ahorros.dart';
import 'package:edeal/formularioPlanFinanciero/paso2/gastos.dart';
import 'package:edeal/formularioPlanFinanciero/paso2/ingresos.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class Gastos extends StatefulWidget {
  final String token;

  Gastos({required this.token, Key? key}) : super(key: key);

  @override
  State<Gastos> createState() => _GastosState();
}

class _GastosState extends State<Gastos> {
  late String userId;
  Map<String, dynamic> userData = {};


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

      var code = userData['code'];
      print(code);
    } else {
      print('Error: ${response.statusCode}');
    }
  }






  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF524898) ,
      ) ,
      backgroundColor: Color(0XFF524898),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 200),
          child: Column(
          children: [
          Container(
              margin: const EdgeInsets.only(top: 20, bottom: 40),
              child: const Text(
                'Mis gastos',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25
                ),
              )
            ),
          ElevatedButton(
          onPressed: () => {
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Hogar(token: widget.token)),
        ),
          }, 
          child: Text('Hogar')),
          ElevatedButton(
          onPressed: () => {
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Transporte(token: widget.token)),
        ),
          }, 
          child: Text('Transporte')),
          ElevatedButton(
          onPressed: () => {
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Entretenimiento(token: widget.token,),
        )),
          }, 
          child: Text('Entretenimiento y ocio')),
          ElevatedButton(
          onPressed: () => {
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Financieros(token: widget.token,),
        )),
          }, 
          child: Text('Financieros')),
          ElevatedButton(
          onPressed: () => {
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Vacaciones(token: widget.token,),
        )),
          }, 
          child: Text('Vacaciones')),
          ElevatedButton(
          onPressed: () => {
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Impuestos(token: widget.token,),
        )),
          }, 
          child: Text('Impuestos')),
          ElevatedButton(
          onPressed: () => {
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Creditos(token: widget.token,),
        )),
          }, 
          child: Text('Mis créditos')),
          ],
        ),
        )
      ),

    );
  }

  }