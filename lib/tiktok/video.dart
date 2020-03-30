import 'package:flutter/material.dart';
import 'package:flutter_app/bean/tiktok_video.dart';

import '../page_index.dart';
import 'item_video.dart';

class VideoPage extends StatefulWidget {
  final double offsetX;

  VideoPage({Key key, this.offsetX}) : super(key: key);

  @override
  createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  List<TiktokVideo> videos = [];

  LoaderState state = LoaderState.Loading;

  @override
  void initState() {
    super.initState();

    getVideoData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
        offset:
            Offset(widget.offsetX > 0 ? widget.offsetX : widget.offsetX / 5, 0),
        child: LoaderContainer(
            contentView: PageView.builder(
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return ItemVideo(
                  video: videos[index],
                );
              },
              itemCount: videos.length,
            ),
            loaderState: state));
  }

  void getVideoData() async {
    List<TiktokVideo> list = await ApiService.getTiktokVideos();

    videos.addAll(list);
    setState(() {
      state = LoaderState.Succeed;
    });
  }
}
