import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class LabRadioFirstView extends StatefulWidget {
  final Question genderQuestion;
  final Question slideQuestion;
  final Function(bool value, String choice, double slider) callBack;

  LabRadioFirstView({
    Key key,
    @required this.genderQuestion,
    @required this.slideQuestion,
    this.callBack,
  }) : super(key: key);

  @override
  createState() => _LabRadioFirstViewState();
}

class _LabRadioFirstViewState extends State<LabRadioFirstView> {
  String choice = "";
  double sliderValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 8, bottom: 15),
            child: Text(
              '${widget.genderQuestion?.content}',
              style: TextStyles.textDark16,
            ),
          ),
          Container(
            color: Colors.grey[400],
            padding: EdgeInsets.all(15),
            child: Row(
              children: <Widget>[
                ChoiceChip(
                  label: Text(
                    '${widget.genderQuestion != null ? widget.genderQuestion?.options[0]?.title : ""}',
                    style: TextStyles.textDark16,
                  ),
                  selected: choice == "0",
                  backgroundColor: qdailyMinorColor,
                  selectedColor: qdailyMajorColor,
                  onSelected: (value) {
                    setState(() {
                      choice = value ? "0" : "";
                    });
                  },
                ),
                ChoiceChip(
                  label: Text(
                    '${widget.genderQuestion != null ? widget.genderQuestion?.options[1]?.title : ""}',
                    style: TextStyles.textDark16,
                  ),
                  selected: choice == "1",
                  backgroundColor: qdailyMinorColor,
                  selectedColor: qdailyMajorColor,
                  onSelected: (value) {
                    setState(() {
                      choice = value ? "1" : "";
                    });
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15, bottom: 15),
            child: Text(
              '${widget.slideQuestion?.content}',
              style: TextStyles.textDark16,
            ),
          ),
          Slider(
            value: sliderValue,
            onChanged: (double value) {
              setState(() {
                sliderValue = value;
              });
            },
            max: widget.slideQuestion?.maxScore ?? 10,
            min: 0,
            divisions: 100,
          ),
          Row(
            children: <Widget>[
              Text(
                '${widget.slideQuestion?.options?.first?.title ?? ""}',
                style: TextStyles.textBoldDark16,
              ),
              Text(
                '${widget.slideQuestion?.options?.elementAt(1)?.title ?? ""}',
                style: TextStyles.textBoldDark16,
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          Gaps.vGap5,
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '${widget.slideQuestion != null ? widget.slideQuestion?.options?.first?.content : ""}',
                    style: TextStyles.textGrey14,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                ),
              ),
              Gaps.hGap20,
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '${widget.slideQuestion != null ? widget.slideQuestion?.options[1]?.content : ""}',
                    style: TextStyles.textGrey14,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          Gaps.vGap20,
          Button(
            onPressed: choice != "" && choice.length > 0 && sliderValue > 0
                ? () =>
                    setState(() => widget.callBack(true, choice, sliderValue))
                : null,
            child: Text("下一步", style: TextStyle(fontSize: 18)),
            textColor: Colors.black54,
            halfRadius: true,
            color: qdailyMajorColor,
            disabledColor: qdailyMinorColor,
          ),
          Gaps.vGap40
        ],
      ),
    );
  }
}
