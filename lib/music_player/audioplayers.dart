import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_app/page_index.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:fluttery_seekbar/fluttery_seekbar.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

const kUrl1 = 'https://luan.xyz/files/audio/ambient_c_motion.mp3';
const kUrl2 = 'https://luan.xyz/files/audio/nasa_on_a_mission.mp3';

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

  List<String> _songs = [kUrl1, kUrl2];

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
    totalSongs = _songs.length;
    _index = 0;
    songTitle = _songs[_index];

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

    final result = await audioPlayer.play(_songs[_index], isLocal: isLocal);
    if (result == 1) {
      debugPrint('=============${audioPlayer.playerId}');
      setState(() {
        playerState = PlayerState.playing;
        _icon = Icons.pause;
        songTitle = _songs[_index];
      });
    }
    return result;
  }

  Future<int> _pause() async {
    _controller.reset();
    final result = await audioPlayer.pause();
    if (result == 1)
      setState(() {
        playerState = PlayerState.paused;
        _icon = Icons.play_arrow;
        songTitle = _songs[_index];
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
            backgroundColor: Colors.transparent,
            title: Text(''),
            leading: IconButton(
                icon: Icon(SimpleLineIcons.arrow_left, size: 20),
                color: Color(0xFFDDDDDD),
                onPressed: () => Navigator.pop(context)),
            elevation: 0.0,
            actions: <Widget>[
              IconButton(
                  icon: Icon(SimpleLineIcons.playlist, size: 20),
                  color: Color(0xFFDDDDDD),
                  onPressed: () => showModalBottomSheet(
                      context: context,
                      builder: (builder) => _bottomSheetItem(context)))
            ]),
        body: Column(children: <Widget>[
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
                                      color: Color(0xFFFE1483), diameter: 15.0),
                                  margin: 12.0,
                                  progress: _thumbPercent,
                                  onDragStart: (double percent) {},
                                  onDragUpdate: (double percent) {
                                    setState(() {
                                      _thumbPercent = percent;
                                      if (isPlaying) _pause();

                                      if (duration != null) {
                                        position = Duration(
                                            milliseconds: (_thumbPercent *
                                                    duration.inMilliseconds)
                                                .round());
                                        _seek(position);
                                      }
                                    });
                                  },
                                  onDragEnd: (double percent) {
                                    if (percent < 1.0) _play();
                                  })),
                          RotationTransition(
                              child: ImageLoadView(
                                  'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564830238704&di=11798dafaaad4d5f727bac5113ed9ba5&imgtype=0&src=http%3A%2F%2Fpic41.nipic.com%2F20140507%2F7160980_232207178322_2.jpg',
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(75.0)),
                                  width: 150,
                                  height: 150),
                              turns: _controller)
                        ],
                      )))),

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
                  RichText(
                      text: TextSpan(text: '', children: [
                    TextSpan(
                        text: '$songTitle\n',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4.0,
                            height: 1.5)),
                    TextSpan(
                        text: position != null
                            ? "${positionText ?? ''} / ${durationText ?? ''}"
                            : duration != null ? durationText : '',
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.75),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3.0,
                            height: 1.5))
                  ])),
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
            child: Icon(_icon, color: darkAccentColor, size: 35)));
  }

  Widget _bottomSheetItem(BuildContext context) {
    return ListView(
        // 生成一个列表选择器
        children: _songs.map((song) {
      int index = _songs.indexOf(song);
      return ListTile(
          leading:
              CircleAvatar(backgroundColor: Colors.blue, child: Text('$song')),
          title: Text('$song'),
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

  Future _loadFile(String url, String name) async {
    final bytes = await readBytes(url);
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name.mp3');

    await file.writeAsBytes(bytes);
    if (await file.exists()) {
      setState(() {
        localFilePath = file.path;
      });
    }
  }
}
