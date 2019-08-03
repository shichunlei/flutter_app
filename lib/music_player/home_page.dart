import 'package:flute_music_player/flute_music_player.dart';
import 'package:flutter/material.dart';
import 'package:fluttery_seekbar/fluttery_seekbar.dart';

import '../page_index.dart';

enum PlayerState { stopped, playing, paused }

const Color accentColor = const Color(0xFFF08F8F);
const Color lightAccentColor = const Color(0xFFFfaFaF);
const Color darkAccentColor = const Color(0xFFd06F6F);

class MusicHomePage extends StatefulWidget {
  MusicHomePage({Key key}) : super(key: key);

  @override
  createState() => _MusicHomePageState();
}

class _MusicHomePageState extends State<MusicHomePage> {
  double _thumbPercent = 0.0;

  /// 总时长
  Duration duration;
  Duration position;

  List<Song> _songs = [];

  MusicFinder audioPlayer;

  /// 当前音乐下标
  int _index = -1;
  int totalSongs = 0;

  PlayerState playerState = PlayerState.stopped;
  IconData _icon = Icons.play_arrow;

  /// 当前音乐名称
  String songTitle = '';

  get isPlaying => playerState == PlayerState.playing;

  get isPaused => playerState == PlayerState.paused;

  get durationText =>
      duration != null ? duration.toString().split('.').first : '';

  get positionText =>
      position != null ? position.toString().split('.').first : '';

  @override
  void initState() {
    super.initState();
    audioPlayer = MusicFinder();
    initPlayer();
  }

