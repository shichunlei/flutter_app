import 'package:flutter/material.dart';
import 'package:flutter_app/bean/tubitv.dart';

import '../page_index.dart';
import 'video_player.dart';

class DetailsHeaderView extends StatelessWidget {
  const DetailsHeaderView({Key key, @required this.data, this.expandedHeight})
      : super(key: key);

  final TuBiTV data;
  final double expandedHeight;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      title: Text(data?.title ?? ""),
      expandedHeight: expandedHeight,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            ImageLoadView(
              data.backgrounds.length > 0
                  ? '${data?.backgrounds?.first}'
                  : '${data?.thumbnails?.first ?? ""}',
              sigmaX: 5.0,
              sigmaY: 6.0,
              opacity: 0.5,
              filterColor: Colors.black12,
            ),
            Padding(
              child: Center(
                child: Visibility(
                  visible: data?.type == "v",
                  child: IconButton(
                      iconSize: 100,
                      icon: Icon(Icons.play_circle_outline),
                      onPressed: () => pushNewPage(
                          context,
                          VideoPlayerPage(
                            url: data?.url,
                            title: data?.title,
                          ))),
                ),
              ),
              padding: EdgeInsets.only(top: Utils.navigationBarHeight),
            )
          ],
        ),
      ),
      actions: <Widget>[IconButton(icon: Icon(Icons.share), onPressed: () {})],
    );
  }
}
