import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageCarousel extends StatelessWidget {
  final List<String> imagePaths;

  ImageCarousel({required this.imagePaths});

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
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: Colors.grey, 
              ),
              child: Image.asset(
                path,
                fit: BoxFit.fill,
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
