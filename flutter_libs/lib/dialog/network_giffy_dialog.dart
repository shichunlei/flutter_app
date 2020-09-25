import 'package:flutter/material.dart';

/// https://github.com/xsahil03x/giffy_dialog/blob/master/lib/src/network.dart
class NetworkGiffyDialog extends StatelessWidget {
  final Widget image;
  final Text title;
  final Text description;
  final bool onlyOkButton;
  final Text buttonOkText;
  final Text buttonCancelText;
  final Color buttonOkColor;
  final Color buttonCancelColor;
  final double buttonRadius;
  final double cornerRadius;
  final VoidCallback onOkButtonPressed;

  NetworkGiffyDialog({
    Key key,
    @required this.image,
    @required this.title,
    @required this.onOkButtonPressed,
    this.description,
    this.onlyOkButton = false,
    this.buttonOkText,
    this.buttonCancelText,
    this.buttonOkColor,
    this.buttonCancelColor,
    this.cornerRadius = 8.0,
    this.buttonRadius = 8.0,
  })  : assert(image != null),
        assert(title != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cornerRadius)),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: (MediaQuery.of(context).size.height / 2) * 0.6,
                  child: Card(
                      elevation: 0.0,
                      margin: EdgeInsets.all(0.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(cornerRadius),
                              topLeft: Radius.circular(cornerRadius))),
                      clipBehavior: Clip.antiAlias,
                      child: image),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 16.0), child: title),
                Padding(padding: const EdgeInsets.all(8.0), child: description),
              ]),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: !onlyOkButton
                        ? MainAxisAlignment.spaceEvenly
                        : MainAxisAlignment.center,
                    children: <Widget>[
                      !onlyOkButton
                          ? RaisedButton(
                              color: buttonCancelColor ?? Colors.grey,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(buttonRadius)),
                              onPressed: () => Navigator.of(context).pop(),
                              child: buttonCancelText ??
                                  Text(
                                    'Cancel',
                                    style: TextStyle(color: Colors.white),
                                  ))
                          : Container(),
                      RaisedButton(
                        color: buttonOkColor ?? Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(buttonRadius)),
                        onPressed: onOkButtonPressed ?? () {},
                        child: buttonOkText ??
                            Text('OK', style: TextStyle(color: Colors.white)),
                      ),
                    ]),
              ),
            ]),
      ),
    );
  }
}
