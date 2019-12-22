import 'package:flutter/material.dart';

import '../page_index.dart';

class ItemMovie extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onTap;

  ItemMovie({Key key, @required this.title, @required this.image, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ImageLoadView(
              '$image',
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
              child: Text('$title',
                  maxLines: 2,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.textWhite14),
            )
          ],
        ),
      ),
    );
  }
}
