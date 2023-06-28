import 'dart:convert';
import 'package:edeal/confirm.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'config.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';


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
        appBar: AppBar(
          title: Text('Registro'),
          centerTitle: true,
          backgroundColor: Color(0XFF524898),
          toolbarHeight: 70,
        ),
        body: Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  HeightBox(10),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child:TextField(
                    controller: emailController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(color: Colors.white),
                        errorText: _isNotValidate ? "Enter Proper Info" : null,
                        hintText: "Email",),
                  ).p4().px24(),
                  ),
                Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: !_isPasswordVisible,
                    onChanged: (value) => _validatePassword(),
                    decoration: InputDecoration(
                        errorStyle: TextStyle(color: Colors.white),
                        errorText: _isNotValidate ? "Enter Proper Info" : null,
                        hintText: "Contraseña",
                        helperText: _isPasswordValid ? null : "La contraseña debe tener al menos 8 caracteres",
                    suffixIcon: GestureDetector(
                    onTap: () {
                  setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                child: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                ),
                ),
                ).p4().px24(),
                ),
                Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: TextFormField(
                    controller: confirmPasswordControler,
                    keyboardType: TextInputType.text,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(color: Colors.white),
                        errorText: _isNotValidate ? "Enter Proper Info" : null,
                        hintText: "Confirmar contraseña",
                    suffixIcon: GestureDetector(
                    onTap: () {
                  setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                child: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),),
                ),
                ).p4().px24(),
                ),
                  Container(
                    child: ElevatedButton(
                      onPressed: () =>{
                        registerUser()
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0XFFE8E112) , // Background color
                        ),
                      child: Text('REGISTRARSE'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
