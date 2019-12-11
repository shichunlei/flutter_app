import 'dart:async';

import 'package:flutter/material.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_app/bean/music.dart';
import 'package:flutter_app/page_index.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'widgets/radial_seek_bar.dart';

class MusicPlayerPage extends StatefulWidget {
  @override
  createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends State<MusicPlayerPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  double _progress = 0.0;

  /// 总时长
  Duration duration;
  Duration position;

  AudioPlayer audioPlayer;
  AudioPlayerState _audioPlayerState;

  /// 当前音乐下标
  int _index = -1;
  int totalSongs = 0;

  /// 当前音乐名称
  String songTitle = '';

  bool get isPlaying => _audioPlayerState == AudioPlayerState.PLAYING;

  bool get isPaused => _audioPlayerState == AudioPlayerState.PAUSED;

  String get durationText => Utils.duration2String(duration);

  String get positionText => Utils.duration2String(position);

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));

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

    initPlayer();
  }

  void initPlayer() async {
    totalSongs = songsData.length;
    _index = 0;
    songTitle = "${songsData[_index].title} - ${songsData[_index].artists}";

    audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER)
      ..setReleaseMode(ReleaseMode.RELEASE)
      ..onDurationChanged.listen((Duration duration) {
        debugPrint('onDurationChanged===============Max duration: $duration');
        setState(() {
          this.duration = duration;
          if (position != null) {
            this._progress = position.inMilliseconds / duration.inMilliseconds;
          }
        });
      })
      ..onAudioPositionChanged.listen((Duration position) {
        debugPrint('onAudioPositionChanged===============position: $position');
        setState(() {
          this.position = position;

          if (duration != null) {
            this._progress = position.inMilliseconds / duration.inMilliseconds;
          }
        });
      })
      ..onPlayerError.listen((msg) {
        debugPrint('audioPlayer error : $msg');
        setState(() {
          _stop();
          duration = Duration(seconds: 0);
          position = Duration(seconds: 0);

          debugPrint('onPlayerError========$position============$duration');
        });
      })
      ..onPlayerStateChanged.listen((AudioPlayerState state) {
        if (!mounted) return;
        setState(() {
          _audioPlayerState = state;
        });

        if (state == AudioPlayerState.COMPLETED) {
          next();
        }

        debugPrint('${_audioPlayerState.toString()}');
      });
  }

  Future<int> _play({isLocal: true}) async {
    _controller.forward();

    final result =
    await audioPlayer.play(songsData[_index].audioPath, isLocal: isLocal);
    if (result == 1) {
      debugPrint('=============${audioPlayer.playerId}');
      setState(() {
        songTitle = "${songsData[_index].title} - ${songsData[_index].artists}";
      });
    }
    return result;
  }

  Future<int> _resume() async {
    _controller.forward();

    final result = await audioPlayer.resume();
    if (result == 1) {
      debugPrint('=============${audioPlayer.playerId}');
      setState(() {
        songTitle = "${songsData[_index].title} - ${songsData[_index].artists}";
      });
    }
    return result;
  }

  Future<int> _pause() async {
    _controller.stop();
    final result = await audioPlayer.pause();
    if (result == 1)
      setState(() {
        songTitle = "${songsData[_index].title} - ${songsData[_index].artists}";
      });
    return result;
  }

  Future _stop() async {
    _controller.reset();

    final result = await audioPlayer.stop();
    if (result == 1)
      setState(() {
        position = Duration();
      });
  }

  void next() {
    if (isPlaying) _pause();

    if (_index == totalSongs - 1) {
      _index = 0;
    } else {
      _index++;
    }
    _seek(Duration(milliseconds: 0));

    Future.delayed(Duration(milliseconds: 800), () {
      _play();
    });
  }

  void previous() {
    if (isPlaying) _pause();

    if (_index == 0) {
      _index = totalSongs - 1;
    } else {
      _index--;
    }
    _seek(Duration(milliseconds: 0));

    Future.delayed(Duration(milliseconds: 800), () {
      _play();
    });
  }

  Future<int> _seek(Duration position) async {
    int result = await audioPlayer.seek(position);

    if (result == 1) {
      setState(() {
        this.position = position;
        audioPlayer.resume();
      });
    }

    return result;
  }

  @override
  void dispose() {
    _stop();
    audioPlayer.dispose();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () => showModalBottomSheet(
                      context: context,
                      builder: (builder) => _bottomSheetItem(context)))
            ]),
        body: Column(children: <Widget>[
          // Seek bar
          Expanded(
              child: RadialSeekBarUI(
                  imageUrl: songsData[_index].albumArtUrl,
                  controller: _controller,
                  thumbPercent: _progress,
                  onDragStart: (double percent) {
                    if (isPlaying) _pause();
                  },
                  onDragEnd: (double percent) {
                    if (percent < 1.0) _resume();
                  },
                  onDragUpdate: (double percent) {
                    setState(() {
                      _progress = percent;
                      if (duration != null) {
                        position = Duration(
                            milliseconds:
                            (_progress * duration.inMilliseconds).round());
                        _seek(position);
                      }
                    });
                  })),

          // Lyric
          Container(height: 125.0, width: double.infinity),

          // Song title, artist name, and controls
          _buildBottomControls()
        ]));
  }

  Widget _buildBottomControls() {
    return Container(
        width: double.infinity,
        child: Material(
            color: accentColor,
            shadowColor: const Color(0x44000000),
            child: Padding(
                padding: EdgeInsets.only(top: 40, bottom: 50),
                child: Column(children: <Widget>[
                  Text('$songTitle',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4.0,
                          height: 1.5)),
                  Text(
                      position != null
                          ? "$positionText / $durationText"
                          : duration != null
                          ? durationText
                          : '0:00:00 / 0:00:00',
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
                        _buildPreviousButton(),
                        Spacer(),
                        _buildPlayPausedButton(),
                        Spacer(),
                        _buildNextButton(),
                        Spacer()
                      ]))
                ]))));
  }

  Widget _buildNextButton() {
    return IconButton(
        splashColor: lightAccentColor,
        highlightColor: Colors.transparent,
        icon: Icon(Icons.skip_next, color: Colors.white, size: 35),
        onPressed: () => next());
  }

  Widget _buildPreviousButton() {
    return IconButton(
        splashColor: lightAccentColor,
        highlightColor: Colors.transparent,
        icon: Icon(Icons.skip_previous, color: Colors.white, size: 35),
        onPressed: () => previous());
  }

  Widget _buildPlayPausedButton() {
    return CircleButton(
      onPressedAction: () {
        if (isPlaying) {
          _pause();
        } else {
          if (isPaused) {
            _resume();
          } else {
            _play();
          }
        }
      },
      fillColor: Colors.white,
      splashColor: lightAccentColor,
      highlightColor: lightAccentColor.withOpacity(0.5),
      elevation: 10.0,
      highlightElevation: 5,
      icon: isPlaying ? Icons.pause : Icons.play_arrow,
      iconSize: 35,
      size: 50,
      iconColor: darkAccentColor,
    );
  }

  Widget _bottomSheetItem(BuildContext context) {
    return ListView(
      // 生成一个列表选择器
        children: songsData.map((song) {
          int index = songsData.indexOf(song);
          return ListTile(
              leading: ImageLoadView('${song.albumArtUrl}',
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              title: Text('${song.title}'),
              onTap: () {
                Navigator.pop(context);
                if (isPlaying || isPaused) {
                  if (_index != index)
                    setState(() {
                      _stop().then((_) {
                        _index = index;
                        _play();
                      });
                    });
                } else {
                  _index = index;
                  _play();
                }
              },
              selected: _index == index);
        }).toList());
  }
}
