import 'package:flutter/material.dart';

import '../../page_index.dart';

class ItemTag extends StatelessWidget {
  final VoidCallback onTap;
  final String image;
  final String title;

  ItemTag({Key key, this.onTap, this.title, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            ImageLoadView('$image', height: 60 * 129 / 177, width: 60),
            Gaps.vGap10,
            Text('$title')
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
