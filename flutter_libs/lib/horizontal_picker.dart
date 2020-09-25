import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum InitialPosition { start, center, end }

enum CursorStyle { line, triangle }

class HorizontalPicker extends StatefulWidget {
  final double minValue, maxValue;
  final int divisions;
  final Function(double value) onChanged;
  final InitialPosition initialPosition;
  final Color backgroundColor;
  final bool showCursor;
  final Color cursorColor;
  final Color activeItemTextColor;
  final Color passiveItemsTextColor;
  final String suffix;
  final CursorStyle style;

  HorizontalPicker({
    @required this.minValue,
    @required this.maxValue,
    @required this.divisions,
    @required this.onChanged,
    this.initialPosition = InitialPosition.center,
    this.backgroundColor = Colors.white,
    this.showCursor = true,
    this.cursorColor = Colors.red,
    this.activeItemTextColor = Colors.blue,
    this.passiveItemsTextColor = Colors.grey,
    this.suffix,
    this.style: CursorStyle.line,
  })  : assert(minValue < maxValue),
        assert(onChanged != null),
        assert(divisions > 0);

  @override
  createState() => _HorizontalPickerState();
}

class _HorizontalPickerState extends State<HorizontalPicker> {
  List<double> valueList = [];
  FixedExtentScrollController _scrollController;
  int curItem;

  int selectedFontSize = 14;
  List<Map> valueMap = [];

  @override
  void initState() {
    super.initState();

    for (var i = 0; i <= widget.divisions; i++) {
      valueMap.add({
        "value": widget.minValue +
            ((widget.maxValue - widget.minValue) / widget.divisions) * i,
        "fontSize": 14.0,
        "color": widget.passiveItemsTextColor,
      });
    }
    setScrollController();
  }

  setScrollController() {
    int initialItem;
    switch (widget.initialPosition) {
      case InitialPosition.start:
        initialItem = 0;
        break;
      case InitialPosition.center:
        initialItem = (valueMap.length ~/ 2);
        break;
      case InitialPosition.end:
        initialItem = valueMap.length - 1;
        break;
    }

    _scrollController = FixedExtentScrollController(initialItem: initialItem);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      margin: EdgeInsets.all(20),
      height: 100,
      alignment: Alignment.center,
      child: Scaffold(
        backgroundColor: widget.backgroundColor,
        body: Stack(
          children: <Widget>[
            RotatedBox(
              quarterTurns: 3,
              child: ListWheelScrollView(
                  controller: _scrollController,
                  itemExtent: 60,
                  onSelectedItemChanged: (item) {
                    curItem = item;
                    setState(() {
                      int decimalCount = 1;
                      int fac = pow(10, decimalCount);
                      valueMap[item]["value"] =
                          (valueMap[item]["value"] * fac).round() / fac;
                      widget.onChanged(valueMap[item]["value"]);

                      for (var i = 0; i < valueMap.length; i++) {
                        if (i == item) {
                          valueMap[item]["color"] = widget.activeItemTextColor;
                          valueMap[item]["fontSize"] = 15.0;
                          valueMap[item]["hasBorders"] = true;
                        } else {
                          valueMap[i]["color"] = widget.passiveItemsTextColor;
                          valueMap[i]["fontSize"] = 14.0;
                          valueMap[i]["hasBorders"] = false;
                        }
                      }
                    });
                    setState(() {});
                  },
                  children: valueMap.map((Map curValue) {
                    return ItemWidget(curValue,
                        backgroundColor: widget.backgroundColor,
                        suffix: widget.suffix);
                  }).toList()),
            ),
            Visibility(
              visible: widget.showCursor,
              child: Container(
                alignment: Alignment.center,
                child: widget.style == CursorStyle.line
                    ? Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: widget.cursorColor.withOpacity(0.3)),
                        width: 3,
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.arrow_drop_down,
                              size: 30, color: widget.cursorColor),
                          Icon(
                            Icons.arrow_drop_up,
                            color: widget.cursorColor,
                            size: 30,
                          )
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  final Map curItem;
  final Color backgroundColor;
  final String suffix;

  ItemWidget(this.curItem, {Key key, this.backgroundColor, this.suffix})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int decimalCount = 1;
    int fac = pow(10, decimalCount);

    List<String> textParts =
        ((curItem["value"] * fac).round() / fac).toString().split(".");

    String leftText = textParts.first;
    String rightText = textParts.last;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: RotatedBox(
        quarterTurns: 1,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "|",
              style: TextStyle(fontSize: 8, color: curItem["color"]),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  leftText,
                  style: TextStyle(
                      fontSize: curItem["fontSize"],
                      color: curItem["color"],
                      fontWeight: curItem['rightText'] == "0"
                          ? FontWeight.w800
                          : FontWeight.w400),
                ),
                Text(
                  rightText == "0" ? "" : ".",
                  style: TextStyle(
                    fontSize: curItem["fontSize"] - 3,
                    color: curItem["color"],
                  ),
                ),
                Text(
                  rightText == "0" ? "" : rightText,
                  style: TextStyle(
                      fontSize: curItem["fontSize"] - 3,
                      color: curItem["color"]),
                ),
                (suffix == null)
                    ? SizedBox()
                    : Text(
                        suffix,
                        style: TextStyle(
                            fontSize: curItem["fontSize"],
                            color: curItem["color"]),
                      )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "|",
              style: TextStyle(fontSize: 8, color: curItem["color"]),
            ),
          ],
        ),
      ),
    );
  }
}
