import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:share/share.dart';

import '../page_index.dart';

class PhotoView extends StatefulWidget {
  final List<String> photos;
  final int index;
  final PageController controller;
  final String title;
  final String heroTag;

  PhotoView({
    Key key,
    this.title,
    @required this.photos,
    this.index: 0,
    @required this.heroTag,
  })  : controller = PageController(initialPage: index),
        assert(photos.length > 0),
        assert(heroTag != null && heroTag.length > 0),
        super(key: key);

  @override
  createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView>
    with SingleTickerProviderStateMixin {
  int total = 0;
  int count;

  double dy = 0.0;
  AnimationController animationController;
  Animation<double> animation;
  bool isCommentShow = false;

  @override
  void initState() {
    super.initState();

    total = widget.photos.length;
    count = 1 + widget.index;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = Utils.height;
    debugPrint('screenHeight===================$screenHeight');

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onVerticalDragStart: (_) => animationController?.stop(),
        onVerticalDragEnd: (_) {
          debugPrint('dy====================$dy');
          // 滑动截止时，根据 dy 判断是展开还是回缩
          if (dy < 0) {
            if (!isCommentShow && dy.abs() > screenHeight * 0.2) {
              if (dy.abs() > screenHeight * 0.2) {
                animateToTop(screenHeight);
              } else {
                animateToBottom(screenHeight);
              }
            } else {
              if (dy.abs() > screenHeight * 0.4) {
                animateToTop(screenHeight);
              } else {
                animateToBottom(screenHeight);
              }
            }
          } else {
            dy = 0;
          }
        },
        onVerticalDragUpdate: (details) {
          debugPrint(
              'details.delta.dy ========================== ${details.delta.dy}');
          // dy 不超过 -screenHeight * 0.6
          dy += details.delta.dy;
          if ((dy < 0 && dy.abs() > screenHeight * 0.6)) {
            dy = -screenHeight * 0.6;
          } else {
            setState(() {});
          }
        },
        child: Stack(children: <Widget>[
          _buildBgView(screenHeight),
          _buildCommentsView(screenHeight)
        ]),
      ),
    );
  }

  /// 将comment布局滑动到顶部
  ///
  /// 动画结束后 [isCommentShow] 为 true
  void animateToTop(double screenHeight) {
    animationController = AnimationController(
        duration: Duration(milliseconds: dy.abs() * 1000 ~/ 800), vsync: this);
    final curve =
        CurvedAnimation(parent: animationController, curve: Curves.decelerate);
    animation = Tween(begin: dy, end: -screenHeight * .6).animate(curve)
      ..addListener(() => setState(() => dy = animation.value))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) isCommentShow = true;
      });
    animationController.forward(from: dy);
  }

  /// 将comment布局滑动到底部
  ///
  /// 动画结束后 [isCommentShow] 为 false
  void animateToBottom(double screenHeight) {
    animationController = AnimationController(
        duration: Duration(milliseconds: dy.abs().floor()), vsync: this);
    final curve =
        CurvedAnimation(parent: animationController, curve: Curves.decelerate);
    animation = Tween(begin: dy, end: 0.0).animate(curve)
      ..addListener(() => setState(() => dy = animation.value))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) isCommentShow = false;
      });
    animationController.forward(from: dy);
  }

  void _saveImage(String imageUrl) async {
    Toast.show(context, '正在保存...');

    var appDocDir = await FileUtil.getInstance().getTempPath();
    String savePath = appDocDir + "$count.jpg";
    await HttpUtils().download(imageUrl, savePath,
        onReceiveProgress: (int count, int total) {
      debugPrint("$count/$total");

      if (count == total) {
        Toast.show(context, '保存成功！');
      }
    });
    final result = await ImageGallerySaver.saveFile(savePath);
    debugPrint(result);
  }

  Widget _buildBgView(screenHeight) {
    return Transform.scale(
        scale: dy >= 0 ? 1 : 0.7 + 0.3 * (dy + screenHeight) / screenHeight,
        child: Stack(children: <Widget>[
          PhotoViewGallery(
            pageOptions: widget.photos
                .map((photo) => PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(photo),
                    heroAttributes:
                        PhotoViewHeroAttributes(tag: widget.heroTag)))
                .toList(),
            backgroundDecoration: BoxDecoration(color: Colors.black),
            onPageChanged: (index) {
              setState(() => count = index + 1);
            },
            scrollPhysics: const BouncingScrollPhysics(),
            loadingBuilder: (_, __) {
              return LoadingWidget();
            },
            pageController: widget.controller,
          ),
          Column(children: <Widget>[
            AppBar(
                elevation: 1.0,
                backgroundColor: Colors.transparent,
                title: Text('${widget.title ?? ""}'),
                actions: <Widget>[
                  IconButton(
                      icon: Icon(Icons.share),
                      onPressed: () {
                        Share.share(widget.photos[count - 1]);
                      })
                ]),
            Container(
              margin: const EdgeInsets.only(bottom: 40.0),
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 80.0,
                height: 30.0,
                child: Center(
                  child: Text('$count/$total',
                      style: TextStyle(color: Colors.white)),
                ),
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
              ),
            ),
          ], mainAxisAlignment: MainAxisAlignment.spaceBetween),
          Align(
              child: Container(
                  margin: EdgeInsets.all(20.0),
                  child: IconButton(
                      highlightColor: Colors.white,
                      splashColor: Colors.red,
                      disabledColor: Colors.green,
                      color: Colors.white,
                      onPressed: () => _saveImage(widget.photos[count - 1]),
                      icon: Icon(Icons.file_download))),
              alignment: Alignment.bottomRight)
        ]));
  }

  Widget _buildCommentsView(screenHeight) {
    return Transform.translate(
      offset: Offset(0, dy >= 0 ? screenHeight : dy + screenHeight),
      child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          height: screenHeight * .6,
          child: Column(children: <Widget>[
            Stack(alignment: Alignment.centerRight, children: <Widget>[
              Container(
                  child: Text('2.7w条评论', textAlign: TextAlign.center),
                  width: Utils.width),
              IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => animateToBottom(screenHeight * 0.6))
            ]),
            Expanded(
                child: ListView.builder(
                    itemBuilder: (context, index) => ListTile(
                        title: Text('item$index'),
                        leading: Icon(Icons.color_lens)),
                    itemCount: 50))
          ])),
    );
  }
}
