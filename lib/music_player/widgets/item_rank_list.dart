import 'package:flutter/material.dart';
import '../index.dart';

import '../../page_index.dart';

class ItemRankList extends StatelessWidget {
  final SubCategoryBean item;

  ItemRankList({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      child: Material(
        elevation: 10.0,
        child: InkWell(
          child: Container(
            height: 125.0,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${item.label}',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Gaps.vGap5,
                        Text(
                          '${item.list[0].title} ${item.list[0].artists}',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                          maxLines: 1,
                        ),
                        Text(
                          '${item.list[1].title} ${item.list[1].artists}',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                          maxLines: 1,
                        ),
                        Text(
                          '${item.list[2].title} ${item.list[2].artists}',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                Stack(
                  children: <Widget>[
                    ImageLoadView('${item.coverUrl}', width: 125.0),
                    Positioned(
                      child: Text(
                        '每日更新',
                        style: TextStyles.textWhite14,
                      ),
                      top: 10.0,
                      right: 10.0,
                    ),
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
