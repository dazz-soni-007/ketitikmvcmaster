import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselSliderWidget extends StatelessWidget {
   CarouselSliderWidget({
    Key? key,
    this.item,
  });
  final List<Widget>? item;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: item!,
      // carouselController: ,
      options: CarouselOptions(scrollDirection: Axis.vertical),
    );
  }
}
