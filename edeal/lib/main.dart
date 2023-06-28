import 'package:edeal/confirm.dart';
import 'package:edeal/views/firstPage.dart';
import 'package:flutter/material.dart';
import 'package:edeal/dashboard.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';



void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(token: prefs.getString('token'),));
}

class MyApp extends StatelessWidget {

  final token;
  const MyApp({
    @required this.token,
    Key? key,
}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      // home: (token != null && JwtDecoder.isExpired(token) == false )?Dashboard(token: token):SignInPage(),
      routes: {
        // '/confirm': (context) => Confirm(token: token),
        '/': (context) =>  const FirstPage()
      },
    );
  }
}