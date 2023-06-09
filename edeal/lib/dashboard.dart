import 'dart:convert';
import 'package:edeal/formularioPlanFinanciero/fuentesAdicionales.dart';
import 'package:edeal/formularioPlanFinanciero/gastos/hogar.dart';
import 'package:edeal/formularioPlanFinanciero/informacionPersonal.dart';
import 'package:edeal/formularioPlanFinanciero/paso2/ingresos.dart';
import 'package:edeal/formularioPlanFinanciero/paso3/metasFinancieras.dart';
import 'package:edeal/formularioPlanFinanciero/perfilRiesgo.dart';
import 'package:edeal/views/ahorroPage.dart';
import 'package:edeal/views/creditoScreen.dart';
import 'package:edeal/views/fincaRaizPage.dart';
import 'package:edeal/views/formularioTerminado.dart';
import 'package:edeal/views/homeScreen.dart';
import 'package:edeal/views/planeacionScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class Dashboard extends StatefulWidget {
  final String token;

  Dashboard({required this.token, Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late String userId;
  Map<String, dynamic> userData = {};
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    userId = jwtDecodedToken['_id'];
    fetchUserData();
    _pages = [
      Home(token: widget.token),
      InformacionPersonal(token: widget.token),
      AhorroScreen(token: widget.token),
      CreditoScreen(token: widget.token),
      FincaRaizScreen(token: widget.token)
    ];
  }

  void fetchUserData() async {
    var response =
        await http.get(Uri.parse('https://edeal-app.onrender.com/user/$userId'));

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

  int _selectedTab = 0;

  void _changeTab(int index) {
  Widget selectedWidget;

  setState(() {
    _selectedTab = index;

    if (_selectedTab == 1) {
      if (userData['fechaNacimiento'] == null ) {
        selectedWidget = InformacionPersonal(token: widget.token);
      } else if (userData['fechaNacimiento'] != null && userData['salario'] == null) {
        selectedWidget = Ingresos(token: widget.token);
      }
      else if(userData['fechaNacimiento'] != null && userData['salario'] != null && userData['mercado'] == null){
        selectedWidget = Hogar(token: widget.token);
      }
      else if(userData['fechaNacimiento'] != null && userData['salario'] != null && userData['mercado'] != null && userData['plazoVacaciones'] == null){
        selectedWidget = MetasFinancieras(token: widget.token);
      }
      else if(userData['fechaNacimiento'] != null && userData['salario'] != null && userData['mercado'] != null && userData['plazoVacaciones'] != null && userData['experienciaInversiones'] == null){
        selectedWidget = PerfilRiesgo(token: widget.token);
      }
      else if(userData['fechaNacimiento'] != null && userData['salario'] != null && userData['mercado'] != null && userData['plazoVacaciones'] != null && userData['experienciaInversiones'] != null && userData['desarrollarHabilidades'] == null){
        selectedWidget = FuentesAdicionales(token: widget.token);
      }
      else {
        selectedWidget = FormularioTerminado(token: widget.token);
      }

      _pages[1] = selectedWidget;
    }
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF524898),
      body: Center(
        child: _pages[_selectedTab],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
      canvasColor: Color(0xFF0C67B0), // Color de fondo personalizado
    ), 
        child: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: _changeTab,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
          BottomNavigationBarItem(
              icon: Icon(Icons.stacked_line_chart_sharp), label: "Planeación"),
          BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on), label: "Ahorro"),
          BottomNavigationBarItem(
              icon: Icon(Icons.credit_score_sharp), label: "Crédito"),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_work), label: "Inmobiliario"
          )
        ],

    ),
      )
    );
  }

  }

