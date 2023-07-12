import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:edeal/dashboard.dart';
import 'package:edeal/registration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'config.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';
import 'package:google_fonts/google_fonts.dart';




class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);
  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final bool _isNotValidate = false;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

void loginUser() async {
  if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
    var reqBody = {
      "email": emailController.text,
      "password": passwordController.text
    };

    var response = await http.post(
      Uri.parse(login),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(reqBody),
    );

    var jsonResponse = jsonDecode(response.body);



    if (jsonResponse['status']) {
      var myToken = jsonResponse['token'];
      prefs.setString('token', myToken);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Dashboard(token: myToken)),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Usuario o Contraseña incorrectos'),
            content: Text('Por favor verifique la información y vuelva a intentarlo'),
            actions: [
              TextButton(
                child: Text('Cerrar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
            child: SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Container(
                    margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.00, top: MediaQuery.of(context).size.height * 0.03),
                    width: MediaQuery.of(context).size.width * 0.5,
                    child:Image.asset('assets/logoEdealAzul.png'), 
                  ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01, bottom: MediaQuery.of(context).size.height * 0.01),
                      child: Text(
                        'Bienvenido a Edeal !',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF0C67B0),
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.w700,
                          height: 1.5,
                          letterSpacing: -0.01
                        )
                        ),
                    ),
                  ),
                  Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.027, left: MediaQuery.of(context).size.width * 0.094, right: MediaQuery.of(context).size.width * 0.094, ),
                  child: Text(
                    'Hola ,',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF444C52),
                      fontSize: MediaQuery.of(context).size.width * 0.080,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.01,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.094, right: MediaQuery.of(context).size.width * 0.094, ),
                  child: Text(
                    'inicia sesión',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF444C52),
                      fontSize: MediaQuery.of(context).size.width * 0.080,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.01,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.094, right: MediaQuery.of(context).size.width * 0.094, top: MediaQuery.of(context).size.width * 0.03, bottom: MediaQuery.of(context).size.width * 0.03 ),
                  child: Row(
                    children: [
                      Text(
                        'No tienes cuenta ?',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF444C52),
                          fontSize: MediaQuery.of(context).size.width * 0.032,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                          letterSpacing: -0.01
                        ),
                        ),
                        GestureDetector(
                          onTap: () {
                          Navigator.push( 
                            context,
                            MaterialPageRoute(builder: (context) => Registration()),
                        );
                          },
                          child:Text(
                        '/Regístrate ahora',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF165AA5),
                          fontSize: MediaQuery.of(context).size.width * 0.031,
                          fontWeight:  FontWeight.w500,
                          height: 1.5,
                          letterSpacing:  -0.01
                        ),
                        ),
                        )
                    ],
                  )
                ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.008),
                    child: Column(
                      children: [ 
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.08),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Correo electrónico', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.width * 0.035,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
                          ) ,
                        ), 
                        Container(
                          child: TextField(
                      controller: emailController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Ingresa tu correo electrónico",
                        hintStyle: const TextStyle(
                          color: Color(0xFFABB3B8)
                        ),
                        errorText: _isNotValidate ? "Enter Proper Info" : null,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF0C67B0),
                            width: 1
                          ),
                        ),
                        enabledBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF0C67B0),
                            width: 1
                          ),
                        ),
                      ),
                    ).p4().px24(),
                        ),
                      ],
                    )
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 0),
                    child: Column(
                      children: [ 
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.08),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Contraseña', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.width * 0.035,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
                          ) ,
                        ), 
                        Container(
                          child: TextField(
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Ingresa tu contraseña",
                        hintStyle: const TextStyle(
                          color: Color(0xFFABB3B8)
                        ),
                        errorText: _isNotValidate ? "Enter Proper Info" : null,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF0C67B0),
                            width: 1
                          ),
                        ),
                        enabledBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF0C67B0),
                            width: 1
                          ),
                        ),
                      ),
                    ).p4().px24(),
                        ),
                      ],
                    )
                  ),
                  Container(
                          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.08, vertical: MediaQuery.of(context).size.height * 0.008),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Olvidaste tu contraseña ?', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.width * 0.03,
                                fontWeight: FontWeight.w400,
                                height: 1.5,
                                letterSpacing: -0.01,
                                color: const Color(0xFF444C52)
                              ),                   
                            ),
                          ) ,
                        ), 
                  SizedBox(height: MediaQuery.of(context).size.height * 0.003),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.015, bottom:MediaQuery.of(context).size.height * 0),
                      child: ElevatedButton(
                        onPressed: loginUser,
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            )
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF0C67B0)
                          ),
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.33, vertical: MediaQuery.of(context).size.height * 0.005),
                          ),
                        ),
                         child: Text(
                              'Ingresar', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.width * 0.05,
                                fontWeight: FontWeight.w400,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
                      )
                    ),
                  ),
                ],
              ),
            ),
        ),
      ),
    );
  }
}




