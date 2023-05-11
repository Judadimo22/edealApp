import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class Confirm extends StatefulWidget {
  final String token;

  Confirm({required this.token, Key? key}) : super(key: key);

  @override
  State<Confirm> createState() => _ConfirmState();
}

class _ConfirmState extends State<Confirm> {
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
  var response = await http.get(Uri.parse('http://192.168.1.108:3001/user/$userId'), headers: {
    'Authorization': 'Bearer ${widget.token}',
  });

  if (response.statusCode == 200) {
    setState(() {
      userData = jsonDecode(response.body);
    });
  } else {
    print('Error: ${response.statusCode}');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Center(
        child: userData.isNotEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('ID: ${userData['_id']}'),
                  Text('Nombre: ${userData['name']}'),
                  Text('Correo electrónico: ${userData['email']}'),
                  Text('Code: ${userData['code']}'),
                ],
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}