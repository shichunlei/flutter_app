import 'package:flutter/material.dart';

class CheckSwitchWidget extends StatefulWidget {
  CheckSwitchWidget({Key key}) : super(key: key);

  @override
  createState() => _CheckSwitchWidgetState();
}

class _CheckSwitchWidgetState extends State<CheckSwitchWidget> {
  var _isChecked = false;
  var _isTitleChecked = false;
  var _isOn = false;
  var _isTitleOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Check Switch Demo'),
      ),
      body: Column(children: <Widget>[
        Row(
          children: <Widget>[
            Checkbox(
              // 是否开启三态
              tristate: true,
              // 控制当前 checkbox 的开启状态
              value: _isChecked,
              // 不设置该方法，处于不可用状态
              onChanged: (checked) {
                // 管理状态值
                setState(() => _isChecked = checked);
              },
              // 选中时的颜色
              activeColor: Colors.pink,
              // 这个值有 padded 和 shrinkWrap 两个值，
              // padded 时候所占有的空间比 shrinkWrap 大，别的原谅我没看出啥
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),

            /// 点击无响应
            Checkbox(value: _isChecked, onChanged: null, tristate: true)
          ],
        ),
        Row(
          children: <Widget>[
            Switch(
                // 开启时候，那个条的颜色
                activeTrackColor: Colors.yellow,
                // 关闭时候，那个条的颜色
                inactiveTrackColor: Colors.yellow[200],
                // 设置指示器的图片，当然也有 color 可以设置
                activeThumbImage: AssetImage('images/flutter_logo.png'),
                inactiveThumbImage: AssetImage('images/flutter_logo.png'),
                // 开始时候的颜色，貌似会被 activeTrackColor 顶掉
                activeColor: Colors.pink,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: _isOn,
                onChanged: (onState) {
                  setState(() => _isOn = onState);
                }),

            /// 点击无响应
            Switch(value: _isOn, onChanged: null)
          ],
        ),
        CheckboxListTile(
          // 描述选项
          title: Text('Make this item checked'),
          // 二级描述
          subtitle: Text(
              'description...description...\ndescription...description...'),
          // 和 checkbox 对立边的部件，例如 checkbox 在头部，则 secondary 在尾部
          secondary: Image.asset('images/timg.gif', width: 30.0, height: 30.0),
          value: _isTitleChecked,
          // title 和 subtitle 是否为垂直密集列表中一员，最明显就是部件会变小
          dense: true,
          // 是否需要使用 3 行的高度，该值为 true 时候，subtitle 不可为空
          isThreeLine: true,
          // 控制 checkbox 选择框是在前面还是后面
          controlAffinity: ListTileControlAffinity.leading,
          // 是否将主题色应用到文字或者图标
          selected: true,
          onChanged: (checked) {
            setState(() => _isTitleChecked = checked);
          },
        ),
        SwitchListTile(
            title: Text('Turn On this item'),
            subtitle: Text(
                'description...description...\ndescription...description...'),
            secondary:
                Image.asset('images/timg.gif', width: 30.0, height: 30.0),
            isThreeLine: true,
            value: _isTitleOn,
            selected: true,
            onChanged: (onState) {
              setState(() => _isTitleOn = onState);
            })
      ]),
    );
  }
}
