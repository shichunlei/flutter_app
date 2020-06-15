import 'package:flutter/material.dart';
import 'package:flutter_app/generated/i18n.dart';
import '../../../page_index.dart';
import '../component/trapezoid_down_cut.dart';

class SignInTab extends StatelessWidget {
  final Function onPressed;

  SignInTab({@required this.onPressed});

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
        padding: EdgeInsets.only(
            top: size.height * 0.0,
            left: size.width * 0.05,
            right: size.width * 0.05,
            bottom: size.width * 0.05),
        child: Stack(children: <Widget>[
          TrapezoidDownCut(
            child: Material(
                elevation: 16,
                color: Colors.white,
                child: Container(
                    height: double.infinity,
                    child: _buildForm(context, size, textTheme))),
          ),
          Positioned(
              bottom: 24,
              right: 12,
              child: FloatingActionButton(
                  heroTag: 'login',
                  backgroundColor: Colors.pinkAccent,
                  mini: true,
                  child: Icon(Icons.arrow_upward, color: Colors.white),
                  onPressed: onPressed))
        ]));
  }

  Widget _buildForm(BuildContext context, Size size, TextTheme textTheme) {
    return Padding(
        padding: EdgeInsets.only(top: size.height * 0.05, left: 24, right: 24),
        child: SingleChildScrollView(
            child: Form(
                key: formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.1),
                          child: Center(
                              child: Text("LOGO",
                                  style: textTheme.headline4.copyWith(
                                      color: Colors.black.withOpacity(0.6))))),
                      Gaps.vGap48,
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.1),
                          child: _buildTextFormEmail(context, textTheme)),
                      Gaps.vGap24,
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.1),
                          child: _buildTextFormPassword(context, textTheme)),
                      Gaps.vGap48,
                      Align(
                          alignment: FractionalOffset.center,
                          child: Button(
                              width: 150,
                              child: Text("${S.of(context).login}",
                                  style: TextStyle(fontSize: 18)),
                              onPressed: onPressed,
                              color: Color(0xFFFE685F)))
                    ]))));
  }

  Widget _buildTextFormEmail(BuildContext context, TextTheme textTheme) {
    return TextFormField(
        style: textTheme.headline6
            .copyWith(color: Colors.black87, letterSpacing: 1.2),
        decoration: InputDecoration(
            hintText: '${S.of(context).email}',
            hintStyle: textTheme.subtitle1
                .copyWith(color: Colors.black.withOpacity(0.6)),
            suffixIcon: Icon(Icons.email, color: Colors.grey)),
        keyboardType: TextInputType.emailAddress,
        controller: userNameController,
        validator: (val) => val.length == 0
            ? '${S.of(context).EMAIL_AUTH_VALIDATION_EMPTY}'
            : val.length < 10
                ? '${S.of(context).EMAIL_AUTH_VALIDATION_INVALID}'
                : null);
  }

  Widget _buildTextFormPassword(BuildContext context, TextTheme textTheme) {
    return TextFormField(
        style: textTheme.headline6
            .copyWith(color: Colors.black87, letterSpacing: 1.2),
        decoration: InputDecoration(
            hintText: '${S.of(context).password}',
            hintStyle: textTheme.subtitle1
                .copyWith(color: Colors.black.withOpacity(0.6)),
            suffixIcon: Icon(Icons.lock, color: Colors.grey)),
        keyboardType: TextInputType.text,
        controller: passwordController,
        obscureText: true,
        validator: (val) => val.length == 0
            ? '${S.of(context).EMAIL_AUTH_VALIDATION_EMPTY}'
            : val.length < 10
                ? '${S.of(context).EMAIL_AUTH_VALIDATION_INVALID}'
                : null);
  }
}
