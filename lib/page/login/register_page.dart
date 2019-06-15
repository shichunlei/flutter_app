import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../page_index.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  /// 定义一个controller
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _vCodeController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isClick = false;

  @override
  void initState() {
    super.initState();

    /// 监听输入改变
    _phoneController.addListener(_verify);
    _vCodeController.addListener(_verify);
    _passwordController.addListener(_verify);
  }

  void _verify() {
    String name = _phoneController.text;
    String vCode = _vCodeController.text;
    String password = _passwordController.text;
    if (name.isEmpty || name.length < 11) {
      setState(() {
        _isClick = false;
      });
      return;
    }
    if (vCode.isEmpty || vCode.length < 6) {
      setState(() {
        _isClick = false;
      });
      return;
    }
    if (password.isEmpty || password.length < 6) {
      setState(() {
        _isClick = false;
      });
      return;
    }

    setState(() {
      _isClick = true;
    });
  }

  @override
  void dispose() {
    _phoneController?.dispose();
    _vCodeController?.dispose();
    _passwordController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            elevation: 0,
            leading: BackButton(),
            backgroundColor: Colors.white),
        body: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("${AppLocalizations.$t('register')}",
                      style: TextStyle(
                          fontSize: Dimens.font_sp26,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  Gaps.vGap16,
                  CustomTextField(
                      controller: _phoneController,
                      maxLength: 11,
                      keyboardType: TextInputType.phone,
                      hintText: "${AppLocalizations.$t('input_phone')}"),
                  Gaps.vGap10,
                  CustomTextField(
                      controller: _vCodeController,
                      keyboardType: TextInputType.number,
                      getVCode: () {},
                      maxLength: 6,
                      hintText: "${AppLocalizations.$t('input_v_code')}"),
                  Gaps.vGap10,
                  CustomTextField(
                      isInputPwd: true,
                      controller: _passwordController,
                      maxLength: 16,
                      hintText: "${AppLocalizations.$t('input_password')}"),
                  Gaps.vGap25,
                  Button(
                      borderRadius: 0,
                      onPressed: _isClick ? _register : null,
                      text: "${AppLocalizations.$t('submit')}")
                ])));
  }

  void _register() {}
}
