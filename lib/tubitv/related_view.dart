import 'package:flutter/material.dart';
import 'package:flutter_app/bean/tubitv.dart';

import '../page_index.dart';
import 'details.dart';
import 'item_movie.dart';

class RelatedView extends StatelessWidget {
  const RelatedView({
    Key key,
    @required this.likes,
  }) : super(key: key);

  final List<TuBiTV> likes;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: likes.length > 0,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 0.0, left: 8.0, right: 8.0, bottom: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'You May Also Like',
                style: TextStyles.textBoldWhile16,
              ),
            ),
            SizedBox(
              height: 250,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) => ItemMovie(
                        title: likes[index]?.title,
                        image: likes[index]?.posterarts?.first,
                        onTap: () => pushNewPage(
                            context, DetailsPage(id: likes[index]?.id)),
                      ),
                  itemCount: likes.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      Gaps.hGap8,
                  physics: BouncingScrollPhysics()),
            )
          ],
        ),
      ),
    );
  }
}
