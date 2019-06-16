import 'package:flutter/material.dart';

import '../page_index.dart';

class SelectTextItem extends StatelessWidget {
  const SelectTextItem(
      {Key key,
      this.onTap,
      @required this.title,
      this.content: "",
      this.textAlign: TextAlign.start,
      this.style})
      : super(key: key);

  final GestureTapCallback onTap;
  final String title;
  final String content;
  final TextAlign textAlign;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
            height: 50.0,
            margin: const EdgeInsets.only(right: 8.0, left: 16.0),
            width: double.infinity,
            child: Row(children: <Widget>[
              Text(title, style: TextStyles.textDark14),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(right: 8.0, left: 16.0),
                      child: Text(content,
                          maxLines: 2,
                          textAlign: textAlign,
                          overflow: TextOverflow.ellipsis,
                          style: style ?? TextStyles.textDark14))),
              Icon(Icons.keyboard_arrow_right, size: 16.0)
            ])));
  }
}
