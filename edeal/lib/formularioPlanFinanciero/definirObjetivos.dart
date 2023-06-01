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
    var response = await http.get(Uri.parse('https://edeal-app.onrender.com/user/$userId'));

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
     double porcentajeAvance = 60;
    return Scaffold(
      backgroundColor: Color(0XFF524898),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 70, bottom: 40),
          child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 40),
              child:LinearProgressIndicator(
          value: porcentajeAvance / 100, 
        ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child:Text('Has completado el ${porcentajeAvance.toStringAsFixed(1)}% del formulario'),
            ),
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
          style: userData['importanciaOtros'] != null
            ? ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            )
            : null,
          child: Text('Mis metas financieras')),
          ElevatedButton(
          onPressed: () => {
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Salud(token: widget.token)),
        ),
          }, 
          style: userData['cuentaConPlanSalud'] != null
            ? ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            )
            : null,
          child: Text('Salud')),
          ElevatedButton(
          onPressed: () => {
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Educacion(token: widget.token,),
        )),
          }, 
            style: userData['tipoInstitucionEducativa'] != null
            ? ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            )
            : null,
          child: Text('Educacion')),
          ElevatedButton(
          onPressed: () => {
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GastosRetiro(token: widget.token,),
        )),
          }, 
            style: userData['valorViviendaRetiro'] != null
            ? ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            )
            : null,
          child: Text('Gastos para mi retiro')),
        Container(
          margin: const EdgeInsets.only(top: 40),
          child: ElevatedButton(
          onPressed: () => {
            if(userData['plazoVacaciones'] == null || userData['cuentaConPlanSalud'] == null || userData['numeroHijos'] == null || userData['valorViviendaRetiro'] == null){
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
          MaterialPageRoute(builder: (context) => PerfilRiesgo(token: widget.token,),
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
