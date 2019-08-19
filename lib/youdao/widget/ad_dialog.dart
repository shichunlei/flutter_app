import 'package:flutter/material.dart';

import '../../page_index.dart';

class AdDialog extends Dialog {
  final String image;
  final VoidCallback onTap;

  AdDialog({Key key, this.image, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: Center(
          child: Column(children: <Widget>[
            InkWell(
                child: Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.white,
                    child:
                        ImageLoadView('$image', width: 254.3, height: 120.0)),
                onTap: onTap),
            Container(height: 30, width: 1, color: Colors.white),
            CircleAvatar(
                child: IconButton(
                    icon: Icon(Icons.clear, color: Colors.black),
                    onPressed: () => Navigator.of(context).pop()),
                radius: 20,
                backgroundColor: Colors.white)
          ], mainAxisSize: MainAxisSize.min),
        ));
  }
}
