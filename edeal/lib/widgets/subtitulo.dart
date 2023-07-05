import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  CustomTextWidget({
    required this.text,
    required this.fontSize,
    required this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.020 ,
        left: MediaQuery.of(context).size.height * 0.050,
        right: MediaQuery.of(context).size.height * 0.050,
        bottom: MediaQuery.of(context).size.height * 0.010,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: fontSize,
            fontWeight: fontWeight,
            height: 1.5,
            letterSpacing: -0.01,
          ),
        ),
      ),
    );
  }
}