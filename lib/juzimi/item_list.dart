import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bean/juzimi.dart';

import '../page_index.dart';
import 'tag_list.dart';

class ItemList extends StatelessWidget {
  final JuZiMi item;
  final VoidCallback onPressed;

  ItemList({Key key, @required this.item, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onPressed,
        child: Container(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 275 / 177,
                  child: Stack(
                    children: <Widget>[
                      ImageLoadView(
                        '${item?.image}',
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 5,
                        left: 5,
                        child: Wrap(
                          spacing: 5,
                          children: item.tags
                              .map((tag) => TagView(
                                    tag: '${tag.tag}',
                                    padding: EdgeInsets.all(5),
                                    bgColor: Utils.strToColor(tag.tag),
                                    textColor: Colors.white,
                                    onPressed: () => pushNewPage(
                                        context,
                                        JuZiMiTagListPage(
                                          id: tag.id,
                                        )),
                                    borderRadius: 30,
                                  ))
                              .toList(),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${item?.title}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.textBoldDark16,
                      ),
                      Gaps.vGap5,
                      Text(
                        '${item.desc}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.textGrey14,
                      ),
                      Gaps.vGap5,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.message,
                                size: 20,
                                color: Colors.grey,
                              ),
                              Gaps.hGap5,
                              Text(
                                '${item?.commentCount}',
                                style: TextStyles.textGrey14,
                              )
                            ],
                          ),
                          Text(
                            '${item?.time}',
                            style: TextStyles.textGrey14,
                          ),
                        ],
                      ),
                    ],
                    mainAxisSize: MainAxisSize.min,
                  ),
                )
              ],
              mainAxisSize: MainAxisSize.min),
        ),
      ),
      color: Colors.white,
    );
  }
}
