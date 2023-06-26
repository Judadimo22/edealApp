import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:edeal/dashboard.dart';
import 'package:edeal/registration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'config.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';




class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isNotValidate = false;
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
            title: Text('Error de inicio de sesión'),
            content: Text(jsonResponse['error']),
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
  }
}


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Color(0XFF524898),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/logo_edeal.png'),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: TextField(
                      controller: emailController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Email",
                        errorText: _isNotValidate ? "Enter Proper Info" : null,
                      ),
                    ).p4().px24(),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: TextField(
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Password",
                        errorText: _isNotValidate ? "Enter Proper Info" : null,
                      ),
                    ).p4().px24(),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: loginUser,
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0XFFE8E112)),
                    ),
                    child: Text('INGRESAR'),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 40),
                    child: Text(
                      'Olvidé mi contraseña',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Registration()),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0XFFE8E112)),
                    ),
                    child: Text('REGISTRARSE'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
