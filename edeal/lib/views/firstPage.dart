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
                  margin: const EdgeInsets.only(bottom: 100, top: 200),
                  width: 200,
                  child: Image.asset('assets/logo_base.png'),
                ),
                ),
                const SizedBox(height: 50),
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 40, right: 40, ),
                  child: Text(
                    'Get Started',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF444C52),
                      fontSize: 36,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.01,
                      height: 1.5,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top:20, left:40, right:40),
                  child: Text(
                    'Reference site about Lorem Ipsum,\ninformation on its origins, as well as\nrandom Lipsum generator.',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF817F7F),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                      letterSpacing: 0.01
                    ),
                  ),
                ),
                Container(
                  margin:  const EdgeInsets.only(top: 80, right: 50, left: 50),
                  child: Center(
                    child: 
                      ElevatedButton(
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignInPage()),
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
                              const EdgeInsets.symmetric(horizontal: 50),
                          ),
                        ),
                        child: const Text('Start now'),
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
