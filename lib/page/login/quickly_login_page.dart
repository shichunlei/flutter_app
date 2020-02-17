import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/generated/i18n.dart';

import '../../page_index.dart';
import 'register_page.dart';
import 'reset_password_page.dart';

class QuicklyLoginPage extends StatefulWidget {
  QuicklyLoginPage({Key key}) : super(key: key);

  @override
  createState() => _QuicklyLoginPageState();
}

class _QuicklyLoginPageState extends State<QuicklyLoginPage> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _vCodeController = TextEditingController();

  final FocusNode _nodePhone = FocusNode();
  final FocusNode _nodeVCode = FocusNode();

  bool _isClick = false;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_verify);
    _vCodeController.addListener(_verify);

    setState(() => _phoneController.text = SpUtil.getString('login_phone'));
  }

  void _verify() {
    String name = _phoneController.text;
    String vCode = _vCodeController.text;
    if (name.isEmpty || name.length < 11) {
      setState(() => _isClick = false);
      return;
    }
    if (vCode.isEmpty || vCode.length < 6) {
      setState(() => _isClick = false);
      return;
    }

    setState(() => _isClick = true);
  }

  @override
  void dispose() {
    _phoneController?.dispose();
    _vCodeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LightTheme(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(leading: CloseButton()),
          body: SingleChildScrollView(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("${S.of(context).quickly_login}",
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
                        controller: _vCodeController,
                        maxLength: 6,
                        keyboardType: TextInputType.number,
                        hintText: "${S.of(context).input_v_code}",
                        getVCode: () {
                          Toast.show(context, '${S.of(context).get_v_code}');
                        }),
                    Gaps.vGap10,
                    Container(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                            text: TextSpan(
                                text: '${S.of(context).tip}',
                                style: TextStyles.textGrey14,
                                children: <TextSpan>[
                              TextSpan(
                                text: '${S.of(context).register}',
                                style: TextStyle(color: Colors.redAccent),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () =>
                                      pushNewPage(context, RegisterPage()),
                              ),
                              TextSpan(text: '。')
                            ]))),
                    Gaps.vGap25,
                    Button(
                      borderRadius: 0,
                      onPressed: _isClick ? _login : null,
                      child: Text('${S.of(context).login}',
                          style: TextStyle(fontSize: 18)),
                    ),
                    Gaps.vGap10,
                    Container(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                            child: Padding(
                                child: Text('${S.of(context).forgot_password}',
                                    style: TextStyles.textGrey14),
                                padding: EdgeInsets.all(10)),
                            onTap: () =>
                                pushNewPage(context, ResetPasswordPage())))
                  ]))),
    );
  }

  void _login() async {
    SpUtil.setString('login_phone', _phoneController.text);

    Navigator.pop(context);
  }
}
