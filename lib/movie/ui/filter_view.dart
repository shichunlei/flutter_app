import 'package:flutter/material.dart';
import 'package:flutter_app/bean/condition.dart';
import 'package:flutter_app/page_index.dart';

class FilterView extends StatelessWidget {
  final Function(
          double min, double max, String feature, bool playable, bool unwatched)
      onPressed;
  final RangeValues rangeValues;
  final String feature;
  final bool playable;
  final bool unwatched;

  FilterView({
    Key key,
    this.onPressed,
    this.feature: "",
    this.rangeValues: const RangeValues(0.0, 10.0),
    this.playable: false,
    this.unwatched: false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _continuousValues = rangeValues;
    var feature = this.feature;
    bool _isPlayable = playable;
    bool _unwatched = unwatched;
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Material(
          type: MaterialType.transparency,
          child: ListView(
            padding: EdgeInsets.all(10.0),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                    '评分(${_continuousValues.start.toStringAsFixed(1)}~${_continuousValues.end.toStringAsFixed(1)})'),
              ),
              RangeSlider(
                  values: _continuousValues,
                  min: 0.0,
                  max: 10.0,
                  divisions: 20,
                  onChanged: (RangeValues values) {
                    setState(() {
                      _continuousValues = values;
                    });
                  },
                  labels: RangeLabels(
                      '${_continuousValues.start.toStringAsFixed(1)}',
                      '${_continuousValues.end.toStringAsFixed(1)}')),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text('特色'),
              ),
              Wrap(
                spacing: 8,
                children: features.map((item) {
                  return ChoiceChip(
                      label: Text(item.title,
                          style: TextStyle(color: Colors.white)),
                      selected: item.title == feature,
                      backgroundColor: Colors.grey[500],
                      selectedColor: Utils.strToColor(item.title),
                      onSelected: (bool isCheck) =>
                          setState(() => feature = isCheck ? item.title : ""));
                }).toList(),
              ),
              SwitchListTile(
                  title: Text('可播放'),
                  value: _isPlayable,
                  onChanged: (onState) {
                    setState(() => _isPlayable = onState);
                  }),
              CheckboxListTile(
                title: Text('我没看过'),
                value: _unwatched,
                onChanged: (checked) {
                  setState(() => _unwatched = checked);
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Button(
                        onPressed: () {
                          onPressed(
                              double.parse(
                                  _continuousValues.start.toStringAsFixed(1)),
                              double.parse(
                                  _continuousValues.end.toStringAsFixed(1)),
                              feature,
                              _isPlayable,
                              _unwatched);
                        },
                        child: Text('提交', style: TextStyle(fontSize: 18)),
                        halfRadius: true,
                      ),
                    ),
                    Gaps.hGap10,
                    Expanded(
                      child: Button(
                        onPressed: () {
                          feature = "";
                          _isPlayable = false;
                          _unwatched = false;
                          setState(() {
                            _continuousValues = RangeValues(0.0, 10.0);
                          });
                        },
                        child: Text('重置', style: TextStyle(fontSize: 18)),
                        halfRadius: true,
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
