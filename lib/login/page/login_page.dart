import 'package:flutter/material.dart';
import 'package:flutter_app/login/page/sign_in_page.dart';
import 'package:flutter_app/login/page/sign_up_page.dart';
import 'package:flutter_app/login/style/theme.dart' as theme;
import 'package:flutter_app/login/ui/custom_button.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
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
        Container(

            /// 这里需要手动获取Container的宽高，不然显示不了，利用MediaQuery可以获取跟屏幕相关的参数
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,

            /// 设置渐变背景
            decoration: BoxDecoration(gradient: theme.Theme.primaryGradient)),
        SingleChildScrollView(
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                    padding: const EdgeInsets.only(top: 55.0),
                    child: Column(mainAxisSize: MainAxisSize.max, children: <
                        Widget>[
                      /// 上面图片
                      Image.asset('images/login_logo.png',
                          width: 157, height: 120),

                      /// 指示器
                      Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Container(
                              width: 300.0,
                              height: 42.0,
                              padding:
                                  const EdgeInsets.only(left: 2.0, right: 2.0),
                              decoration: BoxDecoration(
                                  color: Color(0x552B2B2B),

                                  /// 圆角
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(21.0))),
                              child: Row(children: <Widget>[
                                Expanded(
                                    child: CustomButton(
                                        onPressed: () =>
                                            _controller.animateToPage(0,
                                                duration:
                                                    Duration(milliseconds: 300),
                                                curve: Curves.decelerate),
                                        title: "登录",
                                        status: _currentPage == 0)),
                                Expanded(
                                    child: CustomButton(
                                        onPressed: () =>
                                            _controller.animateToPage(1,
                                                duration:
                                                    Duration(milliseconds: 300),
                                                curve: Curves.decelerate),
                                        title: "注册",
                                        status: _currentPage == 1))
                              ]))),

                      /// pageview
                      Expanded(child: _pageView)
                    ]))))
      ]),
    );
  }
}
