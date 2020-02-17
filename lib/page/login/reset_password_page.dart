import 'package:flutter/material.dart';
import 'package:flutter_app/generated/i18n.dart';

import '../../page_index.dart';

class ResetPasswordPage extends StatefulWidget {
  ResetPasswordPage({Key key}) : super(key: key);

  @override
  createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  /// 定义一个controller
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _vCodeController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final FocusNode _nodePhone = FocusNode();
  final FocusNode _nodeVCode = FocusNode();
  final FocusNode _nodePassword = FocusNode();

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
    return LightTheme(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(leading: BackButton()),
          body: SingleChildScrollView(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("${S.of(context).reset_password}",
                        style: TextStyles.textBoldDark26),
                    Gaps.vGap16,
                    CustomTextField(
                        focusNode: _nodePhone,
                        nextFocusNode: _nodeVCode,
                        controller: _phoneController,
                        maxLength: 11,
                        keyboardType: TextInputType.phone,
                        hintText: "${S.of(context).input_phone}"),
                    Gaps.vGap10,
                    CustomTextField(
                        focusNode: _nodeVCode,
                        nextFocusNode: _nodePassword,
                        controller: _vCodeController,
                        keyboardType: TextInputType.number,
                        getVCode: () {},
                        maxLength: 6,
                        hintText: "${S.of(context).input_v_code}"),
                    Gaps.vGap10,
                    CustomTextField(
                        focusNode: _nodePassword,
                        isInputPwd: true,
                        controller: _passwordController,
                        maxLength: 16,
                        hintText: "${S.of(context).input_password}"),
                    Gaps.vGap25,
                    Button(
                      borderRadius: 0,
                      onPressed: _isClick ? _reset : null,
                      child: Text('${S.of(context).submit}',
                          style: TextStyle(fontSize: 18)),
                    )
                  ]))),
    );
  }

  void _reset() {}
}
