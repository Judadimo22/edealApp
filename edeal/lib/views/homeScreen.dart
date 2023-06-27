import 'dart:convert';
import 'package:edeal/views/ahorroPage.dart';
import 'package:edeal/views/contactPage.dart';
import 'package:edeal/views/creditoScreen.dart';
import 'package:edeal/views/fincaRaizPage.dart';
import 'package:edeal/views/homeScreen.dart';
import 'package:edeal/views/planeacionScreen.dart';
import 'package:edeal/views/questionsPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class Home extends StatefulWidget {
  final String token;

  Home({required this.token, Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
    return Scaffold(
      backgroundColor: Color(0XFF524898),
      body:Container(
    margin: EdgeInsets.only(top: 120),
    child: Column(children: [
      Container(
        margin: EdgeInsets.only(bottom:30),
      width: 150,
      child:Image.asset('assets/logo_blanco.png'), 
      ),
      Container(
        margin: EdgeInsets.only(bottom: 20),
        child:Text(
          'Hola ${userData['name']}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20
          ),
          ),
      ),
Container(
  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
  
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 2),
          child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
            MaterialStateProperty.all<Color>(Color(0XFFE8E112)),
            ),
            onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PlaneacionScreen(token: widget.token)),
            )
            },
            child: Text(
              'Planeación',
              style:  TextStyle(
                fontSize: 12
              ),
              ),
          ),
        ),
      ),
      Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 2),
          child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
            MaterialStateProperty.all<Color>(Color(0XFFE8E112)),
            ),
            onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AhorroScreen(token: widget.token)),
            )
            },
            child: Text('Ahorro'),
          ),
        ),
      ),
      Expanded(
        child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2),
          child: ElevatedButton(
            style: ButtonStyle(
            backgroundColor:
            MaterialStateProperty.all<Color>(Color(0XFFE8E112)),
            ),
            onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreditoScreen(token: widget.token)),
            )
            },
            child: Text('Crédito'),
          ),
        ),
      ),
            Expanded(
        child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2),
          child: ElevatedButton(
            style: ButtonStyle(
            backgroundColor:
            MaterialStateProperty.all<Color>(Color(0XFFE8E112)),
            ),
            onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FincaRaizScreen(token: widget.token)),
            )
            },
            child: Text(
              'Finca Raíz',
              style: TextStyle(
                fontSize: 13
              ),
              ),
          ),
        ),
      ),
    ],
  ),
),
Container(
  child: Row(
    children: [
      Expanded(
        child: InkWell(
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ContactScreen(token: widget.token)),
            )
            }, 
          child: Icon(
          Icons.headphones,
          color: Colors.white,
          size: 25,
          
          ),
        ),
      ),
      Expanded(
        child: InkWell(
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QuestionsScreen(token: widget.token)),
            )
            }, 
          child:Icon(
          Icons.question_mark,
          color: Colors.white,
          size: 25,
          ), 
        )
      ),
    ],
  ),
),

    ]),
    ),

    );
  }

  }
