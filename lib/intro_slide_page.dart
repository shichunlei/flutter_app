import 'package:flutter/material.dart';
import 'package:flutter_app/page/login_page.dart';
import 'package:intro_slider/intro_slider.dart';

class IntroSlidePage extends StatefulWidget {
  @override
  createState() => SliderScreenState();
}

class SliderScreenState extends State<IntroSlidePage> {
  List<Slide> slides = new List();

  @override
  void initState() {
    // TODO: implement initState
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

  void onDonePress() {
    Navigator.of(context).pushAndRemoveUntil(
        new MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
        (route) => route == null);
  }

  void onSkipPress() {
    Navigator.of(context).pushAndRemoveUntil(
        new MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
        (route) => route == null);
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,
      onSkipPress: this.onSkipPress,
    );
  }
}
