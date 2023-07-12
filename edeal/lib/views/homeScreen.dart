import 'dart:convert';
import 'package:edeal/formularioPlanFinanciero/informacionPersonal.dart';
import 'package:edeal/views/ahorroPage.dart';
import 'package:edeal/views/contactPage.dart';
import 'package:edeal/views/creditoScreen.dart';
import 'package:edeal/views/fincaRaizPage.dart';
import 'package:edeal/views/questionsPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  final String token;

  const Home({required this.token, Key? key}) : super(key: key);

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
      backgroundColor: Colors.white,
      body:Container(
    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.050),
    child: Column(children: [
                  Center(
                    child: Container(
                    margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.000, top: MediaQuery.of(context).size.height * 0.030),
                    width: 200,
                    child:Image.asset('assets/logoEdealAzul.png'), 
                  ),
                  ),
                Center(
                  child: Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.000, left: MediaQuery.of(context).size.height * 0.045, right: MediaQuery.of(context).size.height * 0.045, ),
                  child: Text(
                              'Bienvenido ${userData['name']}', 
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF0C67B0),
                                fontSize: MediaQuery.of(context).size.height * 0.025,
                                fontWeight: FontWeight.w600,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
                ),
                ),
Container(
  margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.010, vertical: MediaQuery.of(context).size.height * 0.030),
  
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
        GestureDetector(
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InformacionPersonal(token: widget.token)),
            )
            },
          child: Container(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.010, right: MediaQuery.of(context).size.height * 0.010, top:MediaQuery.of(context).size.height * 0.015, bottom: MediaQuery.of(context).size.height * 0.015 ),
          margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.040, right: MediaQuery.of(context).size.height * 0.040, bottom: MediaQuery.of(context).size.height * 0.010 ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
        color: Colors.grey,
      ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left:MediaQuery.of(context).size.height * 0.00, right: MediaQuery.of(context).size.height * 0.1  ),
                child: CircleAvatar(
                  child: Icon(Icons.access_time_sharp),
                ),
              ),
              Container(
                padding: EdgeInsets.all(1),
                margin: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.height * 0.010 ), 
                child: Text('Planeación'),
              )
            ],
          ),
        ),
        ),
        GestureDetector(
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AhorroScreen(token: widget.token)),
            )
            },
          child: Container(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.010, right: MediaQuery.of(context).size.height * 0.010, top:MediaQuery.of(context).size.height * 0.015, bottom: MediaQuery.of(context).size.height * 0.015 ),
          margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.040, right: MediaQuery.of(context).size.height * 0.040, bottom: MediaQuery.of(context).size.height * 0.010),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
        color: Colors.grey,
      ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left:MediaQuery.of(context).size.height * 0.00, right: MediaQuery.of(context).size.height * 0.1  ),
                child: CircleAvatar(
                  child: Icon(Icons.money),
                ),
              ),
              Container(
                padding: EdgeInsets.all(1),
                margin: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.height * 0.010 ), 
                child: Text('Ahorro        '),
              )
            ],
          ),
        ),
        ),
        GestureDetector(
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreditoScreen(token: widget.token)),
            )
            },
          child: Container(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.010, right: MediaQuery.of(context).size.height * 0.010, top:MediaQuery.of(context).size.height * 0.015, bottom: MediaQuery.of(context).size.height * 0.015 ),
          margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.040, right: MediaQuery.of(context).size.height * 0.040, bottom: MediaQuery.of(context).size.height * 0.010),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
        color: Colors.grey,
      ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left:MediaQuery.of(context).size.height * 0.00, right: MediaQuery.of(context).size.height * 0.1  ),
                child: CircleAvatar(
                  child: Icon(Icons.credit_card),
                ),
              ),
              Container(
                padding: EdgeInsets.all(1),
                margin: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.height * 0.010 ), 
                child: Text('Credito       '),
              )
            ],
          ),
        ),
        ),
        GestureDetector(
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FincaRaizScreen(token: widget.token)),
            )
            },
          child: Container(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.010, right: MediaQuery.of(context).size.height * 0.010, top:MediaQuery.of(context).size.height * 0.015, bottom: MediaQuery.of(context).size.height * 0.015, ),
          margin: EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.040, right: MediaQuery.of(context).size.height * 0.040),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
        color: Colors.grey,
      ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left:MediaQuery.of(context).size.height * 0.00, right: MediaQuery.of(context).size.height * 0.1  ),
                child: CircleAvatar(
                  child: Icon(Icons.house),
                ),
              ),
              Container(
                padding: EdgeInsets.all(1),
                margin: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.height * 0.010 ), 
                child: Text('Inmobiliario'),
              )
            ],
          ),
        ),
        ),
//  Container(
//           margin: EdgeInsets.symmetric(horizontal: 2),
//           child: ElevatedButton(
//           style: ButtonStyle(
//             backgroundColor:
//             MaterialStateProperty.all<Color>(const Color(0xFF0C67B0)),
//             ),
//             onPressed: () => {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => AhorroScreen(token: widget.token)),
//             )
//             },
//             child: Text('Ahorro'),
//           ),
//         ),
//  Container(
//         margin: EdgeInsets.symmetric(horizontal: 2),
//           child: ElevatedButton(
//             style: ButtonStyle(
//             backgroundColor:
//             MaterialStateProperty.all<Color>(const Color(0xFF0C67B0)),
//             ),
//             onPressed: () => {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => CreditoScreen(token: widget.token)),
//             )
//             },
//             child: Text('Crédito'),
//           ),
//         ),
        //      Container(
        // margin: EdgeInsets.symmetric(horizontal: 2),
        //   child: ElevatedButton(
        //     style: ButtonStyle(
        //     backgroundColor:
        //     MaterialStateProperty.all<Color>(const Color(0xFF0C67B0)),
        //     ),
        //     onPressed: () => {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => FincaRaizScreen(token: widget.token)),
        //     )
        //     },
        //     child: Text(
        //       'Finca Raíz',
        //       style: TextStyle(
        //         fontSize: 11
        //       ),
        //       ),
        //   ),
        // ),
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
