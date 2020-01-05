import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/page_index.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  final String title;
  final String url;

  VideoPlayerPage({Key key, this.title: "", @required this.url})
      : super(key: key);

  @override
  createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  VideoPlayerController _controller;

  ValueNotifier<VideoPlayerValue> _controllerState;

  VoidCallback _controllerValueListener;

  bool _showControls = false;

  // 记录播放控件ui是否显示(进度条，播放按钮，全屏按钮等等)
  Timer _timer; // 计时器，用于延迟隐藏控件ui

  /// 总时长
  Duration duration;
  Duration position = Duration(seconds: 0);

  String get durationText => Utils.duration2String(duration);

  String get positionText => Utils.duration2String(position);

  double volume;

  _VideoPlayerPageState() {
    _controllerValueListener = () {
      if (mounted) {
        volume = _controller.value.volume;
        position = _controller.value.position;
        duration = _controller.value.duration;
        if (position > duration) {
          position = Duration(seconds: 0);
          _controller.seekTo(Duration(seconds: 0));
        }
        setState(() {});
      }
    };
  }

  @override
  void initState() {
    super.initState();

    Utils.statusBarEnable(false);

    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          if (_controller.value.initialized) {
            _controller.play();
          }
        });
      });

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    _controllerState = ValueNotifier(_controller.value);
    _controllerState.addListener(() {
      this.setState(() {});
    });

    _controller.addListener(_controllerValueListener);
  }

  @override
  void deactivate() {
    _controller.removeListener(_controllerValueListener);
    Utils.statusBarEnable(true);

    super.deactivate();
  }

  @override
  void dispose() {
    if (_timer != null) _timer.cancel();
    _controller?.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool ready = _controller.value.initialized;
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          setState(() {
            _showControls = !_showControls;
          });
          if (_showControls) {
            _startPlayControlTimer();
          }
        },
        child: Stack(
          children: <Widget>[
            ready
                ? SizedBox.expand(
                    child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ))
                : SizedBox(),
            Visibility(
              visible: _showControls,
              child: Stack(
                children: <Widget>[
                  /// 控制按钮
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      children: <Widget>[
                        IconButton(
                            icon: Icon(Icons.replay_30, color: Colors.white),
                            onPressed: () => _backwardAction()),
                        Gaps.hGap24,
                        IconButton(
                            iconSize: 80,
                            icon: Icon(
                              _controller.value.isPlaying
                                  ? Icons.pause_circle_outline
                                  : Icons.play_circle_outline,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _controller.value.isPlaying
                                    ? _controller.pause()
                                    : _controller.play();
                              });
                            }),
                        Gaps.hGap24,
                        IconButton(
                            icon: Icon(Icons.forward_30, color: Colors.white),
                            onPressed: () => _forwardAction()),
                      ],
                      mainAxisSize: MainAxisSize.min,
                    ),
                  ),

                  /// 进度条
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Text('$positionText',
                                style: TextStyles.textWhite14),
                            width: 80.0,
                            alignment: Alignment.centerLeft,
                          ),
                          Expanded(
                              child: VideoProgressIndicator(
                            _controller, allowScrubbing: true, // 允许手势操作进度条
                            padding: EdgeInsets.all(0),
                            colors: VideoProgressColors(
                              // 配置进度条颜色
                              playedColor:
                                  Theme.of(context).accentColor, // 已播放的颜色
                              bufferedColor:
                                  Color.fromRGBO(255, 255, 255, .5), // 缓存中的颜色
                              backgroundColor:
                                  Color.fromRGBO(255, 255, 255, .2), // 未缓存的颜色
                            ),
                          )),
                          Container(
                              width: 80.0,
                              alignment: Alignment.centerRight,
                              child: Text('$durationText',
                                  style: TextStyles.textWhite14)),
                        ],
                      ),
                    ),
                  ),

                  /// 标题栏
                  Container(
                    width: double.infinity,
                    height: Utils.navigationBarHeight,
                    child: AppBar(
                      title: Text('${widget.title}'),
                      backgroundColor: Colors.transparent,
                      centerTitle: false,
                    ),
                  ),
                ],
              ),
            ),
            Visibility(child: LoadingWidget(), visible: !ready),
          ],
        ),
      ),
    );
  }

  /// 快退30秒
  _backwardAction() {
    if (_controller.value == null) return;

    var position = _controller.value.position.inSeconds;
    position = max(0, position - 30);

    _controller.seekTo(Duration(seconds: position));
  }

  /// 快进30秒
  _forwardAction() {
    if (_controller.value == null) return;

    var position = _controller.value.position.inSeconds;
    position = min(duration.inSeconds, position + 30);

    _controller.seekTo(Duration(seconds: position));
  }

  /// 调整音量
  _volumeAction(double volume) {
    if (_controller.value == null) return;

    _controller.setVolume(volume);
  }

  void _startPlayControlTimer() {
    // 计时器
    if (_timer != null) _timer.cancel();
    _timer = Timer(Duration(seconds: 3), () {
      // 延迟3s后隐藏
      setState(() {
        Future.delayed(Duration(milliseconds: 300)).whenComplete(() {
          _showControls = false;
        });
      });
    });
  }
}
