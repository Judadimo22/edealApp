import 'package:edeal/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  FirstPageState createState() => FirstPageState();
}

class FirstPageState extends State<FirstPage> {
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child:Container(
                  margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02, top: MediaQuery.of(context).size.height * 0.2),
                  width: 200,
                  child: Image.asset('assets/logoEdealAzul.png'),
                ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02, left: MediaQuery.of(context).size.height * 0.045, right: MediaQuery.of(context).size.height * 0.045, ),
                  child: Text(
                    'Bienvenido',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF444C52),
                      fontSize: MediaQuery.of(context).size.height * 0.035,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.01,
                      height: 1.5,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.030, left:MediaQuery.of(context).size.height * 0.045, right:MediaQuery.of(context).size.height * 0.045),
                  child: Text(
                    'Conoce la herramienta tecnológica al servicio de tus finanzas. ',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF817F7F),
                      fontSize: MediaQuery.of(context).size.height * 0.021,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                      letterSpacing: 0.01
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.075, right: MediaQuery.of(context).size.height * 0.045, left: MediaQuery.of(context).size.height * 0.045),
                  child: Center(
                    child: 
                      ElevatedButton(
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>const SignInPage()),
                        );
                        }, 
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            )
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF0C67B0)
                          ),
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * 0.065),
                          ),
                        ),
                        child: const Text('Iniciemos'),
                      )
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