  void initPlayer() async {
    try {
      List<Song> songs = await MusicFinder.allSongs();

      songs = List.from(songs);

      debugPrint('${songs.toString()}=======${songs[0].uri}==');

      if (songs.length > 0) {
        setState(() {
          _songs = songs;
          totalSongs = _songs.length;
          _index = 0;
          songTitle = _songs[_index].title;
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    audioPlayer.setDurationHandler((d) => setState(() {
          duration = d;
          print('setDurationHandler========$duration');
        }));

    audioPlayer.setPositionHandler((p) => setState(() {
          position = p;
          print('setPositionHandler========$position');
          _thumbPercent = position != null && position.inMilliseconds > 0
              ? (position?.inMilliseconds?.toDouble() ?? 0.0) /
                  (duration?.inMilliseconds?.toDouble() ?? 0.0)
              : 0.0;
        }));

    audioPlayer.setCompletionHandler(() {
      onComplete();
      setState(() {
        position = duration;

        print('setCompletionHandler========$position');
      });
    });

    audioPlayer.setErrorHandler((msg) {
      setState(() {
        playerState = PlayerState.stopped;
        duration = Duration(seconds: 0);
        position = Duration(seconds: 0);

        print('setErrorHandler========$position============$duration');
      });
    });
  }

  void onComplete() {
    print('onComplete========');
    setState(() {
      playerState = PlayerState.stopped;
      _icon = Icons.stop;
    });
  }

  Future _play({isLocal: true}) async {
    final result =
        await audioPlayer.play(_songs[_index]?.uri, isLocal: isLocal);

    if (result == 1) {
      setState(() {
        playerState = PlayerState.playing;
        _icon = Icons.pause;
        songTitle = _songs[_index].title;

        debugPrint('$songTitle 时长为： ${_songs[_index].duration}');
      });
    }
  }

  Future _pause() async {
    final result = await audioPlayer.pause();
    if (result == 1)
      setState(() {
        playerState = PlayerState.paused;
        _icon = Icons.play_arrow;
        songTitle = _songs[_index].title;
      });
  }

  Future _stop() async {
    final result = await audioPlayer.stop();
    if (result == 1)
      setState(() {
        playerState = PlayerState.stopped;
        _icon = Icons.stop;
      });
  }

  Future _seek(double seconds) async {
    await audioPlayer.seek((seconds / 1000).roundToDouble());
  }

  @override
  void dispose() {
    audioPlayer.stop();
    audioPlayer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(''),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Color(0xFFDDDDDD),
            onPressed: () {
              Navigator.pop(context);
            }),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.menu),
              color: Color(0xFFDDDDDD),
              onPressed: () => showModalBottomSheet(
                  context: context,
                  builder: (builder) {
                    return _bottomSheetItem(context);
                  }))
        ],
      ),
      body: Column(
        children: <Widget>[
          // Seek bar
          Expanded(
            child: Center(
              child: Container(
                  width: 200,
                  height: 200,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            color: accentColor, shape: BoxShape.circle),
                        child: RadialSeekBar(
                          trackColor: Colors.red.withOpacity(.5),
                          trackWidth: 2.0,
                          progressColor: Color(0xFFFE1483),
                          progressWidth: 5.0,
                          thumbPercent: _thumbPercent,
                          thumb: CircleThumb(
                            color: Color(0xFFFE1483),
                            diameter: 15.0,
                          ),
                          margin: 12.0,
                          progress: _thumbPercent,
                          onDragStart: (double percent) {},
                          onDragUpdate: (double percent) {
                            setState(() {
                              _thumbPercent = percent;
                              if (isPlaying) {
                                _pause();
                              }
                              position = Duration(
                                  milliseconds:
                                      (_thumbPercent * duration.inMilliseconds)
                                          .round());
                              _seek(_thumbPercent * duration.inMilliseconds);
                            });
                          },
                          onDragEnd: (double percent) {
                            if (percent < 1.0) {
                              _play();
                            }
                          },
                        ),
                      ),
                      ImageLoadView(
                        '',
                        borderRadius: BorderRadius.all(Radius.circular(75.0)),
                        width: 150,
                        height: 150,
                      )
                    ],
                  )),
            ),
          ),

          // Lyric
          Container(
            height: 125.0,
            width: double.infinity,
          ),

          // Song title, artist name, and controls
          _buildBottomControls(),
        ],
      ),
    );
  }

  Widget _buildBottomControls() {
    return Container(
      width: double.infinity,
      child: Material(
        color: accentColor,
        shadowColor: const Color(0x44000000),
        child: Padding(
          padding: EdgeInsets.only(top: 40, bottom: 50),
          child: Column(
            children: <Widget>[
              RichText(
                text: TextSpan(text: '', children: [
                  TextSpan(
                    text: '$songTitle\n',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4.0,
                        height: 1.5),
                  ),
                  TextSpan(
                    text: position != null
                        ? "${positionText ?? ''} / ${durationText ?? ''}"
                        : duration != null ? durationText : '',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.75),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3.0,
                        height: 1.5),
                  )
                ]),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: Row(
                  children: <Widget>[
                    Spacer(),
                    _buildPreviousButton(),
                    Spacer(),
                    _buildPlayPausedButton(),
                    Spacer(),
                    _buildNextButton(),
                    Spacer()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return IconButton(
        splashColor: lightAccentColor,
        highlightColor: Colors.transparent,
        icon: Icon(
          Icons.skip_next,
          color: Colors.white,
          size: 35,
        ),
        onPressed: (_index + 1) >= totalSongs
            ? null
            : () {
                if (isPlaying || isPaused) {
                  _stop();
                }
                _index++;
                _play();
              });
  }

  Widget _buildPreviousButton() {
    return IconButton(
        splashColor: lightAccentColor,
        highlightColor: Colors.transparent,
        icon: Icon(
          Icons.skip_previous,
          color: Colors.white,
          size: 35,
        ),
        onPressed: _index <= 0
            ? null
            : () {
                if (isPlaying || isPaused) {
                  _stop();
                }
                _index--;
                _play();
              });
  }

  Widget _buildPlayPausedButton() {
    return RawMaterialButton(
      onPressed: () {
        if (isPlaying) {
          _pause();
        } else {
          _play();
        }
      },
      shape: CircleBorder(),
      fillColor: Colors.white,
      splashColor: lightAccentColor,
      highlightColor: lightAccentColor.withOpacity(0.5),
      elevation: 10.0,
      highlightElevation: 5,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Icon(
          _icon,
          color: darkAccentColor,
          size: 35,
        ),
      ),
    );
  }

  Widget _bottomSheetItem(BuildContext context) {
    return ListView(
      // 生成一个列表选择器
      children: _songs.map((song) {
        int index = _songs.indexOf(song);
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text('${song?.title[0]}'),
          ),
          title: Text('${song?.title}'),
          onTap: () {
            if (isPlaying || isPaused) {
              if (_index != index) {
                setState(() {
                  _stop().then((_) {
                    _index = index;
                    _play();
                  });
                });
              }
            } else {
              _index = index;
              _play();
            }
            Navigator.pop(context);
          },
          selected: _index == index,
        );
      }).toList(),
    );
  }
}
