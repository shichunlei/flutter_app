import 'package:flutter/material.dart';

class HorizontalNumberPicker extends StatefulWidget {
  final double width;
  final double height;

  HorizontalNumberPicker({Key key, this.width = 300, this.height = 100})
      : super(key: key);

  @override
  createState() => _HorizontalNumberPickerState();
}

class _HorizontalNumberPickerState extends State<HorizontalNumberPicker>
    with SingleTickerProviderStateMixin {
  double sliderPadding = 50;
  double _sliderPercent = 0;
  double _sliderPosition = 0;

  final int minValue = 0;
  final int maxValue = 100;

  Animation<double> _animation;
  AnimationController _animationController;

  void _updatePosition(Offset offSet) {
    double newPosition;

    if (offSet.dx <= 0) {
      newPosition = 0;
    } else if (offSet.dx >= widget.width - sliderPadding) {
      newPosition = widget.width - sliderPadding;
    } else {
      newPosition = offSet.dx;
    }

    setState(() {
      _sliderPosition = newPosition;
      _sliderPercent = newPosition / widget.width - sliderPadding;
    });
  }

  void _horizontalDragStart(BuildContext context, DragStartDetails details) {
    RenderBox box = context.findRenderObject();
    Offset offset = box.globalToLocal(details.globalPosition);

    _animationController.forward();

    _updatePosition(offset);
  }

  void _horizontalDragUpdate(BuildContext context, DragUpdateDetails details) {
    RenderBox box = context.findRenderObject();
    Offset offset = box.globalToLocal(details.globalPosition);
    _updatePosition(offset);
  }

  void _horizontalDragEnd(DragEndDetails details) {
    _animationController.reverse();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _animation = Tween<double>(begin: 0, end: 15).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.linear));
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: GestureDetector(
        onHorizontalDragStart: (d) => _horizontalDragStart(context, d),
        onHorizontalDragUpdate: (d) => _horizontalDragUpdate(context, d),
        onHorizontalDragEnd: _horizontalDragEnd,
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (c, ch) {
            return Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                    left: 0,
                    bottom: widget.height / 5.5,
                    child: Text("$minValue")),
                Positioned(
                    right: 0,
                    bottom: widget.height / 5.5,
                    child: Text("$maxValue")),
                Container(
                  width: widget.width - sliderPadding,
                  height: widget.height - sliderPadding,
                  child: CustomPaint(
                    painter: LinePainter(
                        minValue: minValue,
                        maxValue: maxValue,
                        indicatorMargin: _animation.value,
                        dragPercent: _sliderPercent,
                        sliderPosition: _sliderPosition),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  double sliderPosition;
  final double dragPercent;
  final Paint linePainter;
  final Paint indicatorPainter;
  final TextPainter minValuePainter;
  final TextPainter maxValuePainter;
  final TextPainter selectedValuePainter;

  final int minValue;
  final int maxValue;
  static int _selectedValue = 0;
  final double indicatorMargin;

  LinePainter(
      {this.maxValue,
      this.minValue,
      this.indicatorMargin,
      this.sliderPosition,
      this.dragPercent})
      : selectedValuePainter = TextPainter(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: "$_selectedValue",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.45 + indicatorMargin,
                )))
          ..textDirection = TextDirection.ltr,
        maxValuePainter = TextPainter(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: "$maxValue",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                )))
          ..textDirection = TextDirection.ltr,
        minValuePainter = TextPainter(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: "$minValue",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                )))
          ..textDirection = TextDirection.ltr,
        indicatorPainter = Paint()
          ..color = Colors.black
          ..style = PaintingStyle.fill,
        linePainter = Paint()
          ..color = Colors.grey
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.9;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(0, size.height / 2);

    _selectedValue = (sliderPosition / size.width * 100).toInt();

    double controlHeight = indicatorMargin;
    double bezierWidth = 40.0;
    double bendWidth = 40.0;
    double indicatorRadius = 8.5;

    double centerPoint = sliderPosition;
    centerPoint = centerPoint > size.width ? size.width : centerPoint;

    double startBend = sliderPosition - bendWidth / 2;
    double startOfBezier = startBend - bezierWidth;
    double endBend = sliderPosition + bendWidth / 2;
    double endOfBezier = endBend + bezierWidth;
    double lcp1 = startBend;
    double lcp2 = startBend;
    double rcp1 = endBend;
    double rcp2 = endBend;

    startBend = (startBend <= 0.0) ? 0.0 : startBend;
    startOfBezier = (startOfBezier <= 0.0) ? 0.0 : startOfBezier;
    endBend = (endBend >= size.width) ? size.width : endBend;
    endOfBezier = (endOfBezier >= size.width) ? size.width : endOfBezier;

    Path p = Path();
    p.moveTo(-25, 0);
    p.lineTo(startOfBezier, 0);

    p.cubicTo(lcp1, 0, lcp2, -controlHeight, centerPoint, -controlHeight);
    p.cubicTo(rcp1, -controlHeight, rcp2, 0, endOfBezier, 0);
    p.lineTo(size.width + 25, 0);
    canvas.drawPath(p, linePainter);

    canvas.drawCircle(Offset(sliderPosition, 24.5 - indicatorMargin),
        indicatorRadius, indicatorPainter);

    selectedValuePainter.layout();
    selectedValuePainter.paint(
        canvas,
        Offset((sliderPosition - indicatorRadius),
            -42 - indicatorMargin - controlHeight));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
