import 'package:flutter/material.dart';


/// ToggleButtons各属性释义
///
/// children：不多介绍了，一个 Widget 的集合
/// isSelected： List<bool>，每个切换按钮相应的状态，true 为选中，该字段的长度必须和 children 的长度一致
/// onPressed：切换按钮的点击事件，如果为 null， 则该控件的状态为 disable
/// color：Text / Icon 状态为已启用并且未选中时的颜色
/// selectedColor：不用多说，选中时的颜色
/// disabledColor：未启用时的颜色
/// fillColor：选中按钮的背景颜色
/// focusColor：当按钮中具有输入焦点时填充的颜色
/// highlightColor：点击时的颜色
/// hoverColor：当按钮上有指针悬停时用于填充按钮的颜色
/// splashColor：点击后的颜色
/// focusNodes：每一个按钮的焦点
/// renderBorder：是否在每个切换按钮周围呈现边框
/// borderColor：边框颜色
/// selectedBorderColor：选中的边框颜色
/// disabledBorderColor：不可用时边框颜色
/// borderRadius：边框半径
/// borderWidth：边框宽度

class ToggleButtonsWidget extends StatefulWidget {
  ToggleButtonsWidget({Key key}) : super(key: key);

  @override
  createState() => _ToggleButtonsWidgetState();
}

class _ToggleButtonsWidgetState extends State<ToggleButtonsWidget> {
  var isSelected1 = [false, false, true];
  var isSelected2 = [false, false, true];
  var isSelected3 = [false, false, true];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: Text('ToggleButtons')),
      body: Center(
        child: Column(
          children: [
            // multi-select
            SizedBox(height: 20),
            Text('multi-select', textScaleFactor: 2),
            ToggleButtons(
              children: [
                Icon(Icons.ac_unit),
                Icon(Icons.call),
                Icon(Icons.cake),
              ],
              onPressed: (int index) {
                setState(() {
                  isSelected1[index] = !isSelected1[index];
                });
              },
              isSelected: isSelected1,
            ),
            // single select
            SizedBox(height: 20),
            Text('single select', textScaleFactor: 2),
            ToggleButtons(
              children: [
                Icon(Icons.ac_unit),
                Icon(Icons.call),
                Icon(Icons.cake),
              ],
              onPressed: (int index) {
                setState(() {
                  for (int buttonIndex = 0;
                      buttonIndex < isSelected2.length;
                      buttonIndex++) {
                    if (buttonIndex == index) {
                      isSelected2[buttonIndex] = true;
                    } else {
                      isSelected2[buttonIndex] = false;
                    }
                  }
                });
              },
              isSelected: isSelected2,
            ),
            // fancy
            SizedBox(height: 20),
            Text('fancy', textScaleFactor: 2),
            ToggleButtons(
              borderColor: Colors.blueGrey,
              borderWidth: 5,
              selectedBorderColor: Colors.blue,
              splashColor: Colors.yellow,
              borderRadius: BorderRadius.circular(10),
              children: [
                Icon(Icons.ac_unit),
                Icon(Icons.call),
                Text('cake'),
              ],
              onPressed: (int index) {
                setState(() {
                  for (int buttonIndex = 0;
                      buttonIndex < isSelected3.length;
                      buttonIndex++) {
                    if (buttonIndex == index) {
                      isSelected3[buttonIndex] = true;
                    } else {
                      isSelected3[buttonIndex] = false;
                    }
                  }
                });
              },
              isSelected: isSelected3,
            ),
          ],
        ),
      ),
    );
  }
}
