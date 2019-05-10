import 'package:flutter/material.dart';
import 'package:flutter_app/bean/friends_dynamic.dart';
import 'package:flutter_app/ui/image_load_view.dart';
import 'package:flutter_app/utils/utils.dart';

class ItemDynamic extends StatelessWidget {
  final FriendsDynamic dynamic;

  ItemDynamic(this.dynamic, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int imageSize = this.dynamic.images.length;

    double imageWidth = (Utils.width - 20 - 50 - 10) /
        ((imageSize == 3 || imageSize > 4)
            ? 3.0
            : (imageSize == 2 || imageSize == 4) ? 2.0 : 1.5);

    double videoWidth = (Utils.width - 20 - 50 - 10) / 2.2;

    String desc = this.dynamic.desc;

    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ImageLoadView('${this.dynamic.userAvatar}',
                height: 50,
                width: 50,
                borderRadius: BorderRadius.circular(5.0)),
            Expanded(
              child: Container(
                  padding: EdgeInsets.only(left: 10.0, top: 8),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        /// 发布者昵称
                        Text('${this.dynamic.username}'),

                        /// 发布的文字描述
                        Offstage(
                            offstage: desc.isEmpty,
                            child: Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Text('$desc',
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis))),

                        /// 图片区域
                        Offstage(
                            offstage: imageSize == 0,
                            child: imageSize > 1
                                ? GridView.builder(
                                    padding: EdgeInsets.only(top: 8.0),
                                    itemCount: imageSize,
                                    shrinkWrap: true,
                                    primary: false,
                                    gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: imageWidth,
                                            crossAxisSpacing: 2.0,
                                            mainAxisSpacing: 2.0,
                                            childAspectRatio: 1),
                                    itemBuilder: (context, index) => ImageLoadView(
                                        '${this.dynamic.images.isNotEmpty ? this.dynamic.images[index].image : ''}',
                                        fit: BoxFit.cover))
                                : Padding(
                                    padding: EdgeInsets.only(top: 8.0),
                                    child: ImageLoadView(
                                      '${this.dynamic.images.length == 1 ? this.dynamic.images[0].image : ''}',
                                      width: imageWidth,
                                      fit: BoxFit.cover,
                                    ))),

                        /// 视频区域
                        Offstage(
                            offstage: this.dynamic.video == null,
                            child: Container(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: <Widget>[
                                    ImageLoadView(
                                        '${this.dynamic.video?.image}'),
                                    IconButton(
                                        icon: Icon(Icons.play_arrow,
                                            color: Colors.white),
                                        onPressed: () {})
                                  ],
                                ),
                                width: videoWidth)),

                        /// 定位地址
                        Offstage(
                            offstage: imageSize % 2 == 0,
                            child: Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Text('${this.dynamic.address}',
                                    style: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: 13)))),

                        /// 发布时间
                        Row(children: <Widget>[
                          Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text('${this.dynamic.datetime}',
                                    style: TextStyle(
                                        color: Colors.grey[500], fontSize: 13)),
                                Offstage(
                                    offstage: !this.dynamic.isSelf,
                                    child: Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child: Text('删除',
                                            style: TextStyle(
                                                color: Colors.blueAccent))))
                              ]),
                          IconButton(
                              icon: Icon(Icons.more_horiz, color: Colors.black),
                              onPressed: () {})
                        ], mainAxisAlignment: MainAxisAlignment.spaceBetween),

                        /// 评论部分
                      ])),
            )
          ],
        ),
        Container(
            height: 0.5,
            color: Colors.grey[200],
            margin: EdgeInsets.only(top: 10))
      ]),
    );
  }
}
