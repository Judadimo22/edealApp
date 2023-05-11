import 'dart:convert';
import 'package:edeal/views/ahorroPage.dart';
import 'package:edeal/views/creditoScreen.dart';
import 'package:edeal/views/homeScreen.dart';
import 'package:edeal/views/planeacionScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class Dashboard extends StatefulWidget {
  final String token;

  Dashboard({required this.token, Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late String userId;
  Map<String, dynamic> userData = {};
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    userId = jwtDecodedToken['_id'];
    fetchUserData();
    _pages = [
      Home(token: widget.token),
      PlaneacionScreen(token: widget.token),
      AhorroScreen(token: widget.token),
      CreditoScreen(token: widget.token)
    ];
  }

  void fetchUserData() async {
    var response =
        await http.get(Uri.parse('http://192.168.1.108:3001/user/$userId'));

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

  int _selectedTab = 0;

  void _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF524898),
      body: Center(
        child: _pages[_selectedTab],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: _changeTab,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.blue,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
          BottomNavigationBarItem(
              icon: Icon(Icons.stacked_line_chart_sharp), label: "Planeación"),
          BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on), label: "Ahorro"),
          BottomNavigationBarItem(
              icon: Icon(Icons.credit_score_sharp), label: "Crédito"),
        ],

    ),
    );
  }

  }



/// Flutter code sample for [DropdownButton].








// import 'dart:convert';

// import 'package:edeal/login.dart';
// import 'package:edeal/planeacion.dart';
// import 'package:flutter/material.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';
// import 'package:velocity_x/velocity_x.dart';
// import 'package:http/http.dart' as http;
// import 'config.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';

// class Dashboard extends StatefulWidget {
//   final token;
//   const Dashboard({@required this.token,Key? key}) : super(key: key);

//   @override
//   State<Dashboard> createState() => _DashboardState();
// }

// class _DashboardState extends State<Dashboard> {

//   late String userId;
//   TextEditingController _todoTitle = TextEditingController();
//   TextEditingController _todoDesc = TextEditingController();
//   List? items;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     Map<String,dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

//     userId = jwtDecodedToken['_id'];

//   }

//   int _selectedTab = 0;

//   List _pages = [
//     Container(
//     margin: EdgeInsets.only(top: 120),
//     child: Column(children: [
//       Container(
//         margin: EdgeInsets.only(bottom: 20),
//         child:Text(
//           'Saldo total',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 20
//           ),
//           ),
//       ),
//     Text(
//       '600.00 COP',
//       style: TextStyle(
//         color: Colors.white,
//         fontSize: 40
//       ),
//       ),
//     Container(
//       margin: EdgeInsets.only(top: 20),
//       child:Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               color:Color(0XFFE8E112),
//               borderRadius: BorderRadius.circular(10)
//             ),
//             padding: EdgeInsets.only(top:10, bottom: 10, left: 20, right: 20 ),
//             margin: EdgeInsets.only(left: 10, right: 10),
//             child:Text(
//               'RECARGAR',
//               style: TextStyle(
//               color: Color(0XFF524898)
//               ),
//               ),
//           ),
//           Container(
//             decoration: BoxDecoration(
//               color:Colors.white,
//               borderRadius: BorderRadius.circular(10)
//             ),
//             padding: EdgeInsets.only(top:10, bottom: 10, left: 20, right: 20 ),
//             margin: EdgeInsets.only(left: 10, right: 10),
//             child:Text(
//               'ENVIAR',
//               style: TextStyle(
//                 color: Color(0XFF524898)
//               ),
//               ),
//           ),


//       ],)
//     ),
//     ]),
//     ),
//     Center(
//       child: Text(
//         "Planeación",
//         style: TextStyle(
//           fontSize: 30,
//           color: Colors.white
//         ),
//         ),
//     ),
//     Center(
//       child: Text(
//         "Ahorro",
//         style: TextStyle(
//         fontSize: 30,
//         color: Colors.white
//         ),
//         ),
//     ),
//     Center(
//       child: Text(
//         "Crédito",
//         style: TextStyle(
//         fontSize: 30,
//         color: Colors.white
//         ),
//         ),
//     ),
//   ];

//   _changeTab(int index) {
//     setState(() {
//       _selectedTab = index;
//     });
//   }



//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       backgroundColor: Color(0XFF524898),
//       body: Center(
//         child: _pages[_selectedTab],
//       ),
//     bottomNavigationBar:
//     BottomNavigationBar(
//       currentIndex: _selectedTab,
//       onTap: (index) => _changeTab(index),
//       unselectedItemColor: Colors.black,
//       selectedItemColor: Colors.blue,
//       items:[
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
//           BottomNavigationBarItem(icon: Icon(Icons.stacked_line_chart_sharp), label: "Planeación"),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.monetization_on), label: "Ahorro"),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.credit_score_sharp), label: "Crédito"),
//       ]
      
//     ),
//     );
//   }

// }

