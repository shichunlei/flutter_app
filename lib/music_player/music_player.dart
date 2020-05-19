import 'package:flutter/material.dart';

import 'package:flutter_app/store/index.dart';
import 'index.dart';
import 'package:flutter_app/page_index.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class MusicPlayerPage extends StatefulWidget {
  @override
  createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends State<MusicPlayerPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    //动画开始、结束、向前移动或向后移动时会调用StatusListener
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        /// 动画从 controller.forward() 正向执行 结束时会回调此方法
        debugPrint("status is completed");

        /// 重置起点
        _controller.reset();

        /// 开启
        _controller.forward();
      }
    });

    Future.delayed(Duration.zero).then((_) {
      var snapshot = Store.value<MusicModel>(context, listen: false);
      if (snapshot.allSongs.length == 0) {
        snapshot.getMusics();
      }
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var snapshot = Store.value<MusicModel>(context);

    return Scaffold(
        appBar: AppBar(
            brightness: Brightness.light,
            iconTheme: lightIconTheme,
            backgroundColor: Colors.transparent,
            leading: IconButton(
                icon: Icon(SimpleLineIcons.arrow_left, size: 20),
                onPressed: () => Navigator.pop(context)),
            elevation: 0.0,
            actions: <Widget>[
              IconButton(
                  icon: Icon(SimpleLineIcons.playlist, size: 20),
                  onPressed: () => showMusicListBottomSheet(context))
            ]),
        body: Column(children: <Widget>[
          // Seek bar
          Expanded(
              child: RadialSeekBarUI(
                  imageUrl: snapshot.curSong?.albumArtUrl,
                  animation: animation,
                  thumbPercent: snapshot.progress,
                  onDragStart: (double percent) {
                    if (snapshot.isPlaying) snapshot.togglePlay();
                  },
                  onDragEnd: (double percent) => snapshot.togglePlay(),
                  onDragUpdate: (double percent) =>
                      snapshot.seekPlay(percent))),

          // Lyric
          Container(height: 125.0, width: double.infinity),

          // Song title, artist name, and controls
          _buildBottomControls(snapshot)
        ]));
  }

  Widget _buildBottomControls(MusicModel snapshot) {
    return Container(
        width: double.infinity,
        child: Material(
            color: accentColor,
            shadowColor: const Color(0x44000000),
            child: Padding(
                padding: EdgeInsets.only(
                    top: 40, bottom: 50.0 + Utils.bottomSafeHeight),
                child: Column(children: <Widget>[
                  Text('${snapshot.curSong?.title}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4.0,
                          height: 1.5)),
                  Text("${snapshot?.positionText} / ${snapshot?.durationText}",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.75),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3.0,
                          height: 1.5)),
                  Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Row(children: <Widget>[
                        Spacer(),
                        _buildPreviousButton(snapshot),
                        Spacer(),
                        _buildPlayPausedButton(snapshot),
                        Spacer(),
                        _buildNextButton(snapshot),
                        Spacer()
                      ]))
                ]))));
  }

  Widget _buildNextButton(MusicModel snapshot) {
    return IconButton(
        splashColor: lightAccentColor,
        highlightColor: Colors.transparent,
        icon: Icon(Icons.skip_next, color: Colors.white, size: 35),
        onPressed: () => snapshot.nextMusic());
  }

  Widget _buildPreviousButton(MusicModel snapshot) {
    return IconButton(
        splashColor: lightAccentColor,
        highlightColor: Colors.transparent,
        icon: Icon(Icons.skip_previous, color: Colors.white, size: 35),
        onPressed: () => snapshot.prePlay());
  }

  Widget _buildPlayPausedButton(MusicModel snapshot) {
    return CircleButton(
        onPressedAction: () {
          if (snapshot.isPlaying) {
            _controller.stop();
          } else
            _controller.forward().orCancel;
          snapshot.togglePlay();
        },
        fillColor: Colors.white,
        splashColor: lightAccentColor,
        highlightColor: lightAccentColor.withOpacity(0.5),
        elevation: 10.0,
        highlightElevation: 5,
        icon: snapshot.isPlaying ? Icons.pause : Icons.play_arrow,
        iconSize: 35,
        size: 50,
        iconColor: darkAccentColor);
  }
}
