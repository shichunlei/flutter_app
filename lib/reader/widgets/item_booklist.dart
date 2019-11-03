import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class ItemBookList extends StatelessWidget {
  final VoidCallback onPressed;
  final BookList booklist;

  ItemBookList({Key key, this.onPressed, this.booklist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: InkWell(
            onTap: onPressed,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(children: <Widget>[
                Expanded(
                  child: Column(children: <Widget>[
                    Text('${booklist?.title}',
                        style: TextStyles.textDark14,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    Gaps.vGap5,
                    Text('${booklist?.desc}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.textGreyC12),
                    Gaps.vGap5,
                    Text(
                      '${booklist?.bookCount}本 | ${booklist?.collectorCount}收藏',
                      style: TextStyle(color: Colors.grey[500], fontSize: 11),
                    )
                  ], crossAxisAlignment: CrossAxisAlignment.start),
                ),
                Gaps.hGap5,
                buildImage()
              ]),
            )));
  }

  Widget buildImage() {
    print('===========${booklist?.cover}');

    int size = booklist?.covers?.length;

    String image1;
    String image2;
    String image3;

    String defaultCover =
        'https://github.com/shichunlei/flutter_app/blob/master/images/loading.png';

    if (size == 0) {
      image1 = booklist?.cover;
      image2 = booklist?.cover;
      image3 = booklist?.cover;
    } else if (size == 1) {
      image1 = booklist?.cover == defaultCover
          ? booklist?.covers?.first
          : booklist?.cover;
      image2 = booklist?.covers?.first;
      image3 = booklist?.covers?.first;
    } else if (size == 2) {
      image1 = booklist?.cover == defaultCover
          ? booklist?.covers?.first
          : booklist?.cover;
      image2 = booklist?.covers?.first;
      image3 = booklist?.covers[1];
    } else if (size == 3) {
      image1 = booklist?.covers?.first;
      image2 = booklist?.covers[1];
      image3 = booklist?.covers[2];
    }

    return Container(
        width: 100,
        height: 80,
        child: Stack(alignment: Alignment.center, children: <Widget>[
          Positioned(
              child: ImageLoadView(image2, height: 100,width: 47),
              left: 0,
              top: 10,
              bottom: 10),
          Positioned(
              child: ImageLoadView(image3, height: 100,width: 47),
              right: 0,
              top: 10,
              bottom: 10),
          ImageLoadView(image1, height: 120,width: 55)
        ]));
  }
}
