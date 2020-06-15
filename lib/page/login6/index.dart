import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../page_index.dart';
import 'component/iconbutton.dart';
import 'component/on_boarding_enter_animation.dart';
import 'tabs/signin.dart';
import 'tabs/signup.dart';

/// https://github.com/may-andro/dribble_flutter_challenge
class OnboardingPage extends StatefulWidget {
  OnboardingPage({Key key}) : super(key: key);

  @override
  createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with TickerProviderStateMixin {
  PageController _pageController;
  AnimationController animationController;
  OnBoardingEnterAnimation onBoardingEnterAnimation;
  ValueNotifier<double> selectedIndex = ValueNotifier<double>(0.0);

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.8,
    );

    animationController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);

    onBoardingEnterAnimation = OnBoardingEnterAnimation(animationController);

    animationController.forward();
  }

  @override
  void dispose() {
    animationController?.dispose();
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: AnimatedBuilder(
          animation: animationController,
          builder: (BuildContext context, Widget child) {
            return Stack(
              children: <Widget>[
                _buildTopBubble(
                    Utils.height,
                    -Utils.height * 0.5,
                    -Utils.width * 0.1,
                    LinearGradient(
                      begin: FractionalOffset.bottomLeft,
                      end: FractionalOffset.topRight,
                      colors: <Color>[
                        Color(0xFFEA9F57),
                        Color(0xFFDD6F85),
                      ],
                    )),
                _buildTopBubble(
                    Utils.width,
                    -Utils.width * 0.5,
                    Utils.width * 0.5,
                    LinearGradient(
                      begin: FractionalOffset.bottomLeft,
                      end: FractionalOffset.topRight,
                      colors: <Color>[
                        Colors.white.withOpacity(0.2),
                        Colors.white.withOpacity(0.2),
                      ],
                    )),
                _buildTopBubble(
                    Utils.width,
                    -Utils.width * 0.5,
                    -Utils.width * 0.7,
                    LinearGradient(
                      begin: FractionalOffset.bottomLeft,
                      end: FractionalOffset.topRight,
                      colors: <Color>[
                        Colors.white.withOpacity(0.0),
                        Colors.white.withOpacity(0.2),
                      ],
                    )),
                _buildTopBubble(
                    Utils.width,
                    -Utils.width * 0.7,
                    -Utils.width * 0.4,
                    LinearGradient(
                      begin: FractionalOffset.bottomLeft,
                      end: FractionalOffset.topRight,
                      colors: <Color>[
                        Colors.white.withOpacity(0.0),
                        Colors.white.withOpacity(0.2),
                      ],
                    )),
                _buildTopBubble(
                    Utils.width,
                    -Utils.width * 0.7,
                    Utils.width * 0.2,
                    LinearGradient(
                      begin: FractionalOffset.bottomLeft,
                      end: FractionalOffset.topRight,
                      colors: <Color>[
                        Colors.white.withOpacity(0.0),
                        Colors.white.withOpacity(0.2),
                      ],
                    )),
                _buildTopBubble(
                    Utils.width * 0.5,
                    -Utils.width * 0.5,
                    Utils.width * 0.5,
                    LinearGradient(
                      begin: FractionalOffset.bottomLeft,
                      end: FractionalOffset.topRight,
                      colors: <Color>[
                        Colors.white.withOpacity(0.1),
                        Colors.white.withOpacity(0.0),
                      ],
                    )),
                _buildTopBubble(
                    Utils.height * 0.5,
                    Utils.height * 0.5,
                    -Utils.width * 0.5,
                    LinearGradient(
                      begin: FractionalOffset.bottomLeft,
                      end: FractionalOffset.topRight,
                      colors: <Color>[
                        Color(0xFFEC5A7A),
                        Color(0xFFE17D73),
                      ],
                    )),
                FadeTransition(
                  opacity: onBoardingEnterAnimation.fadeTranslation,
                  child: NotificationListener(
                    onNotification: (ScrollNotification notification) {
                      if (notification.depth == 0 &&
                          notification is ScrollUpdateNotification) {
                        selectedIndex.value = _pageController.page;
                        setState(() {});
                      }
                      return false;
                    },
                    child: PageView(
                      controller: _pageController,
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      onPageChanged: (int index) {},
                      children: <Widget>[
                        SignInTab(
                          onPressed: () {
                            _pageController.animateToPage(1,
                                duration: Duration(milliseconds: 1000),
                                curve: Curves.fastOutSlowIn);
                          },
                        ),
                        SignUpTab(onPressed: () {
                          _pageController.animateToPage(0,
                              duration: Duration(milliseconds: 1000),
                              curve: Curves.fastOutSlowIn);
                        }),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: Utils.height * 0.75,
                  left: Utils.width * 0.1,
                  child: CircleIconButton(
                    color: Color(0xffFC5345),
                    icon: FontAwesome.google,
                    animatedValue: -selectedIndex.value,
                    onBoardingEnterAnimation: onBoardingEnterAnimation,
                    onPressed: () {
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text('Google')));
                    },
                    tag: 'Google-top',
                  ),
                ),
                Positioned(
                  top: Utils.height * 0.8,
                  left: Utils.width * 0.3,
                  child: CircleIconButton(
                    color: Color(0xff4C76BE),
                    icon: FontAwesome.facebook,
                    animatedValue: -selectedIndex.value,
                    onBoardingEnterAnimation: onBoardingEnterAnimation,
                    onPressed: () {
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text('Facebook')));
                    },
                    tag: 'Facebook-top',
                  ),
                ),
                Positioned(
                  top: Utils.height * 0.85,
                  left: Utils.width * 0.5,
                  child: CircleIconButton(
                    color: Color(0xff00C7FF),
                    icon: FontAwesome.twitter,
                    animatedValue: -selectedIndex.value,
                    onBoardingEnterAnimation: onBoardingEnterAnimation,
                    onPressed: () {
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text('Twitter')));
                    },
                    tag: 'Twitter-top',
                  ),
                ),
                Positioned(
                  top: Utils.height * 0.05,
                  left: Utils.width * 0.3,
                  child: CircleIconButton(
                    color: Color(0xffFC5345),
                    icon: FontAwesome.google,
                    animatedValue: 1 - selectedIndex.value,
                    onBoardingEnterAnimation: onBoardingEnterAnimation,
                    onPressed: () {
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text('Google')));
                    },
                    tag: 'Google-bottom',
                  ),
                ),
                Positioned(
                  top: Utils.height * 0.1,
                  left: Utils.width * 0.5,
                  child: CircleIconButton(
                    color: Color(0xff4C76BE),
                    icon: FontAwesome.facebook,
                    animatedValue: 1 - selectedIndex.value,
                    onBoardingEnterAnimation: onBoardingEnterAnimation,
                    onPressed: () {
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text('Facebook')));
                    },
                    tag: 'Facebook-bottom',
                  ),
                ),
                Positioned(
                  top: Utils.height * 0.15,
                  left: Utils.width * 0.7,
                  child: CircleIconButton(
                    color: Color(0xff00C7FF),
                    icon: FontAwesome.twitter,
                    animatedValue: 1 - selectedIndex.value,
                    onBoardingEnterAnimation: onBoardingEnterAnimation,
                    onPressed: () {
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text('Twitter')));
                    },
                    tag: 'Twitter-bottom',
                  ),
                ),
              ],
            );
          }),
    );
  }

  Widget _buildTopBubble(double diameter, double top, double right,
      LinearGradient linearGradient) {
    return Positioned(
      top: top,
      right: right,
      child: Transform(
        transform: Matrix4.diagonal3Values(
            onBoardingEnterAnimation.scaleTranslation.value,
            onBoardingEnterAnimation.scaleTranslation.value,
            0.0),
        child: Container(
            height: diameter,
            width: diameter,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(diameter / 2),
                gradient: linearGradient)),
      ),
    );
  }
}
