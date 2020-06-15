import 'package:flutter/material.dart';

class ThemeSample extends StatelessWidget {
  ThemeSample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('主题')),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(8.0),
          children: <Widget>[
            _colorDisplayBox(
                "突出颜色", "highlightColor", Theme.of(context).highlightColor),
            _colorDisplayBox("提示颜色", "hintColor", Theme.of(context).hintColor),
            _colorDisplayBox("文本选择手柄颜色", "textSelectionHandleColor",
                Theme.of(context).textSelectionHandleColor),
            _colorDisplayBox("文字选择颜色", "textSelectionColor",
                Theme.of(context).textSelectionColor),
            _colorDisplayBox(
                "背景颜色", "backgroundColor", Theme.of(context).backgroundColor),
            _colorDisplayBox(
                "强调颜色", "accentColor", Theme.of(context).accentColor),
            _colorDisplayBox(
                "画布颜色", "canvasColor", Theme.of(context).canvasColor),
            _colorDisplayBox("卡片颜色", "cardColor", Theme.of(context).cardColor),
            _colorDisplayBox(
                "按钮颜色", "buttonColor", Theme.of(context).buttonColor),
            _colorDisplayBox("对话框背景颜色", "dialogBackgroundColor",
                Theme.of(context).dialogBackgroundColor),
            _colorDisplayBox(
                "禁用颜色", "disabledColor", Theme.of(context).disabledColor),
            _colorDisplayBox(
                "分频器颜色", "dividerColor", Theme.of(context).dividerColor),
            _colorDisplayBox(
                "错误颜色", "errorColor", Theme.of(context).errorColor),
            _colorDisplayBox(
                "指示灯颜色", "indicatorColor", Theme.of(context).indicatorColor),
            _colorDisplayBox(
                "原色", "primaryColor", Theme.of(context).primaryColor),
            _colorDisplayBox("脚手架背景颜色", "scaffoldBackgroundColor",
                Theme.of(context).scaffoldBackgroundColor),
            _colorDisplayBox("次标头颜色", "secondaryHeaderColor",
                Theme.of(context).secondaryHeaderColor),
            _colorDisplayBox("选择行颜色", "selectedRowColor",
                Theme.of(context).selectedRowColor),
            _colorDisplayBox(
                "飞溅颜色", "splashColor", Theme.of(context).splashColor),
            _colorDisplayBox("未选择的控件颜色", "unselectedWidgetColor",
                Theme.of(context).unselectedWidgetColor),
          ],
        ),
      ),
    );
  }

  Widget _colorDisplayBox(String explanation, String name, Color color) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text("$explanation\n$name\t\t"),
            Flexible(
                child: Container(
                    height: 30.0, decoration: BoxDecoration(color: color)))
          ],
        ),
        Divider()
      ],
    );
  }
}
