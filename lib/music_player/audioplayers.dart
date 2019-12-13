import 'package:flutter/material.dart';
import 'package:flutter_app/bean/music.dart';
import 'package:flutter_app/page_index.dart';
import 'package:flutter_app/store/index.dart';

import 'widgets/album_cover.dart';

class AudioPlayersPage extends StatefulWidget {
  @override
  createState() => _AudioPlayersPageState();
}

class _AudioPlayersPageState extends State<AudioPlayersPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 20));

    /// 动画开始、结束、向前移动或向后移动时会调用StatusListener
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

    WidgetsBinding.instance.addPostFrameCallback((callback) {
      var value = Store.value<MusicModel>(context);
      if (value.allSongs.length == 0) {
        value.addSongs(songsData);
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
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(208, 230, 165, 1),
                Color.fromRGBO(233, 136, 124, 1),
                Color.fromRGBO(204, 171, 218, 1),
                Color.fromRGBO(134, 227, 206, 1),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: Utils.navigationBarHeight - Utils.topSafeHeight),
          child: AlbumCover(
              image: Store.value<MusicModel>(context).curSong?.albumArtUrl,
              isPlaying: Store.value<MusicModel>(context).isPlaying),
        ),
        Positioned(
          bottom: Utils.bottomSafeHeight,
          left: 0,
          right: 0,
          child: Container(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: 50,
                child: Marquee(
                  text:
                      '${Store.value<MusicModel>(context).curSong?.title}-${Store.value<MusicModel>(context).curSong?.artists}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4.0,
                      height: 1.5),
                  scrollAxis: Axis.horizontal,
                ),
              ),
              Slider(
                onChanged: (value) {
                  Store.value<MusicModel>(context).seekPlay(value);
                },
                value: Store.value<MusicModel>(context).progress,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(Store.value<MusicModel>(context).positionText,
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.75),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3.0,
                            height: 1.5)),
                    Text(Store.value<MusicModel>(context).durationText,
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.75),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3.0,
                            height: 1.5))
                  ],
                ),
              ),
              Material(
                type: MaterialType.transparency,
                child: Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: Row(
                      children: <Widget>[
                        _buildModeButton(),
                        _buildPreviousButton(),
                        _buildPlayPausedButton(),
                        _buildNextButton(),
                        _buildListButton(),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                    )),
              )
            ]),
          ),
        ),
        Container(
          child: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: lightIconTheme,
            elevation: 0.0,
          ),
          height: Utils.navigationBarHeight,
        )
      ]),
    );
  }

  Widget _buildModeButton() {
    var snapshot = Store.value<MusicModel>(context);
    return IconButton(
        splashColor: lightAccentColor,
        highlightColor: Colors.transparent,
        icon: Icon(snapshot.modeIcon, color: Colors.white, size: 20),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SimpleDialog(
                          children: <Widget>[
                            ListTile(
                              leading: Icon(Icons.repeat_one),
                              title: Text('单曲循环'),
                              onTap: () {
                                Navigator.pop(context);
                                snapshot.toggleMode(CycleMode.SINGLE);
                              },
                              selected: snapshot.mode == CycleMode.SINGLE,
                            ),
                            ListTile(
                              leading: Icon(Icons.repeat),
                              title: Text('顺序播放'),
                              onTap: () {
                                Navigator.pop(context);
                                snapshot.toggleMode(CycleMode.SEQUENCE);
                              },
                              selected: snapshot.mode == CycleMode.SEQUENCE,
                            ),
                            ListTile(
                              leading: Icon(Icons.shuffle),
                              title: Text('随机播放'),
                              onTap: () {
                                Navigator.pop(context);
                                snapshot.toggleMode(CycleMode.RANDOM);
                              },
                              selected: snapshot.mode == CycleMode.RANDOM,
                            ),
                          ],
                          contentPadding: EdgeInsets.all(0),
                        ),
                      ),
                    ),
                  ),
                );
              });
        });
  }

  Widget _buildListButton() {
    return IconButton(
        splashColor: lightAccentColor,
        highlightColor: Colors.transparent,
        icon: Icon(Icons.queue_music, color: Colors.white),
        onPressed: () => showMusicListBottomSheet(context));
  }

  Widget _buildNextButton() {
    return IconButton(
        splashColor: lightAccentColor,
        highlightColor: Colors.transparent,
        icon: Icon(Icons.skip_next, color: Colors.white, size: 35),
        onPressed: () => Store.value<MusicModel>(context).nextMusic());
  }

  Widget _buildPreviousButton() {
    return IconButton(
        splashColor: lightAccentColor,
        highlightColor: Colors.transparent,
        icon: Icon(Icons.skip_previous, color: Colors.white, size: 35),
        onPressed: () => Store.value<MusicModel>(context).prePlay());
  }

  Widget _buildPlayPausedButton() {
    return CircleButton(
      onPressedAction: () {
        Store.value<MusicModel>(context).togglePlay();
      },
      fillColor: Colors.white,
      splashColor: lightAccentColor,
      highlightColor: lightAccentColor.withOpacity(0.5),
      elevation: 10.0,
      highlightElevation: 5,
      icon: Store.value<MusicModel>(context).isPlaying
          ? Icons.pause
          : Icons.play_arrow,
      iconSize: 35,
      size: 70,
      iconColor: darkAccentColor,
    );
  }
}
