import 'package:flutter/material.dart';
import 'package:flutter_app/store/index.dart';

import '../../page_index.dart';

class SongPlayerBar extends StatelessWidget {
  SongPlayerBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var snapshot = Store.value<MusicModel>(context);
    return GestureDetector(
        onTap: () => pushNewPageAnimation(context, AudioPlayersPage(),
            type: TransitionType.slide_top),
        child: Container(
            height: 60.0 + Utils.bottomSafeHeight,
            width: Utils.width,
            child: Stack(children: <Widget>[
              Positioned(
                  left: 0,
                  bottom: 0,
                  right: 0,
                  child: Material(
                      elevation: 16.0,
                      color: Colors.white,
                      child: Container(
                          padding: EdgeInsets.only(left: 70.0),
                          margin:
                              EdgeInsets.only(bottom: Utils.bottomSafeHeight),
                          height: 50,
                          child: Row(children: <Widget>[
                            Expanded(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                  Text('${snapshot.curSong?.title}',
                                      maxLines: 1,
                                      style: TextStyle(fontSize: 16)),
                                  Text('${snapshot.curSong?.artists}',
                                      maxLines: 1,
                                      style: TextStyle(fontSize: 14))
                                ])),
                            IconButton(
                                icon: Icon(snapshot.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow),
                                onPressed: () => snapshot.togglePlay()),
                            Gaps.hGap10,
                            IconButton(
                                icon: Icon(Icons.queue_music),
                                onPressed: () =>
                                    showMusicListBottomSheet(context))
                          ])))),
              Positioned(
                  left: 10,
                  bottom: 10 + Utils.bottomSafeHeight,
                  child: ImageLoadView('${snapshot.curSong?.albumArtUrl}',
                      width: 50,
                      height: 50,
                      shape: BoxShape.circle,
                      child: Container(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                              value: snapshot.progress,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.redAccent)))))
            ])));
  }
}
