import 'package:flutter/material.dart';
import 'package:flutter_app/generated/l10n.dart';
import 'package:rounded_letter/rounded_letter.dart';
import 'package:rounded_letter/shape_type.dart';

import '../page_index.dart';

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

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          key: _scaffoldKey,
          //backgroundColor: Theme.of(context).primaryColor,
          body: Stack(
            children: <Widget>[
              CustomPaint(
                painter: _Background(),
                size: Size(Utils.width, Utils.height),
              ),
              Column(
                children: <Widget>[
                  Padding(
                    child: Builder(
                      builder: (context) => Button(
                          child: Text("${S.of(context).login}",
                              style: TextStyle(fontSize: 18)),
                          color: Colors.white,
                          textColor: Theme.of(context).primaryColor,
                          onPressed: () => _loginSheet(context)),
                    ),
                    padding: EdgeInsets.only(top: 300, left: 20, right: 20),
                  ),
                  Padding(
                    child: Button(
                      child: Text("${S.of(context).register}",
                          style: TextStyle(fontSize: 18)),
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
                          child: Text("${S.of(context).login}",
                              style: TextStyle(fontSize: 18)),
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
                child: Text("${S.of(context).register}",
                    style: TextStyle(fontSize: 18)),
                color: Color(0xFFF4511E),
                onPressed: _registerUser),
          ),
        ]),
      );
    });
  }

  //login and register fuctions

  void _loginUser() {
    closeBottomSheet();
  }

  void _registerUser() {
    closeBottomSheet();
  }

  void closeBottomSheet() {
    Navigator.of(context).pop();
    _emailController?.clear();
    _passwordController?.clear();
    _nameController?.clear();
  }
}

class _Background extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset(0.0, 0.0) & Size(size.width, size.height);
    var paint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 2.0
      ..shader = LinearGradient(
        colors: [Colors.yellow[800], Colors.red],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        tileMode: TileMode.clamp,
      ).createShader(rect)
      ..style = PaintingStyle.fill;

    /// 整体背景。从右上角到左下角颜色渐变为[Colors.yellow[800], Colors.red],
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    paint
      ..shader = LinearGradient(
              colors: [
            Colors.yellow.withOpacity(1.0),
            Colors.red.withOpacity(1.0)
          ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              tileMode: TileMode.clamp)
          .createShader(rect);

    var path1 = Path()
      ..moveTo(size.width * 1, size.height)
      ..lineTo(size.width * 0, size.height);

    var endPoint1 = Offset(5 * size.width / 4, 4 * size.height / 4);
    var ctlPoint1 = Offset(4.5 * size.width / 4, 2.5 * size.height / 4);
    path1.quadraticBezierTo(
        ctlPoint1.dx, ctlPoint1.dy, endPoint1.dx, endPoint1.dy);

    canvas.drawPath(path1, paint);

    paint
      ..shader = LinearGradient(
              colors: [
            Colors.red.withOpacity(0.2),
            Colors.yellow[800].withOpacity(0.3)
          ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              tileMode: TileMode.clamp)
          .createShader(rect);

    var path = Path()
      ..moveTo(size.width * 0, size.height)
      ..lineTo(size.width, size.height);
    var endPoint = Offset(0 * size.width / 4, 4 * size.height / 4);
    var ctlPoint = Offset(0.2 * size.width / 4, 3 * size.height / 4);
    path.quadraticBezierTo(ctlPoint.dx, ctlPoint.dy, endPoint.dx, endPoint.dy);

    canvas.drawPath(path, paint);

    var path2 = Path()
      ..moveTo(size.width, 0.0)
      ..lineTo(size.width, size.height)
      ..lineTo(0.0, size.height)
      ..lineTo(0.0, size.height + 5);
    var secondControlPoint = Offset(size.width - (size.width / 6), size.height);
    var secondEndPoint = Offset(size.width, 0.0);
    path2.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    canvas.drawPath(path2, paint);

    paint
      ..shader = LinearGradient(
              colors: [
            Colors.white,
            Colors.white,
          ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              tileMode: TileMode.clamp)
          .createShader(rect);
    canvas.drawCircle(Offset(size.width / 2, 160), 50, paint);
    canvas.drawCircle(Offset(size.width / 2.5, 240), 20, paint);
    canvas.drawCircle(Offset(size.width / 1.5, 200), 10, paint);
    canvas.drawCircle(Offset(size.width / 1.7, 210), 3, paint);
    canvas.drawOval(Rect.fromLTWH(70, 450, 45, 25), paint);

    // 文字左上角起始点
    Offset offset = Offset(size.width / 2 - 50, 125.0);

    drawText(canvas, 'GO', offset,
        color: Colors.red,
        fontSize: 65.0,
        fontWeight: FontWeight.bold,
        width: 100);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
