import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class ItemRankGrid extends StatelessWidget {
  final SubCategoryBean item;

  ItemRankGrid({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      child: Material(
        child: InkWell(
          child: Container(
            child: Stack(
              children: <Widget>[
                ImageLoadView('${item.coverUrl}'),
                Positioned(
                  child: Row(
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.headset,
                            color: Colors.white,
                            size: 15,
                          ),
                          Text(
                            '1,990万',
                            style: TextStyles.textWhite14,
                          ),
                        ],
                      ),
                      CircleButton(
                        fillColor: Colors.white,
                        elevation: 10.0,
                        highlightElevation: 5,
                        icon: Icons.play_arrow,
                        iconSize: 20,
                        size: 30,
                        iconColor: Colors.black,
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                  bottom: 5.0,
                  right: 5.0,
                  left: 5.0,
                )
              ],
            ),
          ),
          onTap: () => pushNewPage(context, TopSongsPage(info: item)),
        ),
      ),
    );
  }
}
