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

void showMusicListBottomSheet(BuildContext context) {
  var snapshot = Store.value<MusicModel>(context);
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    builder: (BuildContext context) => ListView.separated(
      itemBuilder: (_, index) {
        return ListTile(
          leading: ImageLoadView('${snapshot.allSongs[index].albumArtUrl}',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Text('${snapshot.allSongs[index].title}'),
          subtitle: Text('${snapshot.allSongs[index].artists}'),
          onTap: () {
            Navigator.pop(context);
            snapshot.playSongByIndex(index);
          },
          selected: snapshot.curIndex == index,
        );
      },
      itemCount: snapshot.allSongs.length,
      separatorBuilder: (BuildContext context, int index) => Container(
        height: 0.1,
        color: Colors.grey,
      ),
    ),
  );
}
