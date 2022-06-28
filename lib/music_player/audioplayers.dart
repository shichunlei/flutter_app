import 'package:flutter/material.dart';
import 'package:flutter_app/page_index.dart';
import 'package:flutter_app/store/index.dart';

import 'index.dart';

class AudioPlayersPage extends StatefulWidget {
  const AudioPlayersPage({Key key}) : super(key: key);

  @override
  createState() => _AudioPlayersPageState();
}

class _AudioPlayersPageState extends State<AudioPlayersPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      var value = Store.value<MusicModel>(context, listen: false);
      if (value.allSongs.isEmpty) {
        value.getMusics();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var snapshot = Store.value<MusicModel>(context);

    return Material(
        child: Stack(children: [
      Container(
          decoration: const BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
          Color.fromRGBO(208, 230, 165, 1),
          Color.fromRGBO(233, 136, 124, 1),
          Color.fromRGBO(204, 171, 218, 1),
          Color.fromRGBO(134, 227, 206, 1)
        ]),
      )),
      Positioned(
          bottom: Utils.bottomSafeHeight,
          left: 0,
          right: 0,
          top: Utils.topSafeHeight,
          child: Column(children: <Widget>[
            Expanded(child: AlbumCover(image: snapshot.curSong?.albumArtUrl, isPlaying: snapshot.isPlaying)),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 30,
                child: Marquee(
                    text: '${snapshot.curSong?.title}-${snapshot.curSong?.artists}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4.0,
                        height: 1.5),
                    scrollAxis: Axis.horizontal)),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(children: <Widget>[
                  Text(snapshot.positionText, style: TextStyle(color: Colors.white.withOpacity(0.75), fontSize: 10)),
                  Expanded(
                      child: Slider(
                          onChanged: (value) {
                            snapshot.seekPlay(value);
                          },
                          value: snapshot.progress,
                          inactiveColor: Colors.grey,
                          activeColor: Colors.white)),
                  Text(snapshot.durationText, style: TextStyle(color: Colors.white.withOpacity(0.75), fontSize: 10))
                ])),
            Material(
                type: MaterialType.transparency,
                child: Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: Row(children: <Widget>[
                      _buildModeButton(snapshot),
                      _buildPreviousButton(snapshot),
                      _buildPlayPausedButton(snapshot),
                      _buildNextButton(snapshot),
                      _buildListButton()
                    ], mainAxisAlignment: MainAxisAlignment.spaceAround)))
          ])),
      SizedBox(
          height: Utils.navigationBarHeight,
          child: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                  splashColor: lightAccentColor,
                  highlightColor: Colors.transparent,
                  icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              actions: [
                IconButton(
                    splashColor: lightAccentColor,
                    highlightColor: Colors.transparent,
                    icon: const Icon(Icons.more_horiz, color: Colors.white),
                    onPressed: () {
                      pushNewPage(context, RankListPage());
                    })
              ]))
    ]));
  }

  Widget _buildModeButton(MusicModel snapshot) {
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
                                child: SimpleDialog(children: <Widget>[
                                  ListTile(
                                      leading: const Icon(Icons.repeat_one),
                                      title: const Text('单曲循环'),
                                      onTap: () {
                                        Navigator.pop(context);
                                        snapshot.toggleMode(2);
                                      },
                                      selected: snapshot.mode == 2),
                                  ListTile(
                                      leading: const Icon(Icons.repeat),
                                      title: const Text('顺序播放'),
                                      onTap: () {
                                        Navigator.pop(context);
                                        snapshot.toggleMode(0);
                                      },
                                      selected: snapshot.mode == 0),
                                  ListTile(
                                      leading: const Icon(Icons.shuffle),
                                      title: const Text('随机播放'),
                                      onTap: () {
                                        Navigator.pop(context);
                                        snapshot.toggleMode(1);
                                      },
                                      selected: snapshot.mode == 1)
                                ], contentPadding: const EdgeInsets.all(0))))));
              });
        });
  }

  Widget _buildListButton() {
    return IconButton(
        splashColor: lightAccentColor,
        highlightColor: Colors.transparent,
        icon: const Icon(Icons.queue_music, color: Colors.white),
        onPressed: () => showMusicListBottomSheet(context));
  }

  Widget _buildNextButton(MusicModel snapshot) {
    return IconButton(
        splashColor: lightAccentColor,
        highlightColor: Colors.transparent,
        icon: const Icon(Icons.skip_next, color: Colors.white, size: 35),
        onPressed: () => snapshot.nextMusic());
  }

  Widget _buildPreviousButton(MusicModel snapshot) {
    return IconButton(
        splashColor: lightAccentColor,
        highlightColor: Colors.transparent,
        icon: const Icon(Icons.skip_previous, color: Colors.white, size: 35),
        onPressed: () => snapshot.prePlay());
  }

  Widget _buildPlayPausedButton(MusicModel snapshot) {
    return CircleButton(
      onPressedAction: () => snapshot.togglePlay(),
      splashColor: lightAccentColor,
      highlightColor: lightAccentColor.withOpacity(0.5),
      icon: snapshot.isPlaying ? Icons.pause : Icons.play_arrow,
      iconSize: 35,
      size: 70,
      iconColor: darkAccentColor,
    );
  }
}
