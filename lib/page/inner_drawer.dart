import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../page_index.dart';

class InnerDrawerSample extends StatefulWidget {
  InnerDrawerSample({Key key}) : super(key: key);

  @override
  createState() => _InnerDrawerSampleState();
}

class _InnerDrawerSampleState extends State<InnerDrawerSample> {
  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  GlobalKey _keyRed = GlobalKey();
  double _width = 10;

  bool _position = true;
  bool _onTapToClose = false;
  bool _swipe = true;
  bool _tapScaffold = true;
  InnerDrawerAnimation _animationType = InnerDrawerAnimation.static;
  double _offset = 0.4;

  @override
  void initState() {
    _getWidthContainer();
    super.initState();
  }

  Color pickerColor = Color(0xff443a49);
  Color currentColor = Colors.black54;
  ValueChanged<Color> onColorChanged;

  changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  void _getWidthContainer() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final keyContext = _keyRed.currentContext;
      if (keyContext != null) {
        final RenderBox box = keyContext.findRenderObject();
        final size = box.size;
        setState(() {
          _width = size.width;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InnerDrawer(
        key: _innerDrawerKey,
        onTapClose: _onTapToClose,
        tapScaffoldEnabled: _tapScaffold,
        leftOffset: _offset,
        rightOffset: _offset,
        swipe: _swipe,
        colorTransitionChild: currentColor,
        leftAnimationType: _animationType,
        rightAnimationType: InnerDrawerAnimation.quadratic,
        leftChild: Material(
            child: SafeArea(
                //top: false,
                child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(width: 1, color: Colors.grey[200]),
                            right:
                                BorderSide(width: 1, color: Colors.grey[200]))),
                    child: Stack(key: _keyRed, children: <Widget>[
                      ListView(children: <Widget>[
                        Padding(
                            padding:
                                EdgeInsets.only(top: 12, bottom: 4, left: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(children: <Widget>[
                                  SizedBox(
                                      width: 15,
                                      height: 15,
                                      child: CircleAvatar(
                                          child: Icon(Icons.person,
                                              color: Colors.white, size: 12),
                                          backgroundColor: Colors.grey)),
                                  Text("   Guest",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          height: 1.2))
                                ]),
                                Padding(
                                  padding: EdgeInsets.only(top: 2, right: 25),
                                  child: GestureDetector(
                                    child: Icon(
                                      _position
                                          ? Icons.arrow_back
                                          : Icons.arrow_forward,
                                      size: 18,
                                    ),
                                    onTap: () {
                                      _innerDrawerKey.currentState.toggle();
                                    },
                                  ),
                                ),
                              ],
                            )),
                        Divider(),
                        ListTile(
                            title: Text("Statistics"),
                            leading: Icon(Icons.show_chart)),
                        ListTile(
                            title: Text("Activity"),
                            leading: Icon(Icons.access_time)),
                        ListTile(
                            title: Text("Nametag"),
                            leading: Icon(Icons.rounded_corner)),
                        ListTile(
                            title: Text("Favorite"),
                            leading: Icon(Icons.bookmark_border)),
                        ListTile(
                            title: Text("Close Friends"),
                            leading: Icon(Icons.list)),
                        ListTile(
                            title: Text("Suggested People"),
                            leading: Icon(Icons.person_add)),
                        ListTile(
                            title: Text("Open Facebook"),
                            leading:
                                Icon(Icons.supervised_user_circle, size: 18))
                      ]),
                      Positioned(
                          bottom: 0,
                          child: Container(
                              alignment: Alignment.bottomCenter,
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 25),
                              width: _width,
                              decoration: BoxDecoration(
                                  //color: Colors.grey,
                                  border: Border(
                                      top:
                                          BorderSide(color: Colors.grey[200]))),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Icon(Icons.settings, size: 18),
                                    Text("  Settings",
                                        style: TextStyle(fontSize: 16))
                                  ])))
                    ])))),
        rightChild: Material(
            child: Center(
                child: Container(
                    child:
                        Text("Right Child", style: TextStyle(fontSize: 18))))),
        scaffold: CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
                middle: Text('Flutter Inner Drawer'),
                automaticallyImplyLeading: false,
                backgroundColor: Colors.green[300]),
            child: SafeArea(
                child: Material(
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(padding: EdgeInsets.all(10)),
                              Text("Animation Type",
                                  style:
                                      TextStyle(fontWeight: FontWeight.w500)),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    GestureDetector(
                                        child: Row(children: <Widget>[
                                          Text('Static'),
                                          Checkbox(
                                              activeColor: Colors.black,
                                              value: _animationType ==
                                                  InnerDrawerAnimation.static,
                                              onChanged: (a) {
                                                setState(() {
                                                  _animationType =
                                                      InnerDrawerAnimation
                                                          .static;
                                                });
                                              }),
                                        ]),
                                        onTap: () {
                                          setState(() {
                                            _animationType =
                                                InnerDrawerAnimation.static;
                                          });
                                        }),
                                    GestureDetector(
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Checkbox(
                                                  activeColor: Colors.black,
                                                  value: _animationType ==
                                                      InnerDrawerAnimation
                                                          .linear,
                                                  onChanged: (a) {
                                                    setState(() {
                                                      _animationType =
                                                          InnerDrawerAnimation
                                                              .linear;
                                                    });
                                                  }),
                                              Text('Linear')
                                            ]),
                                        onTap: () {
                                          setState(() {
                                            _animationType =
                                                InnerDrawerAnimation.linear;
                                          });
                                        }),
                                    GestureDetector(
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Checkbox(
                                                  activeColor: Colors.black,
                                                  value: _animationType ==
                                                      InnerDrawerAnimation
                                                          .quadratic,
                                                  onChanged: (a) {
                                                    setState(() {
                                                      _animationType =
                                                          InnerDrawerAnimation
                                                              .quadratic;
                                                    });
                                                  }),
                                              Text('Quadratic')
                                            ]),
                                        onTap: () {
                                          setState(() {
                                            _animationType =
                                                InnerDrawerAnimation.quadratic;
                                          });
                                        })
                                  ]),
                              Padding(padding: EdgeInsets.all(10)),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    GestureDetector(
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Checkbox(
                                                  activeColor: Colors.black,
                                                  value: _swipe,
                                                  onChanged: (a) {
                                                    setState(() {
                                                      _swipe = !_swipe;
                                                    });
                                                  }),
                                              Text('Swipe')
                                            ]),
                                        onTap: () {
                                          setState(() {
                                            _swipe = !_swipe;
                                          });
                                        }),
                                    GestureDetector(
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Checkbox(
                                                  activeColor: Colors.black,
                                                  value: _tapScaffold,
                                                  onChanged: (a) {
                                                    setState(() {
                                                      _tapScaffold =
                                                          !_tapScaffold;
                                                    });
                                                  }),
                                              Text('TapScaffoldEnabled')
                                            ]),
                                        onTap: () {
                                          setState(() {
                                            _tapScaffold = !_tapScaffold;
                                          });
                                        })
                                  ]),
                              Padding(padding: EdgeInsets.all(10)),
                              GestureDetector(
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Checkbox(
                                            activeColor: Colors.black,
                                            value: _onTapToClose,
                                            onChanged: (a) {
                                              setState(() {
                                                _onTapToClose = !_onTapToClose;
                                              });
                                            }),
                                        Text('OnTap To Close')
                                      ]),
                                  onTap: () {
                                    setState(() {
                                      _onTapToClose = !_onTapToClose;
                                    });
                                  }),
                              Padding(padding: EdgeInsets.all(10)),
                              Column(children: <Widget>[
                                Text('Offset'),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SliderTheme(
                                          data: Theme.of(context)
                                              .sliderTheme
                                              .copyWith(
                                                  valueIndicatorTextStyle:
                                                      Theme.of(context)
                                                          .accentTextTheme
                                                          .bodyText1
                                                          .copyWith(
                                                              color: Colors
                                                                  .white)),
                                          child: Slider(
                                              activeColor: Colors.black,
                                              //inactiveColor: Colors.white,
                                              value: _offset,
                                              min: 0.0,
                                              max: 1,
                                              divisions: 5,
                                              semanticFormatterCallback:
                                                  (double value) =>
                                                      value.round().toString(),
                                              label: '$_offset',
                                              onChanged: (a) {
                                                setState(() {
                                                  _offset = a;
                                                });
                                              },
                                              onChangeEnd: (a) {
                                                //_getwidthContainer();
                                              })),
                                      Text(_offset.toString())
                                    ])
                              ]),
                              Padding(padding: EdgeInsets.all(10)),
                              FlatButton(
                                child: Text("Set Color Transition",
                                    style: TextStyle(
                                        color: currentColor,
                                        fontWeight: FontWeight.w500)),
                                onPressed: () {
                                  showDiffDialog(
                                    context,
                                    title: const Text('Pick a color!'),
                                    content: SingleChildScrollView(
                                        child: ColorPicker(
                                            pickerColor: pickerColor,
                                            onColorChanged: changeColor,
                                            showLabel: false,
                                            enableAlpha: false,
                                            pickerAreaHeightPercent: 0.5)),
                                    pressed: () {
                                      setState(
                                          () => currentColor = pickerColor);
                                      Navigator.of(context).pop();
                                    },
                                    yesText: "Set",
                                  );
                                },
                              ),
                              Padding(padding: EdgeInsets.all(25)),
                              RaisedButton(
                                  child: Text("open"),
                                  onPressed: () {
                                    // direction is optional
                                    // if not set, the last direction will be used
                                    _innerDrawerKey.currentState.toggle();
                                  })
                            ]))))),
        innerDrawerCallback: (a) => print(a));
  }
}
