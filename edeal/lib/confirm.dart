import 'dart:convert';
import 'package:edeal/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'dart:async';

class Confirm extends StatefulWidget {
  final String token;

  Confirm({required this.token, Key? key}) : super(key: key);

  @override
  State<Confirm> createState() => _ConfirmState();
}

class _ConfirmState extends State<Confirm> {
  late String userId;
  TextEditingController codeController = TextEditingController();
  Map<String, dynamic> userData = {};
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    userId = jwtDecodedToken['_id'];
    fetchUserData();

    _timer = Timer.periodic(Duration(minutes: 2), (_) {
      fetchUserData();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void fetchUserData() async {
    var response = await http.get(
      Uri.parse('http://192.168.1.108:3001/user/$userId'),
      headers: {
        'Authorization': 'Bearer ${widget.token}',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        userData = jsonDecode(response.body);
      });
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  void confirm() async {
    var response = await http.put(
      Uri.parse('http://192.168.1.108:3001/confirmar/$userId'),
    );
    String codeUser = codeController.text;
    if (userData['code'] == codeUser) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Cuenta verificada'),
            content: Text('Tu cuenta ha sido verificada de manera correcta'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Dashboard(token: widget.token)),
                  );
                },
                child: Text('Aceptar'),
              ),
            ],
          );
        },
      );
    } else if (userData['code'] != codeUser) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error en el código'),
            content: Text('El código ingresado no coincide'),
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
    else if (!userData['code']){
            showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('El código ha expirado'),
            content: Text('El código ingresado ha expirado, por favor ingresa un nuevo código'),
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

  void reenviarEmail() async {
    var userEmail = userData['email'];
    var response = await http.put(
      Uri.parse('http://192.168.1.108:3001/reenviar/$userId/$userEmail'),
    );

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Código reenviado'),
            content: Text('Se ha reenviado un nuevo código a tu correo'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  fetchUserData(); // Obtener los datos actualizados después de reenviar el correo
                },
                child: Text('Aceptar'),
              ),
            ],
          );
        },
      );
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ingresar código'),
        centerTitle: true,
        backgroundColor: Color(0XFF524898),
        toolbarHeight: 70,
      ),
        body: Center(
        child: userData.isNotEmpty
        ? Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
         Container(
         margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
         child: Text(
         'Verifica tu correo (${userData['email']}) e ingresa un código válido.',
         textAlign: TextAlign.center,
        ),
     ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: TextField(
        controller: codeController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        errorStyle: TextStyle(color: Colors.white),
        hintText: "Code",
        border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    ),
    ),
    ),
     Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
      onPressed: () => confirm(),
      style: ElevatedButton.styleFrom(
       primary: Color(0XFFE8E112), // Background color
     ),
     child: Text('Confirmar Cuenta'),
    ),
    ),
    Container(
     margin: EdgeInsets.symmetric(vertical: 10),
     child: ElevatedButton(
     onPressed: () => reenviarEmail(),
     style: ElevatedButton.styleFrom(
     primary: Color(0XFFE8E112), // Background color
    ),
    child: Text('Reenviar Correo'),
    ), 
   ),
   ],
   )
    : CircularProgressIndicator(),
    ),
   );
   }
   }
