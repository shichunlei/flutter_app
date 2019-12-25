import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/store/index.dart';

import '../page_index.dart';

/// 根据Android或IOS显示不同风格dialog
///
Future<Null> showDiffDialog(BuildContext context,
    {Widget title,
    Widget content,
    String yesText,
    String noText,
    EdgeInsetsGeometry titlePadding,
    EdgeInsetsGeometry contentPadding =
        const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
    Function pressed,
    Function cancelPressed}) async {
  await showDialog(
    context: context,
    builder: (context) => Utils.isAndroid
        ? AlertDialog(
            title: title,
            titlePadding: titlePadding,
            content: content,
            contentPadding: contentPadding,
            actions: <Widget>[
              FlatButton(
                onPressed: cancelPressed ?? () => Navigator.pop(context),
                child: Text(noText ??= S.of(context).cancel),
              ),
              FlatButton(
                onPressed: () => pressed(),
                child: Text(yesText ??= S.of(context).sure),
              )
            ],
          )
        : CupertinoAlertDialog(
            title: title,
            content: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: content,
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: cancelPressed ?? () => Navigator.pop(context),
                child: Text(noText ??= S.of(context).cancel),
              ),
              CupertinoDialogAction(
                onPressed: () => pressed(),
                child: Text(yesText ??= S.of(context).sure),
              )
            ],
          ),
  );
}

/// 歌曲播放列表
///
void showMusicListBottomSheet(BuildContext context) {
  var snapshot = Store.value<MusicModel>(context);
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    builder: (BuildContext context) => Container(
      height: Utils.height * 2 / 3,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Icon(snapshot.modeIcon),
                Gaps.hGap10,
                RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: snapshot.mode == 0
                              ? '顺序播放'
                              : snapshot.mode == 1 ? "随机播放" : "单曲循环",
                          style: TextStyles.textBlue16),
                      TextSpan(
                          text: '（共${snapshot.allSongs.length}首）',
                          style: TextStyles.textBlue14),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(height: 1, color: Colors.grey),
          Expanded(
            child: ListView.separated(
              itemBuilder: (_, index) {
                bool isPlaying = snapshot.curIndex == index;
                return ListTile(
                  leading: ImageLoadView(
                    '${snapshot.allSongs[index].albumArtUrl}',
                    width: isPlaying ? 50 : 40,
                    height: isPlaying ? 50 : 40,
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    child: isPlaying
                        ? Container(
                            width: isPlaying ? 50 : 40,
                            height: isPlaying ? 50 : 40,
                            child: CircularProgressIndicator(
                                value: snapshot.progress,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.redAccent)),
                          )
                        : null,
                  ),
                  title: Text(
                    '${snapshot.allSongs[index].title}',
                    maxLines: 1,
                  ),
                  subtitle: Text(
                    '${snapshot.allSongs[index].artists}',
                    maxLines: 1,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    snapshot.playSongByIndex(index);
                  },
                  selected: isPlaying,
                );
              },
              itemCount: snapshot.allSongs.length,
              separatorBuilder: (BuildContext context, int index) =>
                  Container(height: 0.1, color: Colors.grey),
            ),
          ),
        ],
      ),
    ),
  );
}
