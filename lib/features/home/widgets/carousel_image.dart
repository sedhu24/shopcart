import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shopcart/constants/global_variables.dart';

class CarousalImages extends StatefulWidget {
  const CarousalImages({super.key});

  @override
  State<CarousalImages> createState() => _CarousalImagesState();
}

class _CarousalImagesState extends State<CarousalImages> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: GlobalVariables.carouselImages.map((i) {
        return Builder(builder: (BuildContext context) {
          return Image.network(
            i,
            fit: BoxFit.cover,
            height: 200,
          );
        });
      }).toList(),
      options: CarouselOptions(
        viewportFraction: 1,
        autoPlay: true,
        height: 200,
        enlargeCenterPage: true,
      ),
    );
  }
}
