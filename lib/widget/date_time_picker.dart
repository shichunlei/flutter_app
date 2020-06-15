import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../page_index.dart';

class DateTimePicker extends StatefulWidget {
  DateTimePicker({Key key}) : super(key: key);

  @override
  createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  DateTime _selectedDate;

  DateTime currentDate;

  @override
  void initState() {
    super.initState();

    _selectedDate = DateTime.now();

    currentDate = DateTime.now();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("日期时间控件")),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
              Widget>[
            Text(
                '当前选择了：${_selectedDate.year}年${_selectedDate.month}月${_selectedDate.day}日'),
            RaisedButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (_) {
                        return CalendarDatePicker(
                            onDateChanged: (DateTime value) {
                              setState(() {
                                _selectedDate = value;
                                Navigator.pop(context);
                              });
                            },
                            initialDate: DateTime.now(),
                            firstDate:
                                DateTime(currentDate.year, currentDate.month),
                            lastDate: DateTime(currentDate.year, 12, 31));
                      });
                },
                child: Text('DayPicker')),
            RaisedButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (_) {
                        return CalendarDatePicker(
                            firstDate: DateTime(2000),
                            lastDate: DateTime(currentDate.year, 12, 31),
                            onDateChanged: (DateTime value) {
                              setState(() {
                                _selectedDate = value;
                                Navigator.pop(context);
                              });
                            },
                            initialCalendarMode: DatePickerMode.year,
                            initialDate: DateTime.now());
                      });
                },
                child: Text('YearPicker')),
            RaisedButton(
                onPressed: () {
                  /// initialDate 初始化时间，通常情况下设置为当前时间。
                  /// firstDate 表示开始时间，不能选择此时间前面的时间。
                  /// lastDate 表示结束时间，不能选择此时间之后的时间。
                  /// selectableDayPredicate 参数定义用户的可选日期，返回false表示不可选，与DayPicker用法相同。
                  showDatePicker(
                    context: context,
                    firstDate: DateTime(currentDate.year),
                    // 初始选中日期
                    initialDate: currentDate,
                    // 可选日期范围第一个日期
                    lastDate: DateTime(currentDate.year, 12, 31),
                    // 可选日期范围最后一个日期
                    selectableDayPredicate: (dateTime) {
                      // 通过此方法可以过滤掉可选范围内不可选的特定日期
                      if (dateTime.day == 10 ||
                          dateTime.day == 20 ||
                          dateTime.day == 30) {
                        // 此处表示10号、20号、30号不可选
                        return false;
                      }
                      return true;
                    },
                    initialDatePickerMode:
                        DatePickerMode.day, // 初始化选择模式，有day和year两种
                  ).then((dateTime) {
                    // 选择日期后点击OK拿到的日期结果
                    debugPrint(
                        '当前选择了：${dateTime.year}年${dateTime.month}月${dateTime.day}日');
                  });
                },
                child: Text('DatePicker')),
            Gaps.vGap10,
            RaisedButton(
                child: Text('TimePicker', textAlign: TextAlign.center),
                onPressed: () {
                  showTimePicker(context: context, initialTime: TimeOfDay.now())
                      .then((timeOfDay) {
                    //选择时间后点击OK拿到的时间结果
                    if (timeOfDay == null) {
                      return;
                    }
                    debugPrint('当前选择了：${timeOfDay.hour}时${timeOfDay.minute}分');
                  });
                }),
            Gaps.vGap10,
            RaisedButton(
                child: Text('CupertinoDatePicker', textAlign: TextAlign.center),
                onPressed: () {
                  showCupertinoModalPopup(
                      context: context,
                      builder: (cxt) {
                        return Container(
                            height: 200,
                            child: CupertinoDatePicker(
                                onDateTimeChanged: (date) {
                                  debugPrint("当前日期、时间 ${date.toString()}");
                                },
                                initialDateTime: DateTime(1994),
                                use24hFormat: true));
                      });
                }),
            Gaps.vGap10,
            RaisedButton(
                child:
                    Text('CupertinoTimerPicker', textAlign: TextAlign.center),
                onPressed: () {
                  showCupertinoModalPopup(
                      context: context,
                      builder: (cxt) {
                        return Container(
                            height: 200,
                            child: CupertinoTimerPicker(
                                onTimerDurationChanged: (duration) {
                              debugPrint('当前时间 $duration');
                            }));
                      });
                })
          ]),
        ));
  }
}
