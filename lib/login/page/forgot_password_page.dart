import 'package:flutter/material.dart';
import 'package:flutter_app/login/ui/identity_code_view.dart';
import 'package:flutter_app/login/ui/submit_button.dart';

import '../../page_index.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({Key key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  var _mobileController = TextEditingController();
  var _codeController = TextEditingController();

  FocusNode codeFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _mobileController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GradualChangeView(
              colors: [Color(0xFFfbab66), Colors.blue, Color(0xFFf7418c)],
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              rotation: Rotation.BR2TL),
          SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(top: 55.0),
                child: Column(
                  children: <Widget>[
                    /// 上面图片
                    Hero(
                        tag: 'login_logo',
                        child: Image.network(
                            'https://github.com/huextrat/TheGorgeousLogin/blob/master/assets/img/login_logo.png?raw=true',
                            width: 157,
                            height: 120)),
                    Padding(
                        padding: const EdgeInsets.only(top: 53),
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              _buildMobileTextForm(),

                              /// 登录按钮
                              Padding(
                                  padding: const EdgeInsets.only(top: 48.0),
                                  child:
                                      SubmitButton(title: "提交", onTap: () {}))
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileTextForm() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(
            width: 1.0 / MediaQuery.of(context).devicePixelRatio,
            color: Colors.white),
      ),
      width: 300.0,
      child: Form(
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
              child: TextFormField(
                controller: _mobileController,
                maxLines: 1,
                keyboardType: TextInputType.phone,
                autocorrect: false,
                autofocus: false,
                enabled: true,
                onEditingComplete: () =>
                    FocusScope.of(context).requestFocus(codeFocusNode),
                decoration: InputDecoration(
                  hintText: "请输入手机号码",
                  border: InputBorder.none,
                  hintStyle: TextStyle(fontSize: 16, color: Colors.white),
                ),
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            Divider(
              height: 1.0,
              color: Colors.white,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
              child: TextFormField(
                controller: _codeController,
                focusNode: codeFocusNode,
                maxLines: 1,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "请输入验证码",
                  border: InputBorder.none,
                  hintStyle: TextStyle(fontSize: 16, color: Colors.white),
                  suffixIcon: IdentityCodeView(
                    padding: EdgeInsets.only(top: 10.0),
                    seconds: 10,
                    available: true,
                    onTapCallback: () {
                      Toast.show(context, '获取验证码');
                    },
                  ),
                ),
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
