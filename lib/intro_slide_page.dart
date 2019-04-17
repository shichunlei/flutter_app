import 'package:flutter/material.dart';
import 'package:flutter_app/login/page/login_page.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:flutter_app/utils/route_util.dart';

class IntroSlidePage extends StatefulWidget {
  @override
  createState() => SliderScreenState();
}

class SliderScreenState extends State<IntroSlidePage> {
  List<Slide> slides = [];

  @override
  void initState() {
    super.initState();

    slides.add(
      Slide(
        title: "FLUTTER",
        description:
            "Get Faster Development, Flexible UI & Access Native Features. Learn More! High-Quality Interfaces. Flexible UI. Fast Development.",
        pathImage: "images/flutter.png",
        backgroundColor: Colors.lightBlue,
      ),
    );
    slides.add(
      Slide(
        title: "DART",
        description:
            "Developers at Google and elsewhere use Dart to create high-quality, mission-critical apps for iOS, Android, and the web. With features aimed at client-side development, Dart is a great fit for both mobile and web apps.",
        pathImage: "images/dart.png",
        backgroundColor: Colors.orangeAccent,
      ),
    );
    slides.add(
      Slide(
        title: "WELECOME",
        description: "开始你的app",
        pathImage: "images/flutterlogo.png",
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      slides: this.slides,
      onDonePress: () => pushAndRemovePage(context, LoginPage()),
    );
  }
}
