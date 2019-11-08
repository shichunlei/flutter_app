import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_app/bean/music.dart';
import 'package:flutter_app/page_index.dart';

import 'widgets/album_cover.dart';

class AudioPlayersPage extends StatefulWidget {
  @override
  createState() => _AudioPlayersPageState();
}

class _AudioPlayersPageState extends State<AudioPlayersPage>
    with SingleTickerProviderStateMixin {
  String localFilePath;

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

  PlayerState playerState = PlayerState.stopped;

  /// 当前音乐名称
  String songTitle = '';

  bool get isPlaying => playerState == PlayerState.playing;

  bool get isPaused => playerState == PlayerState.paused;

  String get durationText => Utils.duration2String(duration);

  String get positionText => Utils.duration2String(position);

  CycleMode mode = CycleMode.SEQUENCE;
  IconData modeIcon = Icons.repeat;

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
      ..onPlayerCompletion.listen((event) {
        _onComplete();
        setState(() {
          position = duration;

          debugPrint('onPlayerCompletion========$position');
        });
      })
      ..onPlayerError.listen((msg) {
        debugPrint('audioPlayer error : $msg');
        setState(() {
          playerState = PlayerState.stopped;
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

        debugPrint('${_audioPlayerState.toString()}');
      });
  }

  void _onComplete() {
    _controller.reset();
    debugPrint('onComplete========');
    setState(() {
      playerState = PlayerState.stopped;
    });
    if (!(CycleMode.SEQUENCE == mode && _index == totalSongs - 1)) next();
  }

  Future<int> _play({isLocal: true}) async {
    _controller.forward();

    final result =
        await audioPlayer.play(songsData[_index].audioPath, isLocal: isLocal);
    if (result == 1) {
      debugPrint('=============${audioPlayer.playerId}');
      setState(() {
        playerState = PlayerState.playing;
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
        playerState = PlayerState.playing;
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
        playerState = PlayerState.paused;
        songTitle = "${songsData[_index].title} - ${songsData[_index].artists}";
      });
    return result;
  }

  Future _stop() async {
    _controller.reset();

    final result = await audioPlayer.stop();
    if (result == 1)
      setState(() {
        playerState = PlayerState.stopped;
        position = Duration();
      });
  }

  void next() {
    if (isPlaying || isPaused) _stop();

    if (CycleMode.SINGLE == mode) {
      _index = _index;
    } else if (CycleMode.SEQUENCE == mode) {
      _index++;
    } else {
      _index = Random().nextInt(totalSongs - 1);
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
      });
    }

    return result;
  }

  void _setVolume(double volume) {
    audioPlayer.setVolume(volume);
  }

  @override
  void dispose() {
    audioPlayer.stop();
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
              image: songsData[_index].albumArtUrl, isPlaying: isPlaying),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: 50,
                child: Marquee(
                  text: '$songTitle',
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
                  if (duration != null) {
                    _seek(Duration(
                        milliseconds:
                            (duration.inMilliseconds * value).toInt()));
                  }
                },
                value: _progress,
                onChangeEnd: (value) {
                  setState(() {
                    playerState = PlayerState.playing;
                  });
                },
                onChangeStart: (value) {
                  if (isPlaying) {
                    setState(() {
                      playerState = PlayerState.paused;
                    });
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(positionText,
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.75),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3.0,
                            height: 1.5)),
                    Text(durationText,
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
                    child: Row(children: <Widget>[
                      Spacer(),
                      _buildModeButton(),
                      Spacer(),
                      _buildPreviousButton(),
                      Spacer(),
                      _buildPlayPausedButton(),
                      Spacer(),
                      _buildNextButton(),
                      Spacer(),
                      _buildListButton(),
                      Spacer(),
                    ])),
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
    return IconButton(
        splashColor: lightAccentColor,
        highlightColor: Colors.transparent,
        icon: Icon(modeIcon, color: Colors.white, size: 20),
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
                                setState(() {
                                  modeIcon = Icons.repeat_one;
                                  mode = CycleMode.SINGLE;
                                });
                              },
                              selected: mode == CycleMode.SINGLE,
                            ),
                            ListTile(
                              leading: Icon(Icons.repeat, size: 20),
                              title: Text('顺序播放'),
                              onTap: () {
                                Navigator.pop(context);
                                setState(() {
                                  modeIcon = Icons.repeat;
                                  mode = CycleMode.SEQUENCE;
                                });
                              },
                              selected: mode == CycleMode.SEQUENCE,
                            ),
                            ListTile(
                              leading: Icon(Icons.shuffle, size: 20),
                              title: Text('随机播放'),
                              onTap: () {
                                Navigator.pop(context);
                                setState(() {
                                  modeIcon = Icons.shuffle;
                                  mode = CycleMode.RANDOM;
                                });
                              },
                              selected: mode == CycleMode.RANDOM,
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
        icon: Icon(Icons.queue_music, color: Colors.white, size: 20),
        onPressed: () => showModalBottomSheet(
            context: context, builder: (builder) => _bottomSheetItem(context)));
  }

  Widget _buildNextButton() {
    return IconButton(
        splashColor: lightAccentColor,
        highlightColor: Colors.transparent,
        icon: Icon(Icons.skip_next, color: Colors.white, size: 35),
        onPressed: (_index + 1) >= totalSongs ? null : () => next());
  }

  Widget _buildPreviousButton() {
    return IconButton(
        splashColor: lightAccentColor,
        highlightColor: Colors.transparent,
        icon: Icon(Icons.skip_previous, color: Colors.white, size: 35),
        onPressed: _index <= 0
            ? null
            : () {
                if (isPlaying || isPaused) _stop();
                _index--;
                _play();
              });
  }

  Widget _buildPlayPausedButton() {
    return CircleButton(
      onPressedAction: () {
        if (isPlaying) {
          _pause();
        } else if (isPaused) {
          _resume();
        } else {
          _play();
        }
      },
      fillColor: Colors.white,
      splashColor: lightAccentColor,
      highlightColor: lightAccentColor.withOpacity(0.5),
      elevation: 10.0,
      highlightElevation: 5,
      icon: isPlaying ? Icons.pause : isPaused ? Icons.play_arrow : Icons.stop,
      iconSize: 35,
      size: 70,
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
