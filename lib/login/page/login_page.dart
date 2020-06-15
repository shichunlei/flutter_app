import 'package:flutter/material.dart';
import 'package:flutter_app/enum/enum.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/login/page/sign_in_page.dart';
import 'package:flutter_app/login/page/sign_up_page.dart';
import 'package:flutter_app/ui/button.dart';
import 'package:flutter_app/ui/gradual_change_view.dart';

class LoginPage extends StatefulWidget {
  @override
  createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  PageController _controller;
  PageView _pageView;

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    _controller = PageController();
    _pageView = PageView(
      controller: _controller,
      children: <Widget>[
        SignInPage(),
        SignUpPage(),
      ],
      onPageChanged: (index) {
        setState(() => _currentPage = index);
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        GradualChangeView(
          colors: [Color(0xFFfbab66), Color(0xFFf7418c)],
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
        SingleChildScrollView(
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                    padding: const EdgeInsets.only(top: 55.0),
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          /// 上面图片
                          Hero(
                              tag: 'login_logo',
                              child: Image.network(
                                  'https://github.com/huextrat/TheGorgeousLogin/blob/master/assets/img/login_logo.png?raw=true',
                                  width: 157,
                                  height: 120)),

                          /// 指示器
                          _buildIndicator(),

                          /// PageView
                          Expanded(child: _pageView)
                        ]))))
      ]),
    );
  }

  Widget _buildIndicator() {
    return Container(
      width: 300.0,
      height: 42.0,
      margin: const EdgeInsets.only(top: 20.0),
      padding: const EdgeInsets.only(left: 2.0, right: 2.0),
      decoration: BoxDecoration(
        color: Color(0x552B2B2B),

        /// 圆角
        borderRadius: BorderRadius.all(
          Radius.circular(21.0),
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Button(
              onPressed: () => _controller.animateToPage(0,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.decelerate),
              child: Text('${S.of(context).login}',
                  style: TextStyle(fontSize: 18)),
              buttonShape: ButtonShape.Fillet,
              borderRadius: 30.0,
              textColor: _currentPage == 0 ? Colors.black54 : Colors.white,
              height: 35.0,
              color: _currentPage == 0 ? Colors.white : Colors.transparent,
            ),
          ),
          Expanded(
            child: Button(
              onPressed: () => _controller.animateToPage(1,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.decelerate),
              child: Text('${S.of(context).register}',
                  style: TextStyle(fontSize: 18)),
              buttonShape: ButtonShape.Fillet,
              borderRadius: 30.0,
              height: 35.0,
              textColor: _currentPage == 1 ? Colors.black54 : Colors.white,
              color: _currentPage == 1 ? Colors.white : Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
