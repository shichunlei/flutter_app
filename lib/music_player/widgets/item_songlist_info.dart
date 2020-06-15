import 'package:flutter/material.dart';
import 'package:flutter_app/store/index.dart';

import '../../page_index.dart';
import '../index.dart';

class ItemSongListSong extends StatelessWidget {
  final Song item;

  ItemSongListSong({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var snapshot = Store.value<MusicModel>(context);
    var snapshot2 = Store.value<SongListModel>(context);

    bool isPlaying = snapshot.curSong.id == item.id;
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
                onTap: () async {
                  if (snapshot2.showChoice) {
                    snapshot2.toggleSong(item);
                  } else {
                    snapshot.addSong(item);

                    Toast.show(context, '已添加到播放列表');
                  }
                },
                child: Container(
                  height: 30,
                  width: 30,
                  alignment: Alignment.center,
                  child: Icon(
                    snapshot2.showChoice
                        ? (snapshot2.songs.contains(item)
                            ? Icons.check_box
                            : Icons.check_box_outline_blank)
                        : Icons.add_box,
                    size: 20.0,
                    color: snapshot2.songs.contains(item)
                        ? readerMainColor
                        : Colors.white,
                  ),
                ),
              ),
              ImageLoadView('${item?.albumArtUrl}', width: 60, height: 60),
              Gaps.hGap5,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${item?.title}',
                      style: isPlaying
                          ? TextStyles.textRed16
                          : TextStyles.textBoldWhile16,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gaps.vGap5,
                    Text(
                      '${item?.artists}',
                      style: isPlaying
                          ? TextStyles.textRed14
                          : TextStyles.textWhite14,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Visibility(
                child: IconButton(
                    icon: Icon(Icons.more_horiz, color: Colors.white),
                    onPressed: () => showBottomDialog(context)),
                visible: !snapshot2.showChoice,
              )
            ],
          ),
        ),
        onTap: () {
          if (snapshot2.showChoice) {
            snapshot2.toggleSong(item);
          } else {
            snapshot.playSong(item);
            pushNewPage(context, AudioPlayersPage());
          }
        },
      ),
    );
  }

  void showBottomDialog(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('${item?.title}'),
              subtitle: Text('${item?.artists}'),
              trailing: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Container(height: 1, color: Colors.grey),
            ListTile(
              title: Text('下一首播放'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Container(height: 0.1, color: Colors.grey),
            ListTile(
              title: Text('下载'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Container(height: 0.1, color: Colors.grey),
            ListTile(
              title: Text('收藏'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Container(height: 0.1, color: Colors.grey),
            ListTile(
              title: Text('添加到歌单'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Container(height: 0.1, color: Colors.grey),
            ListTile(
              title: Text('分享'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Container(height: 0.1, color: Colors.grey),
            ListTile(
              title: Text('歌曲信息'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Container(height: 0.1, color: Colors.grey),
            ListTile(
              title: Text('评论'),
              onTap: () async {
                Navigator.pop(context);
                await showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) => Container(
                    height: 300.0,
                  ),
                );
              },
            ),
            Container(
              height: 0.1,
              color: Colors.grey,
              margin: EdgeInsets.only(bottom: Utils.bottomSafeHeight),
            ),
          ],
        );
      },
    );
  }
}
