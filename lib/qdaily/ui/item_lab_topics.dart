import 'package:flutter/material.dart';
import 'package:flutter_app/page_index.dart';

import '../index.dart';

class ItemLabTopicsView extends StatelessWidget {
  final List<InsertContent> insertContent;

  ItemLabTopicsView({Key key, this.insertContent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size.fromHeight(180),
      child: ListView.separated(
          padding: EdgeInsets.all(20),
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) => Container(
                width: Utils.width / 1.5,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    ImageLoadView('${insertContent[index].image}'),
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            '${insertContent[index].title}',
                            style: TextStyles.textBoldWhile16,
                          ),
                          Text('${insertContent[index].description}',
                              style: TextStyles.textWhite14),
                        ],
                      ),
                    ),
                    Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                        onTap: () => pushNewPage(
                            context,
                            TopicLabsPage(
                              id: insertContent[index].id,
                              title: insertContent[index].title,
                            )),
                      ),
                    )
                  ],
                ),
              ),
          separatorBuilder: (_, index) => Gaps.hGap10,
          itemCount: insertContent.length),
    );
  }
}
