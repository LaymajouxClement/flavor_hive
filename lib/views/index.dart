import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class IndexScreen extends StatelessWidget {
  const IndexScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double carouselHeight = screenHeight * 0.8;
    return Scaffold(
      appBar: AppBar(
        title: Text('App Menu'),
      ),
      body: Column(
        children: [
          Expanded(
            child:
            Center(
              child: CarouselSlider(
                options: CarouselOptions(
                  height: carouselHeight,
                  aspectRatio: 16 / 9,
                  autoPlay: true,
                  enlargeCenterPage: true,
                ),
                items: [
                  Image.asset('01.jpg', fit: BoxFit.cover),
                  Image.asset('02.jpg', fit: BoxFit.cover),
                  Image.asset('03.jpg', fit: BoxFit.cover),
                  Image.asset('04.jpg', fit: BoxFit.cover),
                  Image.asset('05.jpg', fit: BoxFit.cover),

                ],
              ),
          ),

          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Text('Welcome to the Home Screen!'),
      ),
    );
  }
}
