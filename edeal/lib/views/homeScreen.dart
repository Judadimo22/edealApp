import 'dart:convert';
import 'package:edeal/views/ahorroPage.dart';
import 'package:edeal/views/creditoScreen.dart';
import 'package:edeal/views/homeScreen.dart';
import 'package:edeal/views/planeacionScreen.dart';
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
      body:Container(
    margin: EdgeInsets.only(top: 120),
    child: Column(children: [
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
    Text(
      '600.00 COP',
      style: TextStyle(
        color: Colors.white,
        fontSize: 40
      ),
      ),
    // Container(
    //   margin: EdgeInsets.only(top: 20),
    //   child:Row(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       Container(
    //         decoration: BoxDecoration(
    //           color:Color(0XFFE8E112),
    //           borderRadius: BorderRadius.circular(10)
    //         ),
    //         padding: EdgeInsets.only(top:10, bottom: 10, left: 20, right: 20 ),
    //         margin: EdgeInsets.only(left: 10, right: 10),
    //         child:Text(
    //           'RECARGAR',
    //           style: TextStyle(
    //           color: Color(0XFF524898)
    //           ),
    //           ),
    //       ),
    //       Container(
    //         decoration: BoxDecoration(
    //           color:Colors.white,
    //           borderRadius: BorderRadius.circular(10)
    //         ),
    //         padding: EdgeInsets.only(top:10, bottom: 10, left: 20, right: 20 ),
    //         margin: EdgeInsets.only(left: 10, right: 10),
    //         child:Text(
    //           'ENVIAR',
    //           style: TextStyle(
    //             color: Color(0XFF524898)
    //           ),
    //           ),
    //       ),
    //   ],),
    // ),
Container(
  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
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
            child: Text('Planeación'),
          ),
        ),
      ),
      Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
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
        margin: EdgeInsets.symmetric(horizontal: 10),
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
    ],
  ),
),

    ]),
    ),

    );
  }

  }
