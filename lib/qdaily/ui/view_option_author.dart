import 'package:flutter/material.dart';

import '../../page_index.dart';

class ViewOptionAuthor extends StatelessWidget {
  final String avatar;
  final String name;

  ViewOptionAuthor({Key key, this.name, this.avatar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      ImageLoadView('$avatar',
          width: 20,
          height: 20,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      Gaps.hGap8,
      Expanded(
          child: Text('$name',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white)))
    ]);
  }
}
