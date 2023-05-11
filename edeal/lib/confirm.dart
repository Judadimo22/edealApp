import 'dart:convert';
import 'package:edeal/dashboard.dart';
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
  TextEditingController codecontroller = TextEditingController();
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

    void Confirm() {
      String codeUser = codecontroller.text;
      if(userData['code'] == codeUser){
        Navigator.push(  context,
        MaterialPageRoute(builder: (context) => Dashboard(token: widget.token)));
      }
      else{
        print('Error en el código');
      }
    }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: userData.isNotEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Confirm your account'),
                    TextField(
                    controller: codecontroller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        errorStyle: TextStyle(color: Colors.white),
                        hintText: "Code",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                  ),
                  ElevatedButton(onPressed: () => {
                    Confirm()
                  }, child: Text('Confirmar Código'))
                ],
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}