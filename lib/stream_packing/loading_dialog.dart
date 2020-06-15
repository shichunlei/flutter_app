import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

typedef HideDialogCallBack = Future Function();

class LoadingDialog {
  static HideDialogCallBack showDialog(BuildContext context) {
    Completer completer = Completer();

    var result = OverlayEntry(
      builder: (context) {
        return Material(
          type: MaterialType.transparency,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                color: Colors.black,
              ),
              height: 120,
              width: 120,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(child: CircularProgressIndicator()),
                    Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text('加载中...',
                            style: TextStyle(color: Colors.white)))
                  ]),
              alignment: Alignment.center,
            ),
          ),
        );
      },
      maintainState: true,
    );

    completer.complete(() {
      if (result != null) {
        result.remove();
        result = null;
      }
    });

    Overlay.of(context).insert(result);

    return () async {
      var hide = await completer.future;
      hide();
    };
  }
}
