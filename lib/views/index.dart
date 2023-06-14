import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../widgets/sub_header.dart';

class IndexScreen extends StatelessWidget {
  const IndexScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            child: SizedBox(
              // color: Colors.deepPurple,
              height: 10.0,
              child: SubHeaderTitle(),
            ),
          ),
          Expanded(
            child:
            Center(
              child: CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 16 / 9,
                  autoPlay: true,
                  enlargeCenterPage: true,
                ),
                items: [
                  Image.asset('assets/01.jpg', fit: BoxFit.cover),
                  Image.asset('assets/02.jpg', fit: BoxFit.cover),
                  Image.asset('assets/03.jpg', fit: BoxFit.cover),
                  Image.asset('assets/04.jpg', fit: BoxFit.cover),
                  Image.asset('assets/05.jpg', fit: BoxFit.cover),
                ],
              ),
            ),

          ),
        ],
      ),
    );
  }
}