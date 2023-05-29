import 'dart:convert';
import 'package:edeal/formularioPlanFinanciero/definirObjetivos.dart';
import 'package:edeal/formularioPlanFinanciero/informacionPersonal.dart';
import 'package:edeal/formularioPlanFinanciero/paso2/ahorros.dart';
import 'package:edeal/formularioPlanFinanciero/paso2/gastos.dart';
import 'package:edeal/formularioPlanFinanciero/paso2/ingresos.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class ControlFinanzas extends StatefulWidget {
  final String token;

  ControlFinanzas({required this.token, Key? key}) : super(key: key);

  @override
  State<ControlFinanzas> createState() => _ControlFinanzasState();
}

class _ControlFinanzasState extends State<ControlFinanzas> {
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
      backgroundColor: Color(0XFF524898),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 200),
          child: Column(
          children: [
          Container(
              margin: const EdgeInsets.only(top: 20, bottom: 40),
              child: const Text(
                'Paso 2: Control de mis finanzas',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25
                ),
              )
            ),
                    Container(
              margin: const EdgeInsets.only(top: 20, bottom: 40, left: 20, right: 20),
              child: const Text(
                'Por favor llena los formularios de ingresos, ahorros y gastos',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),
              )
            ),
          ElevatedButton(
          onPressed: () => {
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Ingresos(token: widget.token)),
        ),
          }, 
          child: Text('Ingresos')),
         if(userData['salario'] != null) 
         Text('Ya has completado el formulario de Ingresos'),
          ElevatedButton(
          onPressed: () => {
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Ahorros(token: widget.token)),
        ),
          }, 
          child: Text('Ahorros')),
         if(userData['aportesRetiro'] != null)
         Text('Ya has completado el formulario de Ahorros'),
          ElevatedButton(
          onPressed: () => {
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Gastos(token: widget.token,),
        )),
          }, 
          child: Text('Gastos')),
         if(userData['creditoHipotecario'] != null && userData['cuotaCarro'] != null && userData['cine'] != null && userData['seguroSalud'] != null && userData['hoteles'] != null && userData['predial'] != null && userData['tipoDeudaGastosCredito'] != null)
         Text('Ya has completado el formulario de Gastos'),
        Container(
          margin: const EdgeInsets.only(top: 40),
          child: ElevatedButton(
          onPressed: () => {
      if (userData['salario'] == null || userData['creditoHipotecario'] == null || userData['cuotaCarro'] == null || userData['cine'] == null || userData['seguroSalud'] == null || userData['hoteles'] == null || userData['predial'] == null || userData['tipoDeudaGastosCredito'] == null || userData['inversiones'] == null) {
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
      }
        else {
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DefinirObjetivo(token: widget.token,),
        )),
            }
          }, 
          child: Text('Continuar')),
        )
          ],
        ),
        )
      ),

    );
  }

  }
