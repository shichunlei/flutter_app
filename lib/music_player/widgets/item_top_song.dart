import 'package:flutter/material.dart';
import 'package:flutter_app/store/index.dart';
import 'package:flutter_app/ui/image_load_view.dart';

import '../../page_index.dart';
import '../index.dart';

class ItemTopSongView extends StatelessWidget {
  final Song item;
  final int rank;

  ItemTopSongView({Key key, @required this.item,@required this.rank}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var snapshot = Store.value<MusicModel>(context);

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 2),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 0.2, color: Color(0xf1e5e5e5)))),
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Toast.show(context, '添加到播放列表');
                  snapshot.addSong(item);
                },
                child: Container(
                  height: 30,
                  width: 30,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.add_box,
                    size: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  '$rank',
                  style: TextStyle(
                    fontStyle:
                        rank < 4 ? FontStyle.italic : FontStyle.normal,
                    fontSize: rank < 10 ? 30 : rank > 99 ? 16 : 18,
                    fontWeight: FontWeight.bold,
                    color: rank == 1
                        ? Colors.red
                        : rank == 2
                            ? Colors.deepOrange
                            : rank == 3 ? Colors.orange : Colors.white,
                  ),
                ),
                width: 35,
              ),
              ImageLoadView(
                '${item?.albumArtUrl}',
                width: 60,
                height: 60,
              ),
              Gaps.hGap5,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${item?.title}',
                      style: TextStyles.textBoldWhile16,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gaps.vGap5,
                    Text(
                      '${item?.artists}',
                      style: TextStyles.textWhite14,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          snapshot.playSong(item);
          pushNewPage(context, AudioPlayersPage());
        },
      ),
    );
  }
}
