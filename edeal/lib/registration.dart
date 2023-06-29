import 'dart:convert';
import 'package:edeal/confirm.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'config.dart';
import 'package:google_fonts/google_fonts.dart';



class Registration extends StatefulWidget {
    const Registration({Key? key}) : super(key: key);
  @override
  RegistrationState createState() => RegistrationState();
}

class RegistrationState extends State<Registration> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordControler = TextEditingController();
  bool _isPasswordValid = true;

  void _validatePassword() {
    setState(() {
      _isPasswordValid = passwordController.text.length >= 8;
    });
  }



  bool _isNotValidate = false;
  late SharedPreferences prefs;
  @override
  void initState() {
    super.initState();
    initSharedPref();
  }
    void initSharedPref() async{
    prefs = await SharedPreferences.getInstance();
  } 
void registerUser() async {
  if (passwordController.text != confirmPasswordControler.text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Contraseñas no coinciden'),
          content: const Text('Por favor, asegúrate de que las contraseñas coincidan.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
    return;
  }

  if (emailController.text.isNotEmpty &&
      passwordController.text.isNotEmpty ) {
    var regBody = {
      "email": emailController.text,
      "password": passwordController.text,
    };

    var response = await http.post(
      Uri.parse(registration),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(regBody),
    );

    var jsonResponse = jsonDecode(response.body);

    print(jsonResponse['status']);

    if (jsonResponse['status']) {
      var myToken = jsonResponse['token'];
      prefs.setString('token', myToken);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Usuario creado correctamente'),
            content: Text('Tu usuario se creó correctamente'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Confirm(token: myToken)),
                  );
                },
                child: Text('Aceptar'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error al registrarse'),
            content: Text('Hubo un error al registrarte, por favor inténtalo de nuevo'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Aceptar'),
              ),
            ],
          );
        },
      );
    }
  } else {
    setState(() {
      _isNotValidate = true;
    });
  }
}


  bool _isPasswordVisible = false;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Center(
                    child: Container(
                    margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.020, top: MediaQuery.of(context).size.height * 0.050),
                    width: 200,
                    child:Image.asset('assets/logo_base.png'), 
                  ),
                  ),
                  Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.020, left: MediaQuery.of(context).size.height * 0.045, right: MediaQuery.of(context).size.height * 0.045, ),
                  child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Hola,', 
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF444C52),
                                fontSize: MediaQuery.of(context).size.height * 0.035,
                                fontWeight: FontWeight.w600,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
                          ) ,
                ),
                Container(
                  margin:EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.045, right: MediaQuery.of(context).size.height * 0.045, bottom: MediaQuery.of(context).size.height * 0.030 ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                    'regístrate',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF444C52),
                      fontSize: MediaQuery.of(context).size.height * 0.035,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.01,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  )
                ),
                Container(
                    margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.015),
                    child: Column(
                      children: [ 
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.040),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Correo electrónico', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.016,
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
                        errorText: _isNotValidate ? "Ingresa un correo electrónico válido" : null,
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
                    margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.015),
                    child: Column(
                      children: [ 
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.040),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Contraseña', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.016,
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
                      obscureText: !_isPasswordVisible,
                      onChanged: (value) => _validatePassword(),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Ingresa tu contraseña",
                        helperText: _isPasswordValid ? null : "La contraseña debe tener al menos 8 caracteres",
                        hintStyle: const TextStyle(
                          color: Color(0xFFABB3B8)
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                          child: Icon(
                            _isPasswordVisible ? Icons.visibility : Icons.visibility_off
                          ),
                        ),
                        errorText: _isNotValidate ? "Ingresa una contraseña válida" : null,
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
                    margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.015),
                    child: Column(
                      children: [ 
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.040),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Confirma tu contraseña', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.016,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                letterSpacing: -0.01
                              ),                   
                            ),
                          ) ,
                        ), 
                        Container(
                          child: TextField(
                      controller: confirmPasswordControler,
                      keyboardType: TextInputType.text,
                      obscureText: !_isPasswordVisible,
                      onChanged: (value) => _validatePassword(),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Ingresa nuevamente tu contraseña",
                        hintStyle: const TextStyle(
                          color: Color(0xFFABB3B8)
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                          child: Icon(
                            _isPasswordVisible ? Icons.visibility : Icons.visibility_off
                          ),
                        ),
                        errorText: _isNotValidate ? "Confirma tu contraseña" : null,
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
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.020),
                      child: ElevatedButton(
                        onPressed: registerUser,
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
                              EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.12, vertical:10),
                          ),
                        ),
                         child: Text(
                              'Registrarse', 
                              style: GoogleFonts.poppins(
                                fontSize: MediaQuery.of(context).size.height * 0.023,
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
