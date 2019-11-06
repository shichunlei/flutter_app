import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/generated/i18n.dart';

import 'utils.dart';

/// 根据Android或IOS显示不同风格dialog
///
Future<Null> showDiffDialog(BuildContext context,
    {Widget title,
    Widget content,
    String yesText,
    String noText,
    EdgeInsetsGeometry titlePadding,
    EdgeInsetsGeometry contentPadding =
        const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
    Function pressed,
    Function cancelPressed}) async {
  await showDialog(
    context: context,
    builder: (context) => Utils.isAndroid
        ? AlertDialog(
            title: title,
            titlePadding: titlePadding,
            content: content,
            contentPadding: contentPadding,
            actions: <Widget>[
              FlatButton(
                onPressed: cancelPressed ?? () => Navigator.pop(context),
                child: Text(noText ?? S.of(context).cancel),
              ),
              FlatButton(
                onPressed: () => pressed(),
                child: Text(yesText),
              )
            ],
          )
        : CupertinoAlertDialog(
            title: title,
            content: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: content,
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: cancelPressed ?? () => Navigator.pop(context),
                child: Text(noText ?? S.of(context).cancel),
              ),
              CupertinoDialogAction(
                onPressed: () => pressed(),
                child: Text(yesText ?? S.of(context).sure),
              )
            ],
          ),
  );
}
