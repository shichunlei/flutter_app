import 'dart:async';

import 'package:flutter/material.dart';

import 'index.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import '../page_index.dart';

class FlutterSoundPage extends StatefulWidget {
  FlutterSoundPage({Key key}) : super(key: key);

  @override
  createState() => _FlutterSoundPageState();
}

class _FlutterSoundPageState extends State<FlutterSoundPage>
    with SingleTickerProviderStateMixin {
  // 播放状态
  bool isPlay = false;

  // with 是dart的关键字，意思是混入，就是说可以将一个或者多个类的功能添加到自己的类，无需继承这些类，避免多重继承导致的问题
  AnimationController _controller;

  // 当前播放的索引
  int onTop = 0;

  // 基本信息
  String _name;

  String _artists;

  FlutterSound flutterSound = FlutterSound(); //创建一个播放实例

  StreamSubscription _playerSubscription; //监听播放
  double _value = 0.0; //播放位置
  double maxDuration = 0.0; //时长
  bool _isPlaying = false;

  String get currentPositionTxt =>
      Utils.duration2String(Duration(milliseconds: _value.toInt()));

  String get maxDurationTxt =>
      Utils.duration2String(Duration(milliseconds: maxDuration.toInt()));

  List<Song> songs = [];

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 15), vsync: this);

    getSongs();
  }

  @override
  void dispose() {
    _controller?.dispose();
    flutterSound.stopPlayer();
    _playerSubscription?.cancel();
    _playerSubscription = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(title: Text('Flutter Sound')),
        body: songs.length > 0
            ? Column(children: <Widget>[
                /// cd
                Expanded(
                  child: Center(
                    child: Container(
                        height: 300.0,
                        child: Swiper(
                            itemBuilder: (BuildContext context, int index) =>
                                AnimatedCDView(
                                    animation: _controller,
                                    imageUrl: songs[index].albumArtUrl),
                            onIndexChanged: (i) => setState(() {
                                  onTop = i;
                                  _name = songs[i].title;
                                  _artists = songs[i].artists;
                                  startPlay();
                                }),
                            itemCount: songs.length,
                            viewportFraction: 0.70,
                            scale: 0.6)),
                  ),
                ),

                // name
                Container(
                    height: 90.0,
                    child: Column(children: <Widget>[
                      Text(_name,
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Color.fromRGBO(24, 29, 40, 1))),
                      Gaps.vGap10,
                      Text(_artists,
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Color.fromRGBO(24, 29, 40, 1)))
                    ])),
                // play
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      // unlike
                      CircleButton(
                        onPressedAction: () {
                          _saveMusic(_name, songs[onTop].audioPath);
                        },
                        fillColor: Colors.white,
                        splashColor: lightAccentColor,
                        highlightColor: lightAccentColor.withOpacity(0.5),
                        elevation: 5.0,
                        highlightElevation: 5,
                        icon: Icons.file_download,
                        iconColor: Theme.of(context).primaryColor,
                        iconSize: 20,
                      ),
                      // play && pause
                      CircleButton(
                        onPressedAction: () => setState(() {
                          isPlay = !isPlay;
                          if (isPlay) {
                            _controller.repeat();
                            if (_isPlaying) {
                              flutterSound.resumePlayer();
                            } else {
                              startPlay();
                            }
                          } else {
                            _controller.stop();
                            if (_isPlaying) {
                              flutterSound.pausePlayer();
                            }
                          }
                        }),
                        size: 80,
                        fillColor: Colors.white,
                        splashColor: lightAccentColor,
                        highlightColor: lightAccentColor.withOpacity(0.5),
                        elevation: 8.0,
                        highlightElevation: 5,
                        icon: isPlay ? Icons.pause : Icons.play_arrow,
                        iconColor: Theme.of(context).primaryColor,
                        iconSize: 50,
                      ),
                      // like
                      CircleButton(
                        onPressedAction: () {
                          Toast.show(context, '$_artists - $_name');
                          Utils.copyToClipboard('$_artists - $_name');
                        },
                        fillColor: Colors.white,
                        splashColor: lightAccentColor,
                        highlightColor: lightAccentColor.withOpacity(0.5),
                        elevation: 5.0,
                        highlightElevation: 5,
                        icon: Icons.favorite_border,
                        iconColor: Theme.of(context).primaryColor,
                        iconSize: 20,
                      )
                    ]),
                // 进度条
                Slider(
                    onChanged: (double value) async {
                      if (isPlay) {
                        setState(() => _value = value);
                        await flutterSound.seekToPlayer(value.toInt());
                      }
                    },
                    value: _value,
                    min: 0.0,
                    max: maxDuration),

                Text('$currentPositionTxt / $maxDurationTxt'),
                Gaps.vGap(Utils.bottomSafeHeight)
              ])
            : LoadingView());
  }

  //停止播放
  void stopPlayer() async {
    await flutterSound.stopPlayer();
    if (_playerSubscription != null) {
      debugPrint("停止播放");
      _playerSubscription.cancel();
      _playerSubscription = null;
    }
  }

  void startPlay() async {
    isPlay = false;
    _controller.stop();
    debugPrint('$_isPlaying');
    if (_isPlaying) {
      // 如果在播放，则先暂停
      debugPrint("已有播放");
      flutterSound.stopPlayer();
    }

    await flutterSound.startPlayer(songs[onTop].audioPath);

    try {
      setState(() {
        this.isPlay = true;
        this._controller.repeat();
        debugPrint("开始解析");
      });
      // 开始旋转
      _playerSubscription = flutterSound.onPlayerStateChanged.listen((e) {
        if (e != null) {
          // 播放位置
          this._value = e.currentPosition;
          // 歌曲时长
          this.maxDuration = e.duration;
          this.setState(() {
            if (e.currentPosition < e.duration - 1) {
              this._isPlaying = true;
            } else {
              this._isPlaying = false;
              this.isPlay = false;
              this._controller.stop();
            }
          });
        }
      });
    } catch (err) {
      // 停止旋转
      setState(() {
        isPlay = false;
        _controller.stop();
      });
      debugPrint('error: $err');
    }
  }

  _saveMusic(String fileName, String url) async {
    var appDocDir = await FileUtil.getInstance().getTempPath();
    String savePath = appDocDir + "$fileName.mp3";
    await HttpUtils().download(url, savePath,
        onReceiveProgress: (int count, int total) {
      debugPrint("$count/$total");

      if (count == total) {
        Toast.show(context, '下载成功！');
      }
    });
    final result = await ImageGallerySaver.saveFile(savePath);
    debugPrint(result);
  }

  void getSongs() async {
    List<Song> list = await ApiService.getMusics();

    songs.addAll(list);

    _name = songs?.first?.title;
    _artists = songs?.first?.artists;

    setState(() {});
  }
}
