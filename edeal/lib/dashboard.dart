import 'dart:convert';

import 'package:edeal/login.dart';
import 'package:edeal/planeacion.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;
import 'config.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Dashboard extends StatefulWidget {
  final token;
  const Dashboard({@required this.token,Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  late String userId;
  TextEditingController _todoTitle = TextEditingController();
  TextEditingController _todoDesc = TextEditingController();
  List? items;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map<String,dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

    userId = jwtDecodedToken['_id'];

  }







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
       body: Column(
         children: [
           Container(
             padding: EdgeInsets.only(top: 60.0, right: 10, left: 10),
             child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
               children: [
                Container(
                  padding:EdgeInsets.only(bottom: 5) ,
                  child: Align(
                    alignment: Alignment.center,
                    child:ElevatedButton(onPressed: () =>{}, 
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue[500],
                    minimumSize: const Size.fromHeight(50)
                  ),
                  child: Text(
                    textAlign:(TextAlign.left),
                    'Planeación financiera',
                    style: TextStyle(
                    fontSize: 30,
                    color: Colors.white
                  ))),)
                ),
                Container(
                  padding:EdgeInsets.only(bottom: 5) ,
                  child: Align(
                    alignment: Alignment.center,
                    child:ElevatedButton(onPressed: () =>{
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Planeacion()))
                    }, 
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue[500],
                    minimumSize: const Size.fromHeight(50)
                  ),
                  child: Text(
                    textAlign:(TextAlign.left),
                    'Ahorro',
                    style: TextStyle(
                    fontSize: 30,
                    color: Colors.white
                  ))),)
                ),
                Container(
                  padding:EdgeInsets.only(bottom: 5) ,
                  child: Align(
                    alignment: Alignment.center,
                    child:ElevatedButton(onPressed: () =>{}, 
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue[500],
                    minimumSize: const Size.fromHeight(50)
                  ),
                  child: Text(
                    textAlign:(TextAlign.left),
                    'Crédito',
                    style: TextStyle(
                    fontSize: 30,
                    color: Colors.white
                  ))),)
                ),
               ],
               crossAxisAlignment: CrossAxisAlignment.center,
             ),
           ),
         ],
       ),
    );
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add To-Do'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _todoTitle,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Title",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                ).p4().px8(),
                TextField(
                  controller: _todoDesc,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Description",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                ).p4().px8(),
                ElevatedButton(onPressed: (){
                  }, child: Text("Add"))
                  
              ],
            ),
            
          );
        });
  }
}