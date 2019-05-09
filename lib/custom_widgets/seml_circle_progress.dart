import 'package:flutter/material.dart';
import 'package:flutter_app/custom_widgets/utils.dart';

class SemlCircleProgress extends StatefulWidget {
  final double progress; // 进度 0～1
  final Color progressColor; // 进度条主色
  final Color arcColor; // 圆弧颜色
  final double strokeWidth; // 进度条宽度
  final int duration; // 动画时长
  final String lable;
  final Color lableColor; // 进度文字颜色
  final double lableFontSize;
  final String topLable; // 进度下面的文字
  final Color topLableColor; // 进度上面的文字颜色
  final double angle; // 圆弧夹角

  SemlCircleProgress(
      {Key key,
      @required this.progress,
      this.progressColor,
      this.arcColor,
      this.duration = 1000,
      this.strokeWidth = 10.0,
      this.topLable,
      this.lableColor,
      this.topLableColor,
      this.lable,
      this.lableFontSize = 30.0,
      this.angle = 270})
      : assert(progress >= 0 && progress <= 1),
        super(key: key);

  @override
  createState() => _SemlCircleProgressState();
}

class _SemlCircleProgressState extends State<SemlCircleProgress>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.duration),
        upperBound: widget.progress)
      ..addListener(() => setState(() {}))
      ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _SemlCircleProgressPainter(
          widget.angle,
          _controller.value,
          widget.progressColor ?? Colors.redAccent,
          widget.arcColor ?? Colors.white,
          widget.strokeWidth),
      child: Center(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Offstage(
                offstage: widget.topLable == null,
                child: Column(children: <Widget>[
                  Text('${widget.topLable ?? ''}',
                      style: TextStyle(
                          color: widget.topLableColor ?? Colors.white,
                          fontSize: 14.0)),
                  SizedBox(height: 10.0)
                ]),
              ),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        '${widget.lable ?? (_controller.value * 100).toStringAsFixed(0)}',
                        style: TextStyle(
                            color: widget.lableColor ?? Colors.white,
                            fontSize: widget.lableFontSize)),
                    Offstage(
                      offstage: widget.lable != null,
                      child: Column(children: <Widget>[
                        SizedBox(width: 5.0),
                        Text(
                          '%',
                          style: TextStyle(
                              color: widget.lableColor ?? Colors.white,
                              fontSize: 18.0),
                        )
                      ]),
                    ),
                  ]),
            ]),
      ),
    );
  }
}

class _SemlCircleProgressPainter extends CustomPainter {
  final double angle;
  final progress;
  final Color progressColor;
  final Color arcColor;
  final double strokeWidth;

  _SemlCircleProgressPainter(this.angle, this.progress, this.progressColor,
      this.arcColor, this.strokeWidth)
      : assert(progress >= 0 && progress <= 1);

  @override
  void paint(Canvas canvas, Size size) {
    // 画布大小（取画布宽、高中小的那个值）
    final canvasWidth = size.width > size.height ? size.height : size.width;
    // 圆心坐标
    final center = Offset(size.width / 2, size.height / 2);
    // 进度条宽度
    final progressStrokeWidth = strokeWidth;
    // 圆环宽度
    final arcStrokeWidth = strokeWidth;
    // 圆环半径
    final arcRadius = canvasWidth / 2 - arcStrokeWidth / 2;
    // 进度条角度
    final progressAngle = angle * progress;
    // 进度条弧度
    final double radians = degToRad(progressAngle);
    // 起始弧度
    final double startRadians = degToRad(-90 - angle / 2);
    // 结束弧度
    final double endRadians = degToRad(angle);

    final rect = Rect.fromCircle(center: center, radius: arcRadius);

    // 定义一个背景圆环的画笔
    final arcPaint = Paint()
      ..color = arcColor // 画笔颜色
      ..style = PaintingStyle.stroke // 绘制模式，画线 or 充满
      ..strokeWidth = arcStrokeWidth
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;

    // 绘制进度条圆弧
    canvas.drawArc(rect, startRadians, endRadians, false, arcPaint);

    // 定义一个进度路径的画笔
    final progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = progressStrokeWidth // 线条宽度
      ..isAntiAlias = true //是否启动抗锯齿
      ..color = progressColor
      ..strokeCap = StrokeCap.round; // 线条结束时的绘制样式

    // 绘制进度条圆弧
    canvas.drawArc(rect, startRadians, radians, false, progressPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
