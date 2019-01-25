import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

List<Widget> widgets = [
  SpinKitThreeBounce(color: Colors.redAccent, size: 30.0),
  SpinKitCircle(color: Colors.greenAccent),
  SpinKitChasingDots(color: Colors.blueAccent),
  SpinKitRotatingCircle(color: Colors.orangeAccent),
  SpinKitRotatingPlain(color: Colors.brown),
  SpinKitPumpingHeart(color: Colors.blueGrey),
  SpinKitPulse(color: Colors.orange),
  SpinKitDoubleBounce(color: Colors.grey),
  SpinKitWave(color: Colors.blue, type: SpinKitWaveType.start),
  SpinKitWave(color: Colors.red, type: SpinKitWaveType.center),
  SpinKitWave(color: Colors.black12, type: SpinKitWaveType.end),
  SpinKitWanderingCubes(color: Colors.black26),
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
];

Widget getLoadingWidget() {
  int index = 0;
  index = Random().nextInt(widgets.length - 1);
  return widgets[index];
}

showLoadingDialog(BuildContext context, String text) {
  showDialog<Null>(
      context: context, //BuildContext对象
      barrierDismissible: false,
      builder: (BuildContext context) {
        /// 调用对话框
        return LoadingDialogWidget(text: text);
      });
}

class LoadingDialogWidget extends Dialog {
  String text;

  LoadingDialogWidget({
    Key key,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      /// 透明
      type: MaterialType.transparency,

      /// 保证控件居中显示
      child: Center(
        child: SizedBox(
          width: 120.0,
          height: 120.0,
          child: Container(
            decoration: ShapeDecoration(
              color: Color(0xFFFFFFFF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    8.0,
                  ),
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                getLoadingWidget(),
                Padding(
                  padding: EdgeInsets.only(
                    top: 20.0,
                  ),
                  child: Text(
                    this.text,
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
