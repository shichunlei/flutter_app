import 'package:flutter/material.dart';
import 'package:flutter_app/bean/tiktok_video.dart';
import 'package:flutter_app/page_index.dart';
import 'package:video_player/video_player.dart';

class ItemVideo extends StatefulWidget {
  final TiktokVideo video;

  ItemVideo({Key key, this.video}) : super(key: key);

  @override
  createState() => _ItemVideoState();
}

class _ItemVideoState extends State<ItemVideo> {
  VideoPlayerController _controller;

  double progress = 0.0;

  /// 总时长
  Duration duration = Duration(milliseconds: 1);
  Duration position = Duration(milliseconds: 0);

  String get durationText => Utils.duration2String(duration);

  String get positionText => Utils.duration2String(position);

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network('${widget.video.playAddr}')
      ..initialize().then((_) {
        setState(() {
          if (_controller.value.initialized) {
            _controller.play();
          }
        });
      })
      ..addListener(() {
        position = _controller.value.position;
        duration = _controller.value.duration;

        if (position == duration) {
          position = Duration(milliseconds: 0);
          _controller.seekTo(position);
        }
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.initialized
        ? Material(
            type: MaterialType.transparency,
            child: Container(
              child: Stack(children: <Widget>[
                AspectRatio(
                    aspectRatio: _controller.value.aspectRatio, // 按照视频比例展示视频
                    child: VideoPlayer(_controller)),
                Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: _controller.value.isPlaying
                        ? SizedBox()
                        : Icon(Icons.play_circle_outline,
                            color: Colors.white, size: 80.0)),
                GestureDetector(onTap: () {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                }),
                Positioned(
                    child: Container(
                        width: 80,
                        child: Column(children: [
                          Container(
                              width: 70,
                              height: 70,
                              child: Stack(children: <Widget>[
                                Positioned(
                                    child: ImageLoadView(
                                        '${widget.video.avatar}',
                                        width: 60,
                                        height: 60,
                                        shape: BoxShape.circle),
                                    top: 0,
                                    left: 5,
                                    right: 5),
                                Positioned(
                                    child: Icon(Icons.add_circle,
                                        color: Colors.pink),
                                    bottom: 0,
                                    left: 0,
                                    right: 0)
                              ])),
                          Gaps.hGap10,
                          LikeButton(
                              size: 80,
                              icon: LikeIcon(Icons.favorite,
                                  iconColor: Colors.pinkAccent)),
                          Text('13w', style: TextStyle(color: Colors.white)),
                          Gaps.hGap10,
                          Container(
                              width: 70,
                              height: 70,
                              child: IconButton(
                                  icon: Icon(Icons.message,
                                      color: Colors.white, size: 40),
                                  onPressed: () {})),
                          Text('1w', style: TextStyle(color: Colors.white)),
                          Gaps.hGap10
                        ], mainAxisAlignment: MainAxisAlignment.center)),
                    right: 0,
                    top: 0,
                    bottom: 0),
                Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Container(
                        height: 1,
                        child: LinearProgressIndicator(
                            backgroundColor: Colors.transparent,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                            value: position.inMilliseconds /
                                duration.inMilliseconds.toDouble())))
              ]),
            ))
        : Container();
  }
}
