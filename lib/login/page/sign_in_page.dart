import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/bean/user.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../page_index.dart';
import 'forgot_password_page.dart';
import '../ui/submit_button.dart';
import '../../store/index.dart';

class SignInPage extends StatefulWidget {
  @override
  createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool isShowPassWord = false;
  bool isShowLoading = false;

  var _emailController = TextEditingController();
  var _pwdController = TextEditingController();

  /// 利用FocusNode和FocusScopeNode来控制焦点,
  ///
  /// 可以通过FocusNode.of(context)来获取widget树中默认的FocusScopeNode
  FocusNode passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 23),
      child: Stack(
        /// 注意这里要设置溢出如何处理，设置为visible的话，可以看到孩子，设置为clip的话，若溢出会进行裁剪
        overflow: Overflow.visible,
        alignment: Alignment.topCenter,
        children: <Widget>[
          Column(children: <Widget>[
            /// 创建表单
            _buildLoginTextForm(),

            /// 忘记密码
            Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: FlatButton(
                    color: Color(0x00000000),
                    shape: const StadiumBorder(),
                    onPressed: () {
                      pushNewPage(context, ForgotPasswordPage());
                    },
                    child: Text("忘记密码？",
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                            decoration: TextDecoration.underline)))),

            /// Or 横线
            Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          width: 100.0,
                          height: 1.0,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.white10, Colors.white]),
                          )),
                      Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 15.0),
                          child: Text('Or',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.white))),
                      Container(
                          width: 100.0,
                          height: 1.0,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.white, Colors.white10]),
                          ))
                    ])),

            /// 第三方登录按钮
            Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleButton(
                        icon: FontAwesome.weixin,
                        onPressedAction: () {
                          Toast.show(context, "微信");
                        },
                        iconSize: 25.0,
                      ),
                      SizedBox(width: 40.0),
                      CircleButton(
                        icon: FontAwesome.qq,
                        onPressedAction: () {
                          Toast.show(context, "QQ");
                        },
                        iconSize: 25.0,
                      ),
                    ]))
          ]),

          /// 登录按钮
          Padding(
              padding: const EdgeInsets.only(top: 148.0),
              child: SubmitButton(
                  title: "${S.of(context).login}",
                  onTap: () {
                    if (_emailController.text.isEmpty) {
                      Toast.show(context, "邮箱不能为空");
                    } else if (!Utils.isEmail(_emailController.text)) {
                      Toast.show(context, "邮箱格式不正确");
                    } else if (_pwdController.text.isEmpty) {
                      Toast.show(context, "密码不能为空");
                    } else if (_pwdController.text.length < 6) {
                      Toast.show(context, "密码长度不能小于6位！");
                    } else {
                      showLoadingDialog(context, '登录中...');
                      isShowLoading = true;
                      _login();
                    }
                  }))
        ],
      ),
    );
  }

  Widget _buildLoginTextForm() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        color: Colors.white,
      ),
      width: 300.0,

      /// Flutter提供了一个Form widget，它可以对输入框进行分组，然后进行一些统一操作，如输入内容校验、输入框重置以及输入内容保存。
      child: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            /// 邮箱输入框
            _buildEmailInput(),

            Container(
              width: 250.0,
              height: 1.0,
              color: Colors.grey[100],
              padding: const EdgeInsets.only(top: 10.0),
            ),

            /// 密码
            _buildPasswordInput(),

            Container(
              width: 250.0,
              height: 1.0,
              color: Colors.grey[100],
              margin: const EdgeInsets.only(bottom: 40.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailInput() {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 20.0),
      child: TextFormField(
        controller: _emailController,
        maxLines: 1,

        /// 输入类型
        keyboardType: TextInputType.emailAddress,

        /// 是否自动更正
        autocorrect: false,

        /// 是否自动获得焦点
        autofocus: false,

        /// 是否禁用textfield:如果为false, textfield将被“禁用”
        enabled: true,

        /// 键盘动作按钮点击之后执行的代码： 光标切换到指定的输入框
        onEditingComplete: () =>
            FocusScope.of(context).requestFocus(passwordFocusNode),
        decoration: InputDecoration(
          icon: Icon(Icons.email, color: Colors.black),
          hintText: "${S.of(context).email}",
          border: InputBorder.none,
        ),

        /// 文本样式
        style: TextStyle(fontSize: 16, color: Colors.black),
      ),
    );
  }

  Widget _buildPasswordInput() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 20),
      child: TextFormField(
        controller: _pwdController,
        keyboardType: TextInputType.text,

        /// 关联焦点
        focusNode: passwordFocusNode,

        /// 装饰器
        decoration: InputDecoration(
          icon: Icon(Icons.lock, color: Colors.black),
          hintText: "${S.of(context).password}",
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

        /// 控制键盘的功能键 指enter键，比如此处设置为next时，enter键显示的文字内容为 下一步
        textInputAction: TextInputAction.done,

        /// 最大行数
        maxLines: 1,

        /// 是否需要用******显示
        obscureText: !isShowPassWord,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black,
        ),
      ),
    );
  }

  void showPassword() {
    setState(() {
      isShowPassWord = !isShowPassWord;
    });
  }

  Future<void> _login() async {
//    User user = await ApiService.login(
//        _emailController.text.toString(), _pwdController.text.toString());
//
//    if (user != null) {
//      Store.value<UserModel>(context, listen: false)
//        ..setUser(
//          id: user.id,
//          email: '${user?.email}',
//          name: '${user.name}',
//          avatarPath: user.avatarUrl,
//          login: true,
//          mobile: user.mobile,
//        );
//      if (isShowLoading) {
//        Navigator.of(context).pop();
//      }
//      pushAndRemovePage(context, HomePage());
//    } else {
//      Toast.show(context, '登录失败');
//    }

    await HttpUtils().post(
        ApiUrl.LOGIN,
        (data) {
          User user = User.fromMap(data);

          Store.value<UserModel>(context, listen: false)
            ..setUser(
              id: user.id,
              email: '${user?.email}',
              name: '${user.name}',
              avatarPath: user.avatarUrl,
              login: true,
              mobile: user.mobile,
            );
          if (isShowLoading) {
            Navigator.of(context).pop();
          }
          pushAndRemovePage(context, HomePage());
        },
        params: {
          'email': _emailController.text.toString(),
          'password': _pwdController.text.toString()
        },
        errorCallBack: (error) {
          print(error);
          if (isShowLoading) {
            Navigator.of(context).pop();
          }
          Toast.show(context, error.message);
        });
  }
}
