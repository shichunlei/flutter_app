import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class ItemChapter extends StatelessWidget {
  const ItemChapter(
      {Key key, @required this.chapter, @required this.checked, this.onPressed})
      : super(key: key);

  final Chapters chapter;
  final bool checked;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: InkWell(
            child: Container(
                height: Dimens.chapterItemHeight,
                padding: EdgeInsets.symmetric(horizontal: 15),
                alignment: Alignment.center,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                          child: Text('${chapter?.title}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: checked
                                      ? Colors.redAccent
                                      : (chapter.isVip
                                          ? Colors.grey[300]
                                          : Colors.grey)))),
                      Offstage(
                          offstage: !chapter.isVip,
                          child: Icon(AntDesign.pay_circle1,
                              size: 20, color: Color(0xFFF7CD7C)))
                    ])),
            onTap: onPressed));
  }
}
