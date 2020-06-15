import 'package:flutter/material.dart';
import 'package:flutter_app/page_index.dart';

import 'list.dart';

class ListSectionTitleView extends StatelessWidget {
  final String category;
  final String title;
  final String topImage;

  ListSectionTitleView(
      {Key key,
      @required this.category,
      @required this.title,
      @required this.topImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Text(
              '$title',
              style: TextStyles.textBoldWhile16,
            ),
            IconButton(
                icon: Icon(
                  Icons.more_horiz,
                ),
                onPressed: () => pushNewPage(
                    context,
                    CategoryListPage(
                      category: category,
                      title: title,
                      topImage: topImage,
                    )))
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ),
    );
  }
}
