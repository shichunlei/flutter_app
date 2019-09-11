import 'package:flutter/material.dart';
import 'package:flutter_app/login/page/login_page.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:intro_slider/dot_animation_enum.dart';
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

    slides.add(Slide(
      title: "FLUTTER",
      styleTitle: TextStyle(
          color: Color(0xff3da4ab),
          fontSize: 30.0,
          fontWeight: FontWeight.bold),
      description:
          "Get Faster Development, Flexible UI & Access Native Features. Learn More! High-Quality Interfaces. Flexible UI. Fast Development.",
      pathImage: "images/flutter.png",
      backgroundColor: Colors.lightBlue,
    ));
    slides.add(Slide(
      title: "DART",
      styleTitle: TextStyle(
          color: Color(0xff3da4ab),
          fontSize: 30.0,
          fontWeight: FontWeight.bold),
      description:
          "Developers at Google and elsewhere use Dart to create high-quality, mission-critical apps for iOS, Android, and the web. With features aimed at client-side development, Dart is a great fit for both mobile and web apps.",
      pathImage: "images/dart.png",
      backgroundColor: Colors.orangeAccent,
    ));
    slides.add(Slide(
      title: "WELECOME",
      styleTitle: TextStyle(
          color: Color(0xff3da4ab),
          fontSize: 30.0,
          fontWeight: FontWeight.bold),
      description: "开始你的app",
      pathImage: "images/flutterlogo.png",
      backgroundColor: Colors.redAccent,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      // List slides
      slides: this.slides,

      // Skip button
      renderSkipBtn: this.renderSkipBtn(),
      colorSkipBtn: Color(0x33ffcc5c),
      highlightColorSkipBtn: Color(0xffffcc5c),

      // Next button
      renderNextBtn: this.renderNextBtn(),

      // Done button
      renderDoneBtn: this.renderDoneBtn(),
      onDonePress: this.onDonePress,
      colorDoneBtn: Color(0x33ffcc5c),
      highlightColorDoneBtn: Color(0xffffcc5c),

      // Dot indicator
      colorDot: Color(0xffffcc5c),
      sizeDot: 13.0,
      typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,

      // Show or hide status bar
      shouldHideStatusBar: true,
    );
  }

  void onDonePress() {
    // Back to the first tab
    pushAndRemovePage(context, LoginPage());
  }

  Widget renderNextBtn() {
    return Icon(Icons.navigate_next, color: Color(0xffffcc5c), size: 35.0);
  }

  Widget renderDoneBtn() {
    return Icon(Icons.done, color: Color(0xffffcc5c));
  }

  Widget renderSkipBtn() {
    return Icon(Icons.skip_next, color: Color(0xffffcc5c));
  }
}
