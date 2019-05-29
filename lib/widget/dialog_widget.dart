import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/custom_widgets/dialog/asset_giffy_dialog.dart';
import 'package:flutter_app/custom_widgets/dialog/network_giffy_dialog.dart';
import 'package:flutter_app/custom_widgets/dialog/rich_alert_dialog.dart';

class DialogWidget extends StatefulWidget {
  @override
  createState() => DialogWidgetState();
}

class DialogWidgetState extends State<DialogWidget> {
  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final ThemeData theme = Theme.of(context);
    final TextStyle dialogTextStyle =
        theme.textTheme.subhead.copyWith(color: theme.textTheme.caption.color);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text("Dialog Widget")),
      floatingActionButton: FloatingActionButton(
          onPressed: () => showDialog(
              context: context,
              builder: (context) => RichAlertDialog(
                  title: richTitle("Alert title"),
                  subtitle: richSubtitle("Subtitle"),
                  type: RichAlertType.ERROR,
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
                  builder: (_) => NetworkGiffyDialog(
                        image: Image.network(
                          "https://raw.githubusercontent.com/Shashank02051997/FancyGifDialog-Android/master/GIF's/gif14.gif",
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          'Granny Eating Chocolate',
                          textAlign: TextAlign.center,
                          style: dialogTextStyle,
                        ),
                        description: Text(
                          'This is a granny eating chocolate dialog box. This library helps you easily create fancy giffy dialog.',
                          textAlign: TextAlign.center,
                        ),
                        onOkButtonPressed: () {},
                      ));
            },
            child: Text('Network giffy dialog'),
          ),
          Divider(),
          RaisedButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => AssetGiffyDialog(
                        image: Image.asset(
                          'images/timg.gif',
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          'Men Wearing Jackets',
                          style: dialogTextStyle,
                        ),
                        description: Text(
                          'This is a men wearing jackets dialog box. This library helps you easily create fancy giffy dialog.',
                          textAlign: TextAlign.center,
                          style: TextStyle(),
                        ),
                        onOkButtonPressed: () {},
                      ));
            },
            child: Text('Asset giffy dialog'),
          ),
          Divider(),
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
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: Icon(Icons.account_circle),
                          ),
                          title: Text('username@gmail.com'),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.red,
                            child: Icon(Icons.account_balance),
                          ),
                          title: Text('user02@gmail.com'),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey,
                            child: Icon(Icons.add_circle),
                          ),
                          title: Text('add account'),
                          onTap: null,
                        ),
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
              showDialog(
                  context: context,
                  // 设置点击 dialog 外部不取消 dialog，默认能够取消
                  barrierDismissible: false,
                  builder: (context) {
                    return AboutDialog(
                      applicationName: 'Flutter App',
                      applicationIcon: Icon(Icons.add),
                      applicationVersion: '1.0',
                      //版本号，默认为空
                      applicationLegalese: '版权所有：SCL',
                      children: <Widget>[
                        Text("具体的内容"),
                        Text('具体的布局'),
                      ],
                    );
                  });
            },
            child: Text("AboutDialog"),
          ),
          Divider(),
          Builder(
            builder: (context) => RaisedButton(
                  onPressed: () {
                    Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('收藏成功'),
                        action: SnackBarAction(label: '撤销', onPressed: () {}),
                        duration: Duration(milliseconds: 2000)));
                  },
                  child: Text('SnackBar'),
                ),
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
