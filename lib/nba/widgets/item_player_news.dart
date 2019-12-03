import 'package:flutter/material.dart';
import 'package:flutter_app/ui/image_load_view.dart';

import '../../page_index.dart';
import '../index.dart';

class ItemPlayerNews extends StatelessWidget {
  final NBANews item;

  ItemPlayerNews({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        child: Container(
          height: 100,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      Text(
                        '${item.title}',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            height: 1.5),
                      ),
                      Spacer(),
                      Text(
                        '${item.publishTime}',
                        style: TextStyles.textGreyC14,
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
              ),
              ImageLoadView(
                '${item.img}',
                width: 150,
                fit: BoxFit.cover,
              )
            ],
          ),
        ),
        onTap: () => pushNewPage(
            context,
            WebViewPage(
              url: item?.url,
              title: item?.title,
            )),
      ),
    );
  }
}
