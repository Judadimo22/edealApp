import 'dart:convert';
import 'package:edeal/views/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class CreditoScreen extends StatefulWidget {
  final String token;

  CreditoScreen({required this.token, Key? key}) : super(key: key);

  @override
  State<CreditoScreen> createState() => _CreditoScreenState();
}

class _CreditoScreenState extends State<CreditoScreen> {
  late String userId;
  Map<String, dynamic> userData = {};

  final _formKey = GlobalKey<FormState>();
  TextEditingController _newDataController = TextEditingController();

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

  void saveUserData() async {
    if (_formKey.currentState!.validate()) {
      // Realizar la solicitud HTTP para enviar los datos del formulario y actualizar la información del usuario
      var newData = _newDataController.text;

      var response = await http.put(
        Uri.parse('http://192.168.1.108:3001/credit/$userId'),
        body: {'credit': newData},
      );

      if (response.statusCode == 200) {
        // Actualizar la información del usuario localmente
        setState(() {
          userData['credit'] = newData;
        });

        print('Información actualizada correctamente');
      } else {
        print('Error al actualizar la información: ${response.statusCode}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF524898),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${userData['code']}'),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: _newDataController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa la nueva información';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Nueva información",
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: saveUserData,
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
