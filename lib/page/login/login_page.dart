import 'package:flutter/material.dart';

import 'package:keyboard_actions/keyboard_actions.dart';

import '../../page_index.dart';
import 'quickly_login_page.dart';
import 'register_page.dart';
import 'reset_password_page.dart';

class PasswordLoginPage extends StatefulWidget {
  PasswordLoginPage({Key key}) : super(key: key);

  @override
  createState() => _LoginPageState();
}

class _LoginPageState extends State<PasswordLoginPage> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final FocusNode _nodePhone = FocusNode();
  final FocusNode _nodePassword = FocusNode();

  bool _isClick = false;

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
        keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
        keyboardBarColor: Colors.grey[200],
        nextFocus: true,
        actions: [
          KeyboardAction(
              focusNode: _nodePhone,
              closeWidget: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text("${AppLocalizations.$t('close')}"))),
          KeyboardAction(
              focusNode: _nodePassword,
              closeWidget: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text("${AppLocalizations.$t('close')}")))
        ]);
  }

  @override
  void initState() {
    super.initState();

    /// 监听输入改变
    _phoneController.addListener(_verify);
    _passwordController.addListener(_verify);
    setState(() => _phoneController.text = SPUtil.getString('login_phone'));
  }

  void _verify() {
    String name = _phoneController.text;
    String password = _passwordController.text;
    if (name.isEmpty || name.length < 11) {
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
    _passwordController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: CloseButton(),
          actions: <Widget>[
            InkWell(
                child: Container(
                  child: Text('${AppLocalizations.$t('quickly_login')}',
                      style: TextStyle(color: Color(0xff222222))),
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 10, right: 10),
                ),
                onTap: () => pushReplacement(context, QuicklyLoginPage()))
          ]),
      body: Utils.isIOS
          ? FormKeyboardActions(child: _buildBodyView())
          : SingleChildScrollView(child: _buildBodyView()),
    );
  }

  Widget _buildBodyView() {
    return Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(AppLocalizations.$t('password_login'),
                  style: TextStyle(
                      fontSize: Dimens.font_sp26,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              Gaps.vGap16,
              CustomTextField(
                  focusNode: _nodePhone,
                  controller: _phoneController,
                  maxLength: 11,
                  nextFocusNode: _nodePassword,
                  keyboardType: TextInputType.phone,
                  hintText: "${AppLocalizations.$t('input_phone')}"),
              Gaps.vGap10,
              CustomTextField(
                  focusNode: _nodePassword,
                  config: _buildConfig(context),
                  isInputPwd: true,
                  controller: _passwordController,
                  maxLength: 16,
                  hintText: "${AppLocalizations.$t('input_password')}"),
              Gaps.vGap25,
              Button(
                  onPressed: _isClick ? _login : null,
                  text: "${AppLocalizations.$t('login')}",
                  borderRadius: 0),
              Gaps.vGap16,
              Container(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                      child: Padding(
                          child: Text(
                              '${AppLocalizations.$t('forgot_password')}',
                              style: TextStyle(
                                  fontSize: Dimens.font_sp16,
                                  color: Colors.grey)),
                          padding: EdgeInsets.all(10)),
                      onTap: () => pushNewPage(context, ResetPasswordPage()))),
              Gaps.vGap6,
              Container(
                  alignment: Alignment.center,
                  child: InkWell(
                      child: Padding(
                          child: Text('${AppLocalizations.$t('go_register')}',
                              style: TextStyle(color: Colors.blueAccent)),
                          padding: EdgeInsets.all(10)),
                      onTap: () => pushNewPage(context, RegisterPage())))
            ]));
  }

  void _login() {
    SPUtil.putString('login_phone', _phoneController.text);

    Navigator.pop(context);
  }
}
