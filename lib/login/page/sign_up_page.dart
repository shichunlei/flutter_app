import 'package:flutter/material.dart';
import 'package:flutter_app/login/ui/submit_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../page_index.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isShowPassWord = false;
  bool isShowRePassWord = false;

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode rePasswordFocusNode = FocusNode();

  var _usernameController = TextEditingController();
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var _repasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 23),
      child: Container(
        child: Stack(
          /// 注意这里要设置溢出如何处理，设置为visible的话，可以看到孩子，设置为clip的话，若溢出会进行裁剪
          overflow: Overflow.visible,
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Colors.white),
              width: 300.0,
              child: Form(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  /// 用户名
                  _buildUserNameInput(),

                  Container(
                      width: 250.0,
                      height: 1.0,
                      color: Colors.grey[100],
                      padding: const EdgeInsets.only(top: 10.0)),

                  /// 邮箱
                  buildEmailInput(),
                  Container(
                      width: 250.0,
                      height: 1.0,
                      color: Colors.grey[100],
                      padding: const EdgeInsets.only(top: 10.0)),

                  /// 密码
                  _buildPassswordInput(),
                  Container(
                      width: 250.0,
                      height: 1.0,
                      color: Colors.grey[100],
                      padding: const EdgeInsets.only(top: 10.0)),

                  /// 确认密码
                  _buildRePasswordInput(),
                  Container(
                      width: 250.0,
                      height: 1.0,
                      color: Colors.grey[100],
                      margin: const EdgeInsets.only(bottom: 40.0))
                ],
              )),
            ),

            /// 注册按钮
            Padding(
                padding: const EdgeInsets.only(top: 285.0),
                child: SubmitButton(
                    title: "注册",
                    onTap: () {
                      if (_usernameController.text.isEmpty) {
                        Toast.show(context, "用户名不能为空");
                      } else if (_emailController.text.isEmpty) {
                        Toast.show(context, "邮箱不能为空");
                      } else if (!Utils.isEmail(_emailController.text)) {
                        Toast.show(context, "邮箱格式不正确");
                      } else if (_passwordController.text.isEmpty) {
                        Toast.show(context, "密码不能为空");
                      } else if (_passwordController.text.length < 6) {
                        Toast.show(context, "密码长度不能小于6位！");
                      } else if (_repasswordController.text.toString() !=
                          _passwordController.text.toString()) {
                        Toast.show(context, "两次密码不一致");
                      } else {
                        _regist();
                      }
                    }))
          ],
        ),
      ),
    );
  }

  void showPassword() {
    setState(() {
      isShowPassWord = !isShowPassWord;
    });
  }

  Widget _buildUserNameInput() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 20.0),
      child: TextFormField(
        controller: _usernameController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        onEditingComplete: () =>
            FocusScope.of(context).requestFocus(emailFocusNode),
        decoration: InputDecoration(
          icon: Icon(
            FontAwesomeIcons.userAlt,
            color: Colors.black,
            size: 20,
          ),
          hintText: "请输入用户名",
          border: InputBorder.none,
        ),
        style: TextStyle(fontSize: 16, color: Colors.black),
      ),
    );
  }

  Widget buildEmailInput() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 20.0),
      child: TextFormField(
        controller: _emailController,
        focusNode: emailFocusNode,
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        onEditingComplete: () =>
            FocusScope.of(context).requestFocus(passwordFocusNode),
        decoration: InputDecoration(
          icon: Icon(Icons.email, color: Colors.black),
          hintText: "请输入邮箱",
          border: InputBorder.none,
        ),
        style: TextStyle(fontSize: 16, color: Colors.black),
      ),
    );
  }

  Widget _buildPassswordInput() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 20),
      child: TextFormField(
        controller: _passwordController,
        keyboardType: TextInputType.text,
        focusNode: passwordFocusNode,
        decoration: InputDecoration(
          icon: Icon(Icons.lock, color: Colors.black),
          hintText: "请输入密码",
          border: InputBorder.none,
          suffixIcon: IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(
                isShowPassWord
                    ? CustomIcon.show_password
                    : CustomIcon.hidden_password,
                color: Colors.black),
            onPressed: () => showPassword(),
          ),
        ),
        onEditingComplete: () =>
            FocusScope.of(context).requestFocus(rePasswordFocusNode),
        maxLines: 1,
        obscureText: !isShowPassWord,
        style: TextStyle(fontSize: 16.0, color: Colors.black),
      ),
    );
  }

  Widget _buildRePasswordInput() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 20),
      child: TextFormField(
        controller: _repasswordController,
        keyboardType: TextInputType.text,
        focusNode: rePasswordFocusNode,
        decoration: InputDecoration(
          icon: Icon(Icons.lock, color: Colors.black),
          hintText: "请确认输入密码",
          border: InputBorder.none,
          suffixIcon: IconButton(
            color: Theme.of(context).primaryColor,
            icon: Icon(
                isShowPassWord
                    ? CustomIcon.show_password
                    : CustomIcon.hidden_password,
                color: Colors.black),
            onPressed: () => showPassword(),
          ),
        ),
        textInputAction: TextInputAction.done,
        maxLines: 1,
        obscureText: !isShowPassWord,
        style: TextStyle(fontSize: 16.0, color: Colors.black),
      ),
    );
  }

  void _regist() async {
    Toast.show(context, "注册");
  }
}
