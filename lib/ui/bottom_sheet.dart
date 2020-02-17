import 'package:flutter/material.dart';
import 'package:flutter_app/generated/i18n.dart';

import '../page_index.dart';

class BottomSheetView extends StatelessWidget {
  final double radius;
  final Color backgroundColor;
  final bool showClose;
  final bool showButton;
  final bool hasAppBar;
  final VoidCallback closeOnTap;
  final Widget child;
  final AlignmentGeometry alignment;

  BottomSheetView(
      {Key key,
      this.radius: 20.0,
      this.backgroundColor: Colors.white,
      this.showClose: false,
      this.showButton: false,
      this.hasAppBar: true,
      this.closeOnTap,
      this.alignment: Alignment.centerLeft,
      @required this.child})
      : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius), topRight: Radius.circular(radius)),
      child: Material(
        color: backgroundColor,
        elevation: 11,
        child: Container(
          height: hasAppBar
              ? Utils.height - Utils.navigationBarHeight
              : Utils.height - Utils.navigationBarHeight + Utils.topSafeHeight,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Visibility(
                  visible: showButton,
                  child: Container(
                    height: 60,
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Button(
                          color: Colors.transparent,
                          textColor: Colors.grey,
                          width: 80,
                          onPressed: closeOnTap,
                          child: Text('${S.of(context).cancel}',
                              style: TextStyle(fontSize: 18)),
                        ),
                        Button(
                          color: Colors.transparent,
                          textColor: Colors.blueAccent,
                          width: 80,
                          onPressed: () {},
                          child: Text('${S.of(context).sure}',
                              style: TextStyle(fontSize: 18)),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.all(10),
                    alignment: alignment,
                    child: IconButton(
                        icon: Icon(Icons.close), onPressed: closeOnTap),
                  ),
                  visible: showClose,
                ),
                Visibility(
                  child: SizedBox(height: 50),
                  visible: !showClose || !showButton,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20), child: child)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
