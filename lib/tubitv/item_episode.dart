import 'package:flutter/material.dart';
import 'package:flutter_app/bean/tubitv.dart';

import '../page_index.dart';

class ItemEpisodeView extends StatelessWidget {
  final TuBiTV item;
  final bool isCheck;
  final VoidCallback onTap;

  ItemEpisodeView(
      {Key key, @required this.item, this.isCheck: false, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ImageLoadView(
                '${item?.thumbnails?.first}',
                height: 140,
              ),
              Container(
                height: 22,
                padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                child: Text('${item?.title}',
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: isCheck
                        ? TextStyles.textBoldBlue14
                        : TextStyles.textBoldWhile14),
              ),
              Container(
                height: 80,
                padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                child: Text('${item?.description}',
                    maxLines: 4,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: isCheck
                        ? TextStyles.textBlue14
                        : TextStyles.textWhite14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
