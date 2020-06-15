import 'package:flutter/material.dart';
import 'package:flutter_app/generated/i18n.dart';

import '../page_index.dart';

class LogonPage extends StatefulWidget {
  LogonPage({Key key}) : super(key: key);

  @override
  createState() => _LogonPageState();
}

class _LogonPageState extends State<LogonPage>
    with SingleTickerProviderStateMixin {
  LoginMode mode;

  AnimationController _animationController;
  Animation<double> _curvedAnimation;

  TextEditingController userController;
  TextEditingController pwdController;
  TextEditingController pwdAgainController;
  FocusNode pwdFocus;
  FocusNode pwdAgainFocus;

  @override
  void initState() {
    super.initState();

    userController = TextEditingController();
    pwdController = TextEditingController();
    pwdAgainController = TextEditingController();
    pwdFocus = FocusNode();
    pwdAgainFocus = FocusNode();

    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _curvedAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _animationController?.dispose();
    userController?.dispose();
    pwdController?.dispose();
    pwdAgainController?.dispose();
    super.dispose();
  }

  void _flip(bool reverse) {
    if (_animationController.isAnimating) return;
    if (reverse) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        AspectRatio(
            aspectRatio: 1.5,
            child: GradualChangeView(
                colors: [Color(0xFFfbab66), Color(0xFFf7418c)],
                child: Image.asset('images/flutter_logo.png',
                    width: 60, height: 60),
                alignment: Alignment.center)),
        Center(
            child: Padding(
                padding: EdgeInsets.all(15),
                child: FlipView(
                    animationController: _curvedAnimation,
                    front: _buildLoginView(),
                    back: _buildRegisterView())))
      ]),
    );
  }

  Widget _buildLoginView() {
    return Container(
      padding: EdgeInsets.all(25),
      decoration: ShapeDecoration(
        color: Colors.blue,
        shadows: [
          BoxShadow(
            color: Color(0xFFEEEEEE),
            blurRadius: 9,
            spreadRadius: 3,
          )
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(1),
            bottomRight: Radius.circular(1),
            topRight: Radius.elliptical(25, 25),
            bottomLeft: Radius.elliptical(25, 25),
          ),
        ),
      ),
      height: 240,
      child: Column(
        children: <Widget>[
          _buildFormView(LoginMode.LOGIN),
          Button(
            width: 110,
            onPressed: () {
              _flip(true);
            },
            child:
                Text('${S.of(context).login}', style: TextStyle(fontSize: 18)),
            textColor: Colors.lightBlue,
            color: Colors.white,
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
      width: double.infinity,
    );
  }

  Widget _buildRegisterView() {
    return Container(
      padding: EdgeInsets.all(25),
      decoration: ShapeDecoration(
        color: Colors.green,
        shadows: [
          BoxShadow(
            color: Color(0xFFEEEEEE),
            blurRadius: 9,
            spreadRadius: 3,
          )
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(1),
            bottomRight: Radius.circular(1),
            topRight: Radius.elliptical(25, 25),
            bottomLeft: Radius.elliptical(25, 25),
          ),
        ),
      ),
      height: 290,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          _buildFormView(LoginMode.REGIST),
          Button(
            width: 110,
            onPressed: () {
              _flip(false);
            },
            buttonShape: ButtonShape.OUTLINE,
            child: Text('${S.of(context).register}',
                style: TextStyle(fontSize: 18)),
            textColor: Colors.white,
            color: Colors.transparent,
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }

  Widget _buildFormView(LoginMode mode) {
    return Column(
      children: <Widget>[
        /// 用户名
        Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(Icons.account_circle, color: Colors.white),
            ),
            Expanded(
              child: TextField(
                onSubmitted: (String str) {
                  FocusScope.of(context).requestFocus(pwdFocus);
                },
                textInputAction: TextInputAction.next,
                controller: userController,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Colors.white),
                decoration: InputDecoration(
                  hintText: '${S.of(context).username}',
                  hintStyle: TextStyle(fontSize: 16, color: Colors.white54),
                  contentPadding: EdgeInsets.only(top: 10, bottom: 4),
                ),
              ),
            )
          ],
        ),
        Gaps.vGap15,

        /// 密码
        Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(Icons.lock, color: Colors.white),
            ),
            Expanded(
              child: TextField(
                onSubmitted: (String str) {
                  if (mode == LoginMode.REGIST) {
                    FocusScope.of(context).requestFocus(pwdAgainFocus);
                  }
                },
                textInputAction: mode == LoginMode.LOGIN
                    ? TextInputAction.done
                    : TextInputAction.next,
                focusNode: pwdFocus,
                controller: pwdController,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Colors.white),
                decoration: InputDecoration(
                  hintText: '${S.of(context).password}',
                  hintStyle: TextStyle(fontSize: 16, color: Colors.white54),
                  contentPadding: EdgeInsets.only(top: 10, bottom: 4),
                ),
              ),
            )
          ],
        ),

        /// 确认密码
        Offstage(
          offstage: mode != LoginMode.REGIST,
          child: Padding(
            padding: EdgeInsets.only(top: 15),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Icon(Icons.lock, color: Colors.white),
                ),
                Expanded(
                  child: TextField(
                    focusNode: pwdAgainFocus,
                    controller: pwdAgainController,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: Colors.white),
                    decoration: InputDecoration(
                      hintText: '${S.of(context).confirmPassword}',
                      hintStyle: TextStyle(fontSize: 16, color: Colors.white54),
                      contentPadding: EdgeInsets.only(top: 10, bottom: 4),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
      mainAxisSize: MainAxisSize.min,
    );
  }
}
