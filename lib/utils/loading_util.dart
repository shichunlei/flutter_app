import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/custom_widgets/animated_rotation_box.dart';
import 'package:flutter_app/custom_widgets/gradient_circular_progress_indicator.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<Widget> widgets = [
  SpinKitThreeBounce(color: Utils.strToColor('ThreeBounce'), size: 30.0),
  SpinKitCircle(color: Utils.strToColor('Circle')),
  SpinKitChasingDots(color: Utils.strToColor('ChasingDots')),
  SpinKitRotatingCircle(color: Utils.strToColor('RotatingCircle')),
  SpinKitRotatingPlain(color: Utils.strToColor('RotatingPlain')),
  SpinKitPumpingHeart(color: Utils.strToColor('PumpingHeart')),
  SpinKitPulse(color: Utils.strToColor('Pulse')),
  SpinKitDoubleBounce(color: Colors.grey),
  SpinKitWave(color: Colors.blue, type: SpinKitWaveType.start),
  SpinKitWave(color: Colors.red, type: SpinKitWaveType.center),
  SpinKitWave(color: Colors.pink, type: SpinKitWaveType.end),
  SpinKitWanderingCubes(color: Colors.teal),
  SpinKitWanderingCubes(color: Colors.lightBlue, shape: BoxShape.circle),
  SpinKitFadingFour(color: Colors.lightBlueAccent),
  SpinKitFadingFour(color: Colors.lightGreen, shape: BoxShape.rectangle),
  SpinKitFadingCube(color: Colors.lightGreenAccent),
  SpinKitCubeGrid(size: 51.0, color: Colors.lime),
  SpinKitFoldingCube(color: Colors.limeAccent),
  SpinKitRing(color: Colors.teal),
  SpinKitDualRing(color: Colors.tealAccent),
  SpinKitRipple(color: Colors.pinkAccent),
  SpinKitFadingGrid(color: Colors.pinkAccent),
  SpinKitFadingGrid(color: Colors.purple, shape: BoxShape.rectangle),
  SpinKitHourGlass(color: Colors.purpleAccent),
  SpinKitSpinningCircle(color: Colors.deepOrange),
  SpinKitSpinningCircle(color: Colors.deepPurple, shape: BoxShape.rectangle),
  SpinKitFadingCircle(color: Colors.deepPurpleAccent),
  SpinKitPouringHourglass(color: Colors.indigo),
  CupertinoActivityIndicator(animating: false),
  CircularProgressIndicator(backgroundColor: Colors.greenAccent),
  AnimatedRotationBox(
      child: GradientCircularProgressIndicator(
          radius: 15.0,
          colors: [Colors.red[300], Colors.orange, Colors.grey[50]],
          value: .8,
          backgroundColor: Colors.transparent)),
  AnimatedRotationBox(
      child: GradientCircularProgressIndicator(
          radius: 15.0,
          colors: [Colors.red, Colors.red],
          value: .7,
          backgroundColor: Colors.transparent)),
  AnimatedRotationBox(
      duration: Duration(milliseconds: 800),
      child: GradientCircularProgressIndicator(
          radius: 15.0,
          colors: [Colors.blue, Colors.lightBlue[50]],
          value: .8,
          backgroundColor: Colors.transparent,
          strokeCapRound: true)),
  // Icon
  AnimatedRotationBox(
      duration: Duration(milliseconds: 800), child: Icon(Icons.loop)),
  AnimatedRotationBox(
      duration: Duration(milliseconds: 800), child: Icon(Icons.refresh)),
  AnimatedRotationBox(
      duration: Duration(milliseconds: 800),
      child: Icon(
        FontAwesomeIcons.spinner,
        color: Colors.purpleAccent,
      )),
  AnimatedRotationBox(
    child: GradientCircularProgressIndicator(
        colors: [
          Colors.red,
          Colors.amber,
          Colors.cyan,
          Colors.green[200],
          Colors.blue,
          Colors.red
        ],
        radius: 60.0,
        stokeWidth: 5.0,
        strokeCapRound: true,
        backgroundColor: Colors.transparent,
        value: 1.0),
  ),
];

showLoadingDialog(BuildContext context, String text) async {
  showDialog<Null>(
      context: context, //BuildContext对象
      barrierDismissible: false,
      builder: (BuildContext context) {
        /// 调用对话框
        return LoadingDialogWidget(text: text);
      });
}

class LoadingDialogWidget extends Dialog {
  final String text;

  LoadingDialogWidget({
    Key key,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getLoadingWidget(text: text, bgColor: Colors.white);
  }
}

Widget getLoadingWidget(
    {String text: '加载中...', Color bgColor: const Color(0x4b000000)}) {
  return Material(

      /// 透明
      type: MaterialType.transparency,

      /// 保证控件居中显示
      child: Center(
          child: Container(
              width: 120.0,
              height: 120.0,
              decoration: ShapeDecoration(
                  color: bgColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)))),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(
                        child: widgets[Random().nextInt(widgets.length - 1)]),
                    Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text(text, style: TextStyle(fontSize: 12.0)))
                  ]))));
}
