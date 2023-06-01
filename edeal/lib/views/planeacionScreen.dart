import 'dart:convert';
import 'package:edeal/formularioPlanFinanciero/controlFinanzas.dart';
import 'package:edeal/formularioPlanFinanciero/definirObjetivos.dart';
import 'package:edeal/formularioPlanFinanciero/fuentesAdicionales.dart';
import 'package:edeal/formularioPlanFinanciero/informacionPersonal.dart';
import 'package:edeal/formularioPlanFinanciero/paso2/gastos.dart';
import 'package:edeal/formularioPlanFinanciero/paso3/metasFinancieras.dart';
import 'package:edeal/formularioPlanFinanciero/perfilRiesgo.dart';
import 'package:edeal/views/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class PlaneacionScreen extends StatefulWidget {
  final String token;

  PlaneacionScreen({required this.token, Key? key}) : super(key: key);

  @override
  State<PlaneacionScreen> createState() => _PlaneacionScreenState();
}

class _PlaneacionScreenState extends State<PlaneacionScreen> {
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
    if(userData['estadoCivilCliente1'] != null && userData['salario'] != null && userData['inversiones'] != null && userData['arriendo'] != null && userData['cuotaCarro'] != null && userData['cine'] != null && userData['seguroSalud'] != null && userData['hoteles'] != null && userData['predial'] != null && userData['tipoDeudaGastosCredito'] != null && userData['plazoAutomovil'] != null && userData['cuentaConPlanSalud'] != null && userData['nombreEstudiante1'] != null && userData['valorViviendaRetiro'] != null && userData['experienciaInversiones'] != null && userData['ahorrarMas'] != null){
      return Scaffold(
       backgroundColor: const Color(0XFF524898),
        body: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 50),
            child: Text(
              'Gracias por completar el formulario de plan financiero, estamos revisando tus datos',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30
              ),
              ),
          ),
        ),
      );
    }
    else {
      return Scaffold(
      backgroundColor: Color(0XFF524898),
      body: Center(
        child: ElevatedButton(
          onPressed: () => {
          if(userData['nombreDependiente'] == null && userData['fechaNacimientoDependiente'] == null){
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InformacionPersonal(token: widget.token)),
        ), 
          }
        else if(userData['cine'] == null || userData['predial'] == null && userData['nombreDependiente'] != null){
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ControlFinanzas(token: widget.token)),
          )
        }
        else if(userData['cine'] != null && userData['hoteles'] != null && userData['arriendo'] != null && userData['cuotaCarro'] != null && userData['seguroSalud'] != null && userData['predial'] != null && userData['plazoAutomovil'] == null || userData['tipoPlanSalud'] == null || userData['nombreEstudiante1'] == null ||userData['valorViviendaRetiro'] == null  ){
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DefinirObjetivo(token: widget.token)),
          )
        }
        else if(userData['cine'] != null && userData['hoteles'] != null && userData['arriendo'] != null && userData['cuotaCarro'] != null && userData['seguroSalud'] != null && userData['predial'] != null && userData['plazoAutomovil'] != null && userData['tipoPlanSalud'] != null && userData['nombreEstudiante1'] != null && userData['valorViviendaRetiro'] != null && userData['experienciaInversiones'] == null){
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PerfilRiesgo(token: widget.token)),
          )
        }
        else if(userData['cine'] != null && userData['hoteles'] != null && userData['arriendo'] != null && userData['cuotaCarro'] != null && userData['seguroSalud'] != null && userData['predial'] != null && userData['plazoAutomovil'] != null && userData['tipoPlanSalud'] != null && userData['nombreEstudiante1'] != null && userData['valorViviendaRetiro'] != null && userData['experienciaInversiones'] != null && userData['planHerencia'] == null){
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FuentesAdicionales(token: widget.token)),
          )
        }
          }, 
          child: Text('Diligenciar formulario'))
      ),

    );
    }
  }

  }
