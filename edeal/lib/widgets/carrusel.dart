import 'package:edeal/formularioPlanFinanciero/informacionPersonal.dart';
import 'package:edeal/views/ahorroPage.dart';
import 'package:edeal/views/creditoScreen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:edeal/views/fincaRaizPage.dart';

class ImageCarousel extends StatelessWidget {
  final List<String> imagePaths;
  final String token;

  ImageCarousel({required this.imagePaths, required this.token});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200, 
        enableInfiniteScroll: true, 
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 8), 
        autoPlayAnimationDuration: Duration(milliseconds: 800), 
        pauseAutoPlayOnTouch: true, 
        viewportFraction: 1.0, 
      ),
      items: imagePaths.map((path) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                if (path == 'assets/1.png') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FincaRaizScreen(token: token)),
                  );
                } else if (path == 'assets/2.png') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InformacionPersonal(token: token)),
                  );
                } else if (path == 'assets/3.png') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AhorroScreen(token: token)),
                  );
                } else if (path == 'assets/4.png') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreditoScreen(token: token)),
                  );
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 0.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Image.asset(
                  path,
                  fit: BoxFit.fill,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
