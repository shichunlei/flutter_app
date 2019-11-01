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

  /// 总时长
  Duration duration;
  Duration position;

  String get durationText => Utils.duration2String(duration);

  String get positionText => Utils.duration2String(position);

  double volume;

  _VideoPlayerPageState() {
    _controllerValueListener = () {
      if (mounted) {
        volume = _controller.value.volume;
        position = _controller.value.position;
        duration = _controller.value.duration;
        if (position >= duration) {
          position = Duration(milliseconds: 0);
          _seek(0);
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
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _controller?.dispose();
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
                            icon: Image.asset(
                              'images/rew_15_normal.png',
                              height: 40,
                              width: 40,
                            ),
                            onPressed: () {
                              _backwardAction();
                            }),
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
                            icon: Image.asset('images/fwd_15_normal.png',
                                height: 40, width: 40),
                            onPressed: () {
                              _forwardAction();
                            }),
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
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: Row(
                        children: <Widget>[
                          Text('$positionText', style: TextStyles.textWhite14),
                          Expanded(
                            child: Slider(
                              value: position == null
                                  ? 0.0
                                  : (position.inMilliseconds /
                                          duration.inMilliseconds)
                                      .toDouble(),
                              onChanged: (double value) {
                                position = Duration(
                                    milliseconds:
                                        (duration.inMilliseconds * value)
                                            .round());
                                setState(() {
                                  _seek((duration.inMilliseconds * value)
                                      .toInt());
                                });
                              },
                              onChangeEnd: (value) {
                                /// 快进完毕后恢复播放
                                if (value < 1.0) {
                                  _controller.play();
                                }
                              },
                              onChangeStart: (value) {
                                /// 开始滑动进度条时先停止播放
                                if (_controller.value.isPlaying) {
                                  _controller.pause();
                                }
                              },
                            ),
                          ),
                          Text('$durationText', style: TextStyles.textWhite14),
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
                    ),
                  ),
                ],
              ),
            ),
            Visibility(child: getLoadingWidget(), visible: !ready),
          ],
        ),
      ),
    );
  }

  /// 快退15秒
  _backwardAction() {
    if (_controller.value == null) return;

    var position = _controller.value.position.inSeconds;
    position = max(0, position - 15);

    _controller.seekTo(Duration(seconds: position));
  }

  /// 快进15秒
  _forwardAction() {
    if (_controller.value == null) return;

    var position = _controller.value.position.inSeconds;
    position = min(duration.inSeconds, position + 15);

    _controller.seekTo(Duration(seconds: position));
  }

  /// 调整音量
  _volumeAction(double volume) {
    if (_controller.value == null) return;

    _controller.setVolume(volume);
  }

  _seek(int value) {
    var position = min(value, duration.inMilliseconds);

    _controller.seekTo(Duration(milliseconds: position));
  }
}
