import 'package:flutter/material.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:rounded_letter/rounded_letter.dart';
import 'package:rounded_letter/shape_type.dart';

import '../../page_index.dart';
import 'background.dart';

/// 参考：https://github.com/pr-Mais/login_ui
class BottomSheetLoginPage extends StatefulWidget {
  BottomSheetLoginPage({Key key}) : super(key: key);

  @override
  createState() => _BottomSheetLoginPagePageState();
}

class _BottomSheetLoginPagePageState extends State<BottomSheetLoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  String _email;
  String _password;
  String _displayName;

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: Scaffold(
          resizeToAvoidBottomPadding: true,
          key: _scaffoldKey,
          //backgroundColor: Theme.of(context).primaryColor,
          body: Stack(
            children: <Widget>[
              CustomPaint(
                painter: Background(),
                size: Size(Utils.width, Utils.height),
              ),
              Column(
                children: <Widget>[
                  Padding(
                    child: Builder(
                      builder: (context) => Button(
                          text: "${S.of(context).login}",
                          color: Colors.white,
                          textColor: Theme.of(context).primaryColor,
                          onPressed: () => _loginSheet(context)),
                    ),
                    padding: EdgeInsets.only(top: 300, left: 20, right: 20),
                  ),
                  Padding(
                    child: Button(
                      text: "${S.of(context).register}",
                      color: Colors.white,
                      onPressed: _registerSheet,
                      textColor: Theme.of(context).primaryColor,
                    ),
                    padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.stretch,
              ),
            ],
          )),
      data: ThemeData().copyWith(

          /// TODO 将canvasColor设置为透明，BottomSheet弹出框上部分圆角才会起作用
          canvasColor: Colors.transparent,
          brightness: Brightness.dark),
    );
  }

  void _loginSheet(BuildContext context) {
    showBottomSheet(
        context: context,
        builder: (builder) {
          return BottomSheetView(
              showClose: true,
              hasAppBar: false,
              closeOnTap: () => closeBottomSheet(),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 140,
                    child: RoundedLetter(
                      text: "${S.of(context).login}",
                      shapeColor: Colors.blue,
                      shapeType: ShapeType.circle,
                      borderColor: Colors.blueAccent,
                      borderWidth: 1,
                      shapeSize: 130,
                      fontSize: 48,
                      fontBold: true,
                      key: Key("clickable_circle"),
                      clickListener: SampleClickListener(),
                    ),
                  ),
                  Gaps.vGap60,
                  CTextField(
                      icon: Icons.email,
                      hintText: "${S.of(context).email}",
                      controller: _emailController),
                  Gaps.vGap20,
                  CTextField(
                      icon: Icons.lock,
                      hintText: "${S.of(context).password}",
                      controller: _passwordController,
                      obscure: true),
                  Gaps.vGap40,
                  Container(
                      padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Button(
                          text: "${S.of(context).login}",
                          color: Theme.of(context).primaryColor,
                          onPressed: _loginUser))
                ],
              ));
        });
  }

  void _registerSheet() {
    _scaffoldKey.currentState.showBottomSheet<void>((BuildContext context) {
      return BottomSheetView(
        hasAppBar: false,
        showClose: true,
        closeOnTap: () => closeBottomSheet(),
        child: Column(children: <Widget>[
          Container(
            height: 140,
            child: RoundedLetter(
              text: "${S.of(context).register}",
              shapeColor: Color(0xFFF4511E),
              shapeType: ShapeType.circle,
              borderColor: Color(0xFFBF360C),
              borderWidth: 1,
              shapeSize: 130,
              fontSize: 48,
              fontBold: true,
              key: Key("clickable_circle"),
              clickListener: SampleClickListener(),
            ),
          ),
          Gaps.vGap40,
          CTextField(
              icon: Icons.account_circle,
              hintText: "${S.of(context).username}",
              controller: _nameController),
          Gaps.vGap20,
          CTextField(
              icon: Icons.email,
              hintText: "${S.of(context).email}",
              controller: _emailController),
          Gaps.vGap20,
          CTextField(
              icon: Icons.lock,
              hintText: "${S.of(context).password}",
              controller: _passwordController,
              obscure: true),
          Gaps.vGap20,
          Container(
            padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Button(
                text: "${S.of(context).register}",
                color: Color(0xFFF4511E),
                onPressed: _registerUser),
          ),
        ]),
      );
    });
  }

  //login and register fuctions

  void _loginUser() {
    _email = _emailController.text;
    _password = _passwordController.text;
    closeBottomSheet();
  }

  void _registerUser() {
    _email = _emailController.text;
    _password = _passwordController.text;
    _displayName = _nameController.text;
    closeBottomSheet();
  }

  void closeBottomSheet() {
    Navigator.of(context).pop();
    _emailController?.clear();
    _passwordController?.clear();
    _nameController?.clear();
  }
}
