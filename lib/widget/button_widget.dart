import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  @override
  createState() => ButtonWidgetState();
}

class ButtonWidgetState extends State<ButtonWidget> {
  String _buttonType;

  /// add line
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool mini = false;
  bool extended = false;

  @override
  Widget build(BuildContext context) {
    Widget bodyView;

    switch (_buttonType) {
      case 'CUPERTINO':
        bodyView = buildCupertinoButton();
        break;
      case 'ICON':
        bodyView = buildIconButton();
        break;
      case 'ACTION':
        bodyView = buildFAButton();
        break;
      case 'DROPDOWN':
        bodyView = buildDropdownButton();
        break;
      case 'OUTLINE':
        bodyView = buildOutlineButton();
        break;
      case 'FLAT':
        bodyView = buildFlatButton();
        break;
      case 'MATERIAL':
        bodyView = buildMaterialButton();
        break;
      default:
        bodyView = buildRaisedButton();
        break;
    }

    return Scaffold(
      /// add line
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Button Widget"),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String value) {
              setState(() {
                _buttonType = value;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
              PopupMenuItem<String>(
                value: 'MATERIAL',
                child: Text('MaterialButton'),
              ),
              PopupMenuItem<String>(
                value: 'RAISED',
                child: Text('RAISED BUTTON'),
              ),
              PopupMenuItem<String>(
                value: 'FLAT',
                child: Text('FLAT BUTTON'),
              ),
              PopupMenuItem<String>(
                value: 'OUTLINE',
                child: Text('OUTLINE BUTTON'),
              ),
              PopupMenuItem<String>(
                value: 'ICON',
                child: Text('ICON BUTTON'),
              ),
              PopupMenuItem<String>(
                value: 'ACTION',
                child: Text('FloatingActionButton'),
              ),
              PopupMenuItem<String>(
                value: 'DROPDOWN',
                child: Text('DROPDOWN BUTTON'),
              ),
              PopupMenuItem<String>(
                value: 'CUPERTINO',
                child: Text('CUPERTINO BUTTON'),
              ),
            ],
          )
        ],
      ),
      body: Center(child: bodyView),
      floatingActionButton: _buttonType == 'ACTION'
          ? extended
              ? FloatingActionButton.extended(
                  onPressed: () {
                    setState(() {
                      extended = false;
                    });
                  },
                  icon: Icon(Icons.android),
                  label: Text('Android'))
              : FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      extended = true;
                    });
                  },
                  child: Icon(Icons.android),
                  tooltip: 'FloatingActionButton ToolTip',
                )
          : null,
    );
  }

  //  ButtonTextTheme textTheme,          // 按钮文字主题
  //      Color textColor,                    // 子元素颜色
  //  Color disabledTextColor,            // 不可点击时子元素颜色
  //      Color color,                        // 按钮背景色
  //  Color disabledColor,                // 不可点击时按钮背景色
  //      Color highlightColor,               // 点击高亮时按钮背景色
  //  Color splashColor,                  // 水波纹颜色
  //      Brightness colorBrightness,         // 颜色对比度
  //  double elevation,                   // 阴影高度
  //      double highlightElevation,          // 高亮时阴影高度
  //  double disabledElevation,           // 不可点击时阴影高度
  //      EdgeInsetsGeometry padding,         // 子元素周围边距
  //  ShapeBorder shape,                  // 按钮样式
  //      Clip clipBehavior,      // 抗锯齿剪切效果
  //  MaterialTapTargetSize materialTapTargetSize,
  //      Duration animationDuration,         // 动画时长
  Widget buildRaisedButton() {
    return Align(
      alignment: const Alignment(0.0, -0.2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ButtonBar(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RaisedButton(
                child: const Text('RAISED BUTTON',
                    semanticsLabel: 'RAISED BUTTON 1'),
                onPressed: () {
                  // Perform some action
                  _displaySnackBar();
                },
                shape: const StadiumBorder(),
              ),
              RaisedButton(
                child: Text('DISABLED', semanticsLabel: 'DISABLED BUTTON 1'),
                onPressed: null,
              ),
            ],
          ),
          ButtonBar(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RaisedButton(
                  child: Text('R.nomal'),
                  textTheme: ButtonTextTheme.normal,
                  onPressed: () {}),
              RaisedButton(
                  child: Text('R.primary'),
                  textTheme: ButtonTextTheme.primary,
                  onPressed: () {}),
              RaisedButton(
                  child: Text('R.accent'),
                  textTheme: ButtonTextTheme.accent,
                  onPressed: () {})
            ],
          ),
          ButtonBar(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RaisedButton.icon(
                icon: const Icon(Icons.add, size: 18.0),
                label: const Text('RAISED BUTTON',
                    semanticsLabel: 'RAISED BUTTON 2'),
                onPressed: () {
                  // Perform some action
                  _displaySnackBar();
                },
              ),
              RaisedButton.icon(
                icon: const Icon(Icons.add, size: 18.0),
                label:
                    const Text('DISABLED', semanticsLabel: 'DISABLED BUTTON 2'),
                onPressed: null,
                shape: const StadiumBorder(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //  ButtonTextTheme textTheme,          // 按钮文字主题
  //      Color textColor,                    // 子元素颜色
  //  Color disabledTextColor,            // 不可点击时子元素颜色
  //      Color color,                        // 按钮背景色
  //  Color disabledColor,                // 不可点击时按钮背景色
  //      Color highlightColor,               // 点击高亮时按钮背景色
  //  Color splashColor,                  // 水波纹颜色
  //      Brightness colorBrightness,         // 颜色对比度
  //  EdgeInsetsGeometry padding,         // 子元素周围边距
  //      ShapeBorder shape,                  // 按钮样式
  //  Clip clipBehavior = Clip.none,      // 抗锯齿剪切效果
  Widget buildFlatButton() {
    return Align(
      alignment: const Alignment(0.0, -0.2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ButtonBar(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FlatButton(
                child:
                    const Text('FLAT BUTTON', semanticsLabel: 'FLAT BUTTON 1'),
                onPressed: () {
                  // Perform some action
                  _displaySnackBar();
                },
                shape: const StadiumBorder(),
              ),
              FlatButton(
                child: Text(
                  'DISABLED',
                  semanticsLabel: 'DISABLED BUTTON 3',
                ),
                onPressed: null,
              ),
            ],
          ),
          ButtonBar(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FlatButton(
                  child: Text('F.nomal'),
                  textTheme: ButtonTextTheme.normal,
                  onPressed: () {}),
              FlatButton(
                  child: Text('F.primary'),
                  textTheme: ButtonTextTheme.primary,
                  onPressed: () {}),
              FlatButton(
                  child: Text('F.accent'),
                  textTheme: ButtonTextTheme.accent,
                  onPressed: () {}),
            ],
          ),
          ButtonBar(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FlatButton.icon(
                icon: const Icon(Icons.add_circle_outline, size: 18.0),
                label:
                    const Text('FLAT BUTTON', semanticsLabel: 'FLAT BUTTON 2'),
                onPressed: () {
                  // Perform some action
                  _displaySnackBar();
                },
              ),
              FlatButton.icon(
                icon: const Icon(Icons.add_circle_outline, size: 18.0),
                label:
                    const Text('DISABLED', semanticsLabel: 'DISABLED BUTTON 4'),
                onPressed: null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  //  ButtonTextTheme textTheme,          // 按钮文字主题
  //      Color textColor,                    // 文字颜色
  //  Color disabledTextColor,            // 不可点击时文字颜色
  //      Color color,                        // 按钮背景色
  //  Color highlightColor,               // 高亮时颜色
  //      Color splashColor,                  // 水波纹颜色
  //  double highlightElevation,          // 高亮时阴影高度
  //  this.borderSide,                    // 边框样式
  //  this.disabledBorderColor,           // 不可点击时边框颜色
  //  this.highlightedBorderColor,        // 高亮时边框颜色
  //  EdgeInsetsGeometry padding,         // 内容周围边距
  //      ShapeBorder shape,                  // 按钮样式
  //  Clip clipBehavior = Clip.none,      // 抗锯齿剪切效果
  Widget buildOutlineButton() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ButtonBar(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            OutlineButton(
              child: const Text('OUTLINE BUTTON',
                  semanticsLabel: 'OUTLINE BUTTON 1'),
              onPressed: () {
                // Perform some action
              },
              shape: const StadiumBorder(),
            ),
            OutlineButton(
              child: Text('DISABLED', semanticsLabel: 'DISABLED BUTTON 5'),
              onPressed: null,
            ),
          ],
        ),
        ButtonBar(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            OutlineButton(
                child: Text('O.nomal'),
                textTheme: ButtonTextTheme.normal,
                onPressed: () {}),
            OutlineButton(
                child: Text('O.primary'),
                textTheme: ButtonTextTheme.primary,
                onPressed: () {}),
            OutlineButton(
                child: Text('O.accent'),
                textTheme: ButtonTextTheme.accent,
                onPressed: () {})
          ],
        ),
        ButtonBar(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            OutlineButton.icon(
              icon: const Icon(Icons.add, size: 18.0),
              label: const Text('OUTLINE BUTTON',
                  semanticsLabel: 'OUTLINE BUTTON 2'),
              onPressed: () {
                // Perform some action
              },
            ),
            OutlineButton.icon(
              icon: const Icon(Icons.add, size: 18.0),
              label:
                  const Text('DISABLED', semanticsLabel: 'DISABLED BUTTON 6'),
              onPressed: null,
              shape: const StadiumBorder(),
            ),
          ],
        ),
      ],
    );
  }

  //  iconSize,   // 图标大小
  //  padding,   // 图标周围间距
  //  alignment,          // 图标位置
  //  icon,    // 图标资源
  //  color,             // 图标颜色
  //  highlightColor,    // 点击高亮颜色
  //  splashColor,       // 水波纹颜色
  //  disabledColor,     // 不可点击时高亮颜色
  //  tooltip            // 长按提示
  Widget buildIconButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ButtonBar(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.thumb_up, semanticLabel: 'Thumbs up'),
              // 图标大小
              iconSize: 48,
              // 图标周围间距
              padding: EdgeInsets.all(10),
              onPressed: () {},
              // 图标颜色
              color: Colors.redAccent,
              // 点击高亮颜色
              highlightColor: Colors.green,
              // 水波纹颜色
              splashColor: Colors.pinkAccent,
              // 长按提示
              tooltip: '赞👍',
            ),
            const IconButton(
              icon: Icon(Icons.thumb_up, semanticLabel: 'Thumbs not up'),
              onPressed: null,
              // 不可点击时高亮颜色
              disabledColor: Colors.orange,
            )
          ],
          mainAxisSize: MainAxisSize.min,
        ),
        ButtonBar(mainAxisSize: MainAxisSize.min, children: <Widget>[
          CloseButton(),
          BackButton(),
          BackButton(
            color: Colors.redAccent,
          )
        ]),
      ],
    );
  }

  //    this.tooltip,                           // 长按提醒
  //    this.foregroundColor,                   // 按钮上子元素颜色
  //    this.backgroundColor,                   // 背景色
  //    this.heroTag, // Hero 动画标签
  //    this.elevation,                   // 阴影
  //    this.highlightElevation,         // 高亮时阴影
  //    this.mini,                      // 尺寸大小，分为 mini 和 default
  //    this.shape,      // 样式形状
  //    this.clipBehavior,          // 抗锯齿剪切效果
  //    this.materialTapTargetSize,             // 点击目标的最小尺寸
  //    this.isExtended,                // 是否采用 .extended 方式
  Widget buildFAButton() {
    return FloatingActionButton(
      mini: mini,
      onPressed: () {
        setState(() {
          mini = !mini;
        });
      },
      child: Icon(Icons.android),
      tooltip: 'FloatingActionButton ToolTip',
      foregroundColor: Colors.redAccent.withOpacity(0.7),
      backgroundColor: Colors.green.withOpacity(0.4),
      elevation: 0.0,
      highlightElevation: 10.0,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14.0))),
      clipBehavior: Clip.antiAlias,
      heroTag: 'FloatingActionButton',
    );
  }

  String dropdown1Value = 'Three';
  String dropdown2Value;
  String dropdown3Value = 'Four';

  Widget buildDropdownButton() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: const Text('Simple dropdown:'),
            trailing: DropdownButton<String>(
              value: dropdown1Value,
              onChanged: (String newValue) {
                setState(() {
                  dropdown1Value = newValue;
                });
              },
              items: <String>['One', 'Two', 'Three', 'Four']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          ListTile(
            title: const Text('Dropdown with a hint:'),
            trailing: DropdownButton<String>(
              value: dropdown2Value,
              hint: const Text('Choose'),
              onChanged: (String newValue) {
                setState(() {
                  dropdown2Value = newValue;
                });
              },
              items: <String>['One', 'Two', 'Three', 'Four']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          ListTile(
            title: const Text('Scrollable dropdown:'),
            trailing: DropdownButton<String>(
              value: dropdown3Value,
              onChanged: (String newValue) {
                setState(() {
                  dropdown3Value = newValue;
                });
              },
              items: <String>[
                'One',
                'Two',
                'Three',
                'Four',
                'Can',
                'I',
                'Have',
                'A',
                'Little',
                'Bit',
                'More',
                'Five',
                'Six',
                'Seven',
                'Eight',
                'Nine',
                'Ten'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCupertinoButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Align(
          alignment: const Alignment(0.0, -0.2),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CupertinoButton(
                  child: const Text('Cupertino Button'), onPressed: () {}),
              const CupertinoButton(
                child: Text('Disabled'),
                onPressed: null,
              ),
            ],
          ),
        ),
        const Padding(padding: EdgeInsets.all(12.0)),
        CupertinoButton(
            child: const Text('With Background'),
            color: CupertinoColors.activeBlue,
            onPressed: () {}),
        const Padding(padding: EdgeInsets.all(12.0)),
        const CupertinoButton(
          child: Text('Disabled'),
          color: CupertinoColors.activeBlue,
          onPressed: null,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
      ],
    );
  }

  void _displaySnackBar() {
    /// show snackbar
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        /// set content of snackbar
        content: Text(
          "Hello! I am SnackBar :)",
        ),

        /// set duration
        duration: Duration(seconds: 3),

        /// set the action
        action: SnackBarAction(
          label: "Hit Me (Action)",
          onPressed: () {
            /// When action button is pressed, show another snackbar
            _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text(
                  "Hello! I am shown becoz you pressed Action :)",
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  //  onHighlightChanged,        // 高亮变化的回调
  //  textTheme,                 // 文字主题
  //  textColor,                 // 文字颜色
  //  disabledTextColor,         // 不可点击时文字颜色
  //  color,                     // 背景色
  //  disabledColor,             // 不可点击时背景色
  //  highlightColor,            // 点击高亮时背景色
  //  splashColor,               // 水波纹颜色
  //  colorBrightness,
  //  elevation,                 // 阴影高度
  //  highlightElevation,        // 高亮时阴影高度
  //  disabledElevation,         // 不可点击时阴影高度
  //  padding,                   // 内容周围边距
  //  shape,                     // 按钮样式
  //  clipBehavior,  // 抗锯齿剪切效果
  //  materialTapTargetSize,     // 点击目标的最小尺寸
  //  animationDuration,         // 动画效果持续时长
  //  minWidth,                  // 最小宽度
  //  height,                    // 按钮高度
  Widget buildMaterialButton() {
    return MaterialButton(
      color: Colors.teal.withOpacity(0.4),
      height: 60.0,
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Text('MaterialButton'),
      onPressed: () {},
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50.0))),
      clipBehavior: Clip.none,
    );
  }
}
