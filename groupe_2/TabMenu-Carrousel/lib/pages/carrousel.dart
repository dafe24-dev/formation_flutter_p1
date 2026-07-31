import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Carrousel extends StatelessWidget {
  final List<Widget> items = [
    Container(
      color: Colors.amber,
      child: Center(child: Text('Slide 1')),
    ),
    Container(
      color: Colors.pink,
      child: Center(child: Text('Slide 2')),
    ),
    Container(
      color: Colors.teal,
      child: Center(child: Text('Slide 3')),
    ),
  ];

  Carrousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Carrousels"), elevation: 5),
      body: Center(
        child: CarouselSlider(
          items: items,
          options: CarouselOptions(
            height: 200,
            autoPlay: true,
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            viewportFraction: 0.8,
            autoPlayInterval: Duration(seconds: 3),
          ),
        ),
      ),
    );
  }
}
