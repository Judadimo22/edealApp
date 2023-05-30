import 'dart:convert';
import 'package:edeal/formularioPlanFinanciero/informacionPersonal.dart';
import 'package:edeal/formularioPlanFinanciero/paso2/ahorros.dart';
import 'package:edeal/formularioPlanFinanciero/paso2/gastos.dart';
import 'package:edeal/formularioPlanFinanciero/paso2/ingresos.dart';
import 'package:edeal/formularioPlanFinanciero/paso3/educacion.dart';
import 'package:edeal/formularioPlanFinanciero/paso3/gastosRetiro.dart';
import 'package:edeal/formularioPlanFinanciero/paso3/metasFinancieras.dart';
import 'package:edeal/formularioPlanFinanciero/paso3/salud.dart';
import 'package:edeal/formularioPlanFinanciero/perfilRiesgo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class DefinirObjetivo extends StatefulWidget {
  final String token;

  DefinirObjetivo({required this.token, Key? key}) : super(key: key);

  @override
  State<DefinirObjetivo> createState() => _DefinirObjetivoState();
}

class _DefinirObjetivoState extends State<DefinirObjetivo> {
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
              margin: const EdgeInsets.only(top: 20, bottom: 40, right: 20, left: 20),
              child: const Text(
                'Paso 3: Definir mis objetivos de largo plazo ',
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
          MaterialPageRoute(builder: (context) => MetasFinancieras(token: widget.token)),
        ),
          }, 
          child: Text('Mis metas financieras')),
          if(userData['importanciaOtros'] != null && userData['importanciaVacaciones'] != null && userData['plazoAutomovil'] != null)
          const Text('Ya has terminado el formulario de metas financieras'),
          ElevatedButton(
          onPressed: () => {
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Salud(token: widget.token)),
        ),
          }, 
          child: Text('Salud')),
          if(userData['cuentaConPlanSalud'] != null )
          const Text('Ya has terminado el formulario de objetivos de salud'),
          ElevatedButton(
          onPressed: () => {
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Educacion(token: widget.token,),
        )),
          }, 
          child: Text('Educacion')),
          if(userData['tipoInstitucionEducativa'] != null )
          const Text('Ya has terminado el formulario de objetivos de educacion'),
          ElevatedButton(
          onPressed: () => {
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GastosRetiro(token: widget.token,),
        )),
          }, 
          child: Text('Gastos para mi retiro')),
          if(userData['valorViviendaRetiro'] != null )
          const Text('Ya has terminado el formulario de objetivos de retiro'),
        Container(
          margin: const EdgeInsets.only(top: 40),
          child: ElevatedButton(
          onPressed: () => {
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PerfilRiesgo(token: widget.token,),
        )),
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
