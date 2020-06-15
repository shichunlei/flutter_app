import 'package:flutter/material.dart';

import '../../page_index.dart';

import '../index.dart';

class DetailsReviewView extends StatelessWidget {
  final String id;
  final List<BookReviews> reviews;
  final int reviewsCount;
  final VoidCallback onPressed;

  DetailsReviewView(
      {Key key,
      @required this.id,
      @required this.reviews,
      this.reviewsCount,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: reviewsView(context),
        padding: EdgeInsets.only(top: 5, bottom: 0),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        primary: false);
  }

  List<Widget> reviewsView(BuildContext context) {
    List<Widget> children = [];
    return children
      ..add(Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(children: <Widget>[
            Text('热门书评', style: TextStyles.textDark16),
            Material(
                child: InkWell(
                    child: Row(children: <Widget>[
                      Icon(Icons.edit, color: readerMainColor, size: 15),
                      Text('写书评', style: TextStyles.textReader14)
                    ], mainAxisSize: MainAxisSize.min),
                    onTap: onPressed))
          ], mainAxisAlignment: MainAxisAlignment.spaceBetween)))
      ..add(ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          primary: false,
          padding: EdgeInsets.only(top: 5),
          itemBuilder: (_, index) => ItemReview(review: reviews[index]),
          separatorBuilder: (_, index) => Line(
              margin: EdgeInsets.symmetric(horizontal: 20), color: Colors.grey),
          itemCount: reviews.length))
      ..add(Line(
          margin: EdgeInsets.symmetric(horizontal: 20), color: Colors.grey))
      ..add(InkWell(
          child: Container(
              height: 50,
              child: Text('全部书评$reviewsCount条', style: TextStyles.textReader14),
              alignment: Alignment.center),
          onTap: reviewsCount == 0 ? null : () {}));
  }
}
