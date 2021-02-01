import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/components.dart';
import '../../helpers/helpers.dart';

class SurveysPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(R.strings.surveys),),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: CarouselSlider(
          options: CarouselOptions(
            enlargeCenterPage: true,
            aspectRatio: 1
          ),
          items: [
            SurveyItem(),
            SurveyItem(),
            SurveyItem(),
          ]
          ,),
      ),
    );
  }
}

