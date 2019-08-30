import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class DetailsInterestedView extends StatelessWidget {
  final List<Books> books;
  final VoidCallback onPressed;

  DetailsInterestedView({Key key, @required this.books, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: interestedView(context),
        padding: EdgeInsets.only(top: 5),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        primary: false);
  }

  List<Widget> interestedView(BuildContext context) {
    List<Widget> children = [];

    return children
      ..add(Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(children: <Widget>[
            Text('你可能感兴趣的', style: TextStyles.textDark16),
            InkWell(
                child: Text('更多', style: TextStyles.textReader14),
                onTap: onPressed)
          ], mainAxisAlignment: MainAxisAlignment.spaceBetween)))
      ..add(GridView.builder(
          padding: EdgeInsets.only(left: 10, right: 10, top: 15),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          primary: false,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, childAspectRatio: 0.64, crossAxisSpacing: 5),
          itemBuilder: (_, index) => ItemPictureBook(
              book: books[index],
              width: (Utils.width - 35) / 4,
              onPressed: () => pushNewPage(
                  context,
                  BookDetailsPage(
                      id: books[index]?.id, imageUrl: books[index]?.cover))),
          itemCount: 4));
  }
}
