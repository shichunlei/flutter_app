import 'dart:async';

import 'package:custom_widgets/wave.dart';
import 'package:flutter/material.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_app/bean/music.dart';
import 'package:flutter_app/page_index.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'widgets/radial_seek_bar.dart';

class AudioPlayersPage extends StatefulWidget {
  @override
  createState() => _AudioPlayersPageState();
}

class _AudioPlayersPageState extends State<AudioPlayersPage>
    with SingleTickerProviderStateMixin {
  String localFilePath;

  AnimationController _controller;

  double _thumbPercent = 0.0;

  /// 总时长
  Duration duration;
  Duration position;

  AudioPlayer audioPlayer;
  AudioPlayerState _audioPlayerState;

  StreamSubscription _durationSubscription;
  StreamSubscription _positionSubscription;
  StreamSubscription _playerCompleteSubscription;
  StreamSubscription _playerErrorSubscription;
  StreamSubscription _playerStateSubscription;

  /// 当前音乐下标
  int _index = -1;
  int totalSongs = 0;

  PlayerState playerState = PlayerState.stopped;
  IconData _icon = Icons.play_arrow;

  /// 当前音乐名称
  String songTitle = '';

  get isPlaying => playerState == PlayerState.playing;

  get isPaused => playerState == PlayerState.paused;

  get durationText => Utils.duration2String(duration);

  get positionText => Utils.duration2String(position);

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

    audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
    audioPlayer.setReleaseMode(ReleaseMode.RELEASE);

    _durationSubscription = audioPlayer.onDurationChanged.listen((Duration d) {
      debugPrint('onDurationChanged===============Max duration: $d');
      setState(() => duration = d);
    });

    _positionSubscription =
        audioPlayer.onAudioPositionChanged.listen((Duration p) {
      debugPrint('onAudioPositionChanged===============position: $p');
      setState(() {
        position = p;

        _thumbPercent = position != null && position.inMilliseconds > 0
            ? (position?.inMilliseconds?.toDouble() ?? 0.0) /
                (duration?.inMilliseconds?.toDouble() ?? 0.0)
            : 0.0;
      });
    });

    _playerCompleteSubscription =
        audioPlayer.onPlayerCompletion.listen((event) {
      _onComplete();
      setState(() {
        position = duration;

        debugPrint('onPlayerCompletion========$position');
      });
    });

    _playerErrorSubscription = audioPlayer.onPlayerError.listen((msg) {
      debugPrint('audioPlayer error : $msg');
      setState(() {
        playerState = PlayerState.stopped;
        duration = Duration(seconds: 0);
        position = Duration(seconds: 0);

        debugPrint('onPlayerError========$position============$duration');
      });
    });

    audioPlayer.onPlayerStateChanged.listen((AudioPlayerState state) {
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
      _icon = Icons.stop;
    });
  }

  Future<int> _play({isLocal: true}) async {
    _controller.forward();

    final result =
        await audioPlayer.play(songsData[_index].audioPath, isLocal: isLocal);
    if (result == 1) {
      debugPrint('=============${audioPlayer.playerId}');
      setState(() {
        playerState = PlayerState.playing;
        _icon = Icons.pause;
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
        _icon = Icons.play_arrow;
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
        _icon = Icons.stop;
        position = Duration();
      });
  }

  Future<int> _seek(Duration duration) async {
    setState(() {
      playerState = PlayerState.paused;
    });
    int result = await audioPlayer.seek(duration);

    if (result == 1) {
      setState(() {
        playerState = PlayerState.playing;
        position = duration;
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
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerErrorSubscription?.cancel();
    _playerStateSubscription?.cancel();

    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            brightness: Brightness.light,
            backgroundColor: Colors.transparent,
            iconTheme: lightIconTheme,
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
                  thumbPercent: _thumbPercent,
                  onDragEnd: (double percent) {
                    if (percent < 1.0) _play();
                  },
                  onDragUpdate: (double percent) {
                    setState(() {
                      _thumbPercent = percent;
                      if (isPlaying) _pause();

                      if (duration != null) {
                        position = Duration(
                            milliseconds:
                                (_thumbPercent * duration.inMilliseconds)
                                    .round());
                        _seek(position);
                      }
                    });
                  })),

          // Lyric
          /// Container(height: 125.0, width: double.infinity),
          Container(
              height: 320.0,
              child: Stack(children: <Widget>[
                Wave(
                    config: CustomConfig(
                        gradients: [
                          [
                            Color.fromRGBO(233, 136, 124, 1),
                            Color.fromRGBO(204, 171, 218, 1)
                          ],
                          [
                            Color.fromRGBO(208, 230, 165, 1),
                            Color.fromRGBO(245, 221, 149, 1)
                          ],
                          [
                            Color.fromRGBO(245, 221, 149, 1),
                            Color.fromRGBO(233, 136, 124, 1)
                          ],
                          [
                            Color.fromRGBO(134, 227, 206, 1),
                            Color.fromRGBO(208, 230, 165, 1)
                          ]
                        ],
                        durations: [
                          35000,
                          19440,
                          10800,
                          6000
                        ],
                        heightPercentages: [
                          0.20,
                          0.23,
                          0.25,
                          0.30
                        ],
                        gradientBegin: Alignment.bottomLeft,
                        gradientEnd: Alignment.topRight),
                    wavePhase: 1.0,
                    waveAmplitude: 0,
                    size: Size(double.infinity, double.infinity)),

                // Song title, artist name, and controls
                Positioned(
                    child: _buildBottomControls(), left: 0, right: 0, bottom: 0)
              ])),
        ]));
  }

  Widget _buildBottomControls() {
    return Container(
        width: double.infinity,
        child: Material(
            type: MaterialType.transparency,
            child: Padding(
                padding: EdgeInsets.only(bottom: 50),
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
                      padding: EdgeInsets.only(top: 20),
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
        onPressed: (_index + 1) >= totalSongs
            ? null
            : () {
                if (isPlaying || isPaused) _stop();
                _index++;
                _play();
              });
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
        } else {
          _play();
        }
      },
      fillColor: Colors.white,
      splashColor: lightAccentColor,
      highlightColor: lightAccentColor.withOpacity(0.5),
      elevation: 10.0,
      highlightElevation: 5,
      icon: _icon,
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
            Navigator.pop(context);
          },
          selected: _index == index);
    }).toList());
  }
}
