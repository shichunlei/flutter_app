import 'package:custom_widgets/indicator/rect_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/page_index.dart';

import 'login/page/login_page.dart';

class IntroSlidePage extends StatefulWidget {
  @override
  createState() => SliderScreenState();
}

class SliderScreenState extends State<IntroSlidePage> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [
                        0.1,
                        0.4,
                        0.7,
                        0.9
                      ],
                      colors: [
                        Color(0xFF3594DD),
                        Color(0xFF4563DB),
                        Color(0xFF5036D5),
                        Color(0xFF5B16D0)
                      ]),
                ),
                child: Stack(children: <Widget>[
                  Positioned.fill(
                    child: Container(
                      child: PageView(
                          physics: ClampingScrollPhysics(),
                          controller: _pageController,
                          onPageChanged: (int page) =>
                              setState(() => _currentPage = page),
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.all(40.0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Center(
                                          child: Image.asset(
                                              'images/onboarding0.png',
                                              height: 200.0,
                                              width: 200.0)),
                                      SizedBox(height: 30.0),
                                      Text('Connect people\naround the world',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 26.0,
                                              height: 1.5)),
                                      SizedBox(height: 15.0),
                                      Text(
                                          'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0,
                                              height: 1.2))
                                    ])),
                            Padding(
                                padding: EdgeInsets.all(40.0),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Center(
                                          child: Image.asset(
                                              'images/onboarding1.png',
                                              height: 200.0,
                                              width: 200.0)),
                                      SizedBox(height: 30.0),
                                      Text('Live your life smarter\nwith us!',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 26.0,
                                              height: 1.5)),
                                      SizedBox(height: 15.0),
                                      Text(
                                          'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0,
                                              height: 1.2))
                                    ])),
                            Padding(
                                padding: EdgeInsets.all(40.0),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Center(
                                          child: Image.asset(
                                              'images/onboarding2.png',
                                              height: 200.0,
                                              width: 200.0)),
                                      SizedBox(height: 30.0),
                                      Text(
                                          'Get a new experience\nof imagination',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 26.0,
                                              height: 1.5)),
                                      SizedBox(height: 15.0),
                                      Text(
                                          'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0,
                                              height: 1.2))
                                    ]))
                          ]),
                    ),
                  ),
                  Positioned(
                      top: Utils.topSafeHeight,
                      right: 10,
                      child: FlatButton(
                          onPressed: () =>
                              pushAndRemovePage(context, LoginPage()),
                          child: Text('Skip',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0)))),
                  Positioned(
                      bottom: Utils.bottomSafeHeight + 20,
                      left: 0,
                      right: 0,
                      child: RectIndicator(
                          position: _currentPage,
                          count: _numPages,
                          activeColor: Color(0xFF7B51D3),
                          width: 16.0,
                          activeWidth: 24.0,
                          height: 8.0))
                ]))),
        bottomSheet: _currentPage == _numPages - 1
            ? GestureDetector(
                onTap: () => pushAndRemovePage(context, LoginPage()),
                child: Container(
                    height: 100.0,
                    width: double.infinity,
                    color: Colors.white,
                    padding: EdgeInsets.only(bottom: 30.0),
                    alignment: Alignment.center,
                    child: Text('Get started',
                        style: TextStyle(
                            color: Color(0xFF5B16D0),
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold))))
            : SizedBox());
  }
}
