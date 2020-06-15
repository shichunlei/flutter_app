import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../page_index.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isCheck = false;

  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller1?.dispose();
    _controller2?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LightTheme(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 50),
            child: Column(children: <Widget>[
              Icon(Icons.phone_iphone, size: 80, color: Colors.grey[200]),
              Gaps.vGap40,
              Container(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Column(children: <Widget>[
                  TextField(
                      keyboardType: TextInputType.phone,
                      controller: _controller1,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              right: 15.0, left: 15, top: 10, bottom: 10),
                          hintText: '请输入手机号码',
                          hintStyle: TextStyles.textGreyC14,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none),
                          filled: true,
                          fillColor: Colors.grey[200]),
                      style: TextStyle(color: Color(0xFF6A6C7A), fontSize: 14)),
                  Gaps.vGap10,
                  Stack(children: <Widget>[
                    TextField(
                        keyboardType: TextInputType.number,
                        controller: _controller2,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                                right: 15.0, left: 15, top: 10, bottom: 10),
                            hintText: '请输入验证码',
                            hintStyle: TextStyles.textGreyC14,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide.none),
                            filled: true,
                            fillColor: Colors.grey[200]),
                        style:
                            TextStyle(color: Color(0xFF6A6C7A), fontSize: 14)),
                    Positioned(
                        child: Text('获取验证码', style: TextStyles.textReader14),
                        right: 20,
                        top: 10,
                        bottom: 10)
                  ]),
                  Gaps.vGap10,
                  Button(
                      child: Text("登录", style: TextStyle(fontSize: 18)),
                      color: readerMainColor,
                      height: 40,
                      borderRadius: 20,
                      onPressed: () {}),
                  LineViewLine(
                      child: Text('  其他登录方式  ', style: TextStyles.textGrey14),
                      horizontalPadding: 30,
                      verticalPadding: 30,
                      lineColor: Colors.grey),
                  Row(children: <Widget>[
                    IconButton(
                        icon: Icon(FontAwesome.qq, color: readerMainColor),
                        onPressed: () {}),
                    IconButton(
                        icon: Icon(FontAwesome.weixin, color: readerMainColor),
                        onPressed: () {}),
                    IconButton(
                        icon: Icon(FontAwesome.weibo, color: readerMainColor),
                        onPressed: () {}),
                    IconButton(
                        icon: Icon(FontAwesome.renren, color: readerMainColor),
                        onPressed: () {})
                  ], mainAxisAlignment: MainAxisAlignment.spaceEvenly)
                ]),
              ),
              Gaps.vGap20,
              Row(children: <Widget>[
                Checkbox(
                    value: isCheck,
                    onChanged: (value) => setState(() => isCheck = value),
                    activeColor: readerMainColor),
                Text('已阅读并同意《用户协议》和《用户隐私保护政策》', style: TextStyles.textGrey12),
              ], mainAxisAlignment: MainAxisAlignment.center),
              Gaps.vGap20,
              InkWell(
                  child: Text('随便看看 >', style: TextStyles.textReader14),
                  onTap: () {})
            ]),
          ),
        ),
      ),
    );
  }
}
