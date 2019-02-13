import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/custom_widgets/rich_alert/rich_alert_dialog.dart';

class DialogWidget extends StatefulWidget {
  @override
  createState() => new DialogWidgetState();
}

class DialogWidgetState extends State<DialogWidget> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle dialogTextStyle =
        theme.textTheme.subhead.copyWith(color: theme.textTheme.caption.color);

    return Scaffold(
      appBar: AppBar(title: Text("Dialog Widget")),
      floatingActionButton: FloatingActionButton(
          onPressed: () => showDialog(
              context: context,
              builder: (context) => RichAlertDialog(
                  title: richTitle("Alert title"),
                  subtitle: richSubtitle("Subtitle"),
                  type: RichAlertType.WARNING,
                  actions: <Widget>[Text("hello"), Text("its me")])),
          backgroundColor: Colors.redAccent,
          child: const Icon(Icons.add, semanticLabel: 'Add')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 22.0),
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('提示'),
                    //标题
                    titlePadding: EdgeInsets.all(20),
                    //标题的padding值
                    content: Text(
                      '是否想放弃学习Flutter',
                      style: dialogTextStyle,
                    ),
                    //弹框展示主要内容
                    contentPadding: EdgeInsets.only(left: 20, right: 20),
                    //内容的padding值
                    actions: <Widget>[
                      //操作按钮数组
                      FlatButton(
                        onPressed: () {
                          print("取消");
                          Navigator.pop(context);
                        },
                        child: Text('取消'),
                      ),
                      FlatButton(
                        onPressed: () {
                          print('确定');
                          Navigator.pop(context);
                        },
                        child: Text('确定'),
                      ),
                    ],
                  );
                },
                barrierDismissible: false,
              );
            },
            child: Text("AlertDialog"),
          ),
          Divider(),
          RaisedButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      title: Text('Info', style: dialogTextStyle), //标题
                      titlePadding: EdgeInsets.all(20), //标题的padding值
                      children: <Widget>[
                        DialogItem(
                            icon: Icons.account_circle,
                            color: theme.primaryColor,
                            text: 'username@gmail.com',
                            onPressed: () {
                              Navigator.pop(context, 'username@gmail.com');
                            }),
                        DialogItem(
                            icon: Icons.account_circle,
                            color: theme.primaryColor,
                            text: 'user02@gmail.com',
                            onPressed: () {
                              Navigator.pop(context, 'user02@gmail.com');
                            }),
                        DialogItem(
                            icon: Icons.add_circle,
                            text: 'add account',
                            color: theme.disabledColor),
                      ],
                      contentPadding: EdgeInsets.all(0),
                    );
                  });
            },
            child: Text("SimpleDialog"),
          ),
          Divider(),
          RaisedButton(
            onPressed: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.parse("20181209"),
                // 初始选中日期
                firstDate: DateTime.parse("20181109"),
                // 可选日期范围第一个日期
                lastDate: DateTime.parse("20190109"),
                // 可选日期范围最后一个日期
                selectableDayPredicate: (dateTime) {
                  //通过此方法可以过滤掉可选范围内不可选的特定日期
                  if (dateTime.day == 10 ||
                      dateTime.day == 20 ||
                      dateTime.day == 30) {
                    //此处表示10号、20号、30号不可选
                    return false;
                  }
                  return true;
                },
                initialDatePickerMode: DatePickerMode.day, //初始化选择模式，有day和year两种
              ).then((dateTime) {
                //选择日期后点击OK拿到的日期结果
                print(
                    '当前选择了：${dateTime.year}年${dateTime.month}月${dateTime.day}日');
              });
            },
            child: Text("DatePicker"),
          ),
          Divider(),
          RaisedButton(
            onPressed: () {
              showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(), //初始化显示时间
              ).then((timeOfDay) {
                //选择时间后点击OK拿到的时间结果
                if (timeOfDay == null) {
                  return;
                }
                print('当前选择了：${timeOfDay.hour}时${timeOfDay.minute}分');
              });
            },
            child: Text("TimePicker"),
          ),
          Divider(),
          RaisedButton(
            onPressed: () {
              showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                        child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Text(
                                'This is the modal bottom sheet. Tap anywhere to dismiss.',
                                textAlign: TextAlign.center,
                                style: dialogTextStyle)));
                  });
            },
            child: Text("Modal bottom sheet"),
          ),
          Divider(),
          RaisedButton(
            onPressed: () {
              showBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(color: theme.disabledColor))),
                        child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Text(
                                'This is the modal bottom sheet. Tap anywhere to dismiss.',
                                textAlign: TextAlign.center,
                                style: dialogTextStyle)));
                  }).closed.whenComplete(() {});
            },
            child: Text("Persistent bottom sheet"),
          ),
          Divider(),
          CupertinoButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: Text('提示'),
                      //弹框标题
                      content: Text('是否想放弃学习Flutter', style: dialogTextStyle),
                      //弹框内容
                      actions: <Widget>[
                        //操作控件
                        CupertinoDialogAction(
                          onPressed: () {
                            //控件点击监听
                            print("我不会放弃的");
                            Navigator.pop(context, "取消");
                          },
                          child: Text('取消'), //控件显示内容
                          isDefaultAction: true,
                        ),
                        CupertinoDialogAction(
                          onPressed: () {
                            print("我投降");
                            Navigator.pop(context, "确定");
                          },
                          child: Text('确定'),
                          isDestructiveAction: true,
                        ),
                      ],
                    );
                  });
            },
            child: Text("CupertinoAlertDialog"),
            color: CupertinoColors.activeBlue,
          ),
          Divider(),
          CupertinoButton(
            child: const Text('Alert with Title'),
            color: CupertinoColors.activeBlue,
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 36.0),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                      title: Text(
                          'Allow "Maps" to access your location while you are using the app?',
                          style: dialogTextStyle),
                      content: Text(
                          'Your current location will be displayed on the map and used '
                          'for directions, nearby search results, and estimated travel times.',
                          style: dialogTextStyle),
                      actions: <Widget>[
                        CupertinoDialogAction(
                          child: Text('Don\'t Allow'),
                          onPressed: () {
                            Navigator.pop(context, 'Disallow');
                          },
                        ),
                        CupertinoDialogAction(
                          child: Text('Allow'),
                          onPressed: () {
                            Navigator.pop(context, 'Allow');
                          },
                        ),
                      ],
                    ),
              );
            },
          ),
          Divider(),
          CupertinoButton(
              child: const Text('Alert with Buttons'),
              color: CupertinoColors.activeBlue,
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 36.0),
              onPressed: () => showDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                      title: Text('Select Favorite Dessert'),
                      content: Text(
                          'Please select your favorite type of dessert from the'
                          'list below.Your selection will be used to customize the suggested list of eateries in your area.',
                          style: dialogTextStyle),
                      actions: items(context)))),
          Divider(),
          CupertinoButton(
              child: const Text('Alert Buttons Only'),
              color: CupertinoColors.activeBlue,
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 36.0),
              onPressed: () => showDialog(
                  context: context,
                  builder: (context) =>
                      CupertinoAlertDialog(actions: items(context)))),
          Divider(),
          CupertinoButton(
            child: const Text('Action Sheet'),
            color: CupertinoColors.activeBlue,
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 36.0),
            onPressed: () {
              showCupertinoModalPopup<String>(
                  context: context,
                  builder: (context) => CupertinoActionSheet(
                      title: const Text('Favorite Dessert'),
                      message: Text(
                          'Please select the best dessert from the options below.',
                          style: dialogTextStyle),
                      actions: <Widget>[
                        CupertinoActionSheetAction(
                          child: const Text('Profiteroles'),
                          onPressed: () {
                            Navigator.pop(context, 'Profiteroles');
                          },
                        ),
                        CupertinoActionSheetAction(
                          child: const Text('Cannolis'),
                          onPressed: () {
                            Navigator.pop(context, 'Cannolis');
                          },
                        ),
                        CupertinoActionSheetAction(
                          child: const Text('Trifle'),
                          onPressed: () {
                            Navigator.pop(context, 'Trifle');
                          },
                        ),
                      ],
                      cancelButton: CupertinoActionSheetAction(
                        child: const Text('Cancel'),
                        isDefaultAction: true,
                        onPressed: () {
                          Navigator.pop(context, 'Cancel');
                        },
                      )));
            },
          ),
        ],
      ),
    );
  }

  List<Widget> items(context) {
    List<Widget> widgets = [
      CupertinoDialogAction(
        child: const Text('Cheesecake'),
        onPressed: () {
          Navigator.pop(context, 'Cheesecake');
        },
      ),
      CupertinoDialogAction(
        child: const Text('Tiramisu'),
        onPressed: () {
          Navigator.pop(context, 'Tiramisu');
        },
      ),
      CupertinoDialogAction(
        child: const Text('Apple Pie'),
        onPressed: () {
          Navigator.pop(context, 'Apple Pie');
        },
      ),
      CupertinoDialogAction(
        child: const Text("Devil's food cake"),
        onPressed: () {
          Navigator.pop(context, "Devil's food cake");
        },
      ),
      CupertinoDialogAction(
        child: const Text('Banana Split'),
        onPressed: () {
          Navigator.pop(context, 'Banana Split');
        },
      ),
      CupertinoDialogAction(
        child: const Text('Oatmeal Cookie'),
        onPressed: () {
          Navigator.pop(context, 'Oatmeal Cookies');
        },
      ),
      CupertinoDialogAction(
          child: const Text('Chocolate Brownie'),
          onPressed: () => Navigator.pop(context, 'Chocolate Brownies')),
      CupertinoDialogAction(
          child: const Text('Cancel'),
          isDestructiveAction: true,
          onPressed: () => Navigator.pop(context, 'Cancel'))
    ];
    return widgets;
  }
}

class DialogItem extends StatelessWidget {
  const DialogItem({Key key, this.icon, this.color, this.text, this.onPressed})
      : super(key: key);

  final IconData icon;
  final Color color;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
        onPressed: onPressed,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(icon, size: 36.0, color: color),
              Padding(
                  padding: const EdgeInsets.only(left: 16.0), child: Text(text))
            ]));
  }
}
