import 'dart:convert';
import 'package:edeal/confirm.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'config.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';


class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordControler = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController tipoCedulaController = TextEditingController();
  TextEditingController cedulaController = TextEditingController();
  TextEditingController fechaNacimientoController = TextEditingController();
  DateTime ? selectedDate;
  bool _isPasswordValid = true;

  void _validatePassword() {
    setState(() {
      _isPasswordValid = passwordController.text.length >= 8;
    });
  }


    Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(1900),
      maxTime: DateTime.now(),
      locale: LocaleType.es,
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        fechaNacimientoController.text =
            "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }



  String _tipoDocumento = 'Tipo de documento';
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
          title: Text('Contraseñas no coinciden'),
          content: Text('Por favor, asegúrate de que las contraseñas coincidan.'),
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
    return;
  }

  if (emailController.text.isNotEmpty &&
      passwordController.text.isNotEmpty &&
      nameController.text.isNotEmpty &&
      lastNameController.text.isNotEmpty &&
      phoneController.text.isNotEmpty &&
      cedulaController.text.isNotEmpty &&
      fechaNacimientoController.text.isNotEmpty) {
    var regBody = {
      "email": emailController.text,
      "password": passwordController.text,
      "name": nameController.text,
      "lastName": lastNameController.text,
      "phone": phoneController.text,
      "tipoCedula": _tipoDocumento,
      "cedula": cedulaController.text,
      "fechaNacimiento": fechaNacimientoController.text
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
      _tipoDocumento = 'Tipo de documento';
    });
  }
}

    void updateTipoDocumento(String? newTipoDocumento){
    setState(() {
    _tipoDocumento = newTipoDocumento!;
    });
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
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(color: Colors.white),
                        errorText: _isNotValidate ? "Enter Proper Info" : null,
                        hintText: "Nombre",),
                  ).p4().px24(),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child:TextField(
                    controller: lastNameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(color: Colors.white),
                        errorText: _isNotValidate ? "Enter Proper Info" : null,
                        hintText: "Apellido",),
                  ).p4().px24(),
                  ),
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
                    child:TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(color: Colors.white),
                        errorText: _isNotValidate ? "Enter Proper Info" : null,
                        hintText: "Teléfono",),
                  ).p4().px24(),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    width: 360,
                    child:DropdownButton<String>(
                      value: _tipoDocumento,
                      onChanged: updateTipoDocumento,
                      items: <String>[
                        'Tipo de documento',
                        'Cédula',
                        'Pasaporte',
                        'Cédula extranjería',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child:TextField(
                    controller: cedulaController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(color: Colors.white),
                        errorText: _isNotValidate ? "Enter Proper Info" : null,
                        hintText: "Número de cédula",),
                  ).p4().px24(),
                  ),
                  Container(
                    margin:EdgeInsets.only(bottom: 20, left: 27, right: 27),
                    child:             TextField(
                    controller: fechaNacimientoController,
                    readOnly: true,
                    decoration: InputDecoration(
                        hintText: 'Fecha de Nacimiento',
                        suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                        onPressed: () {
                        _selectDate(context);
                    },
                  ),
                  ),
                  )
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
