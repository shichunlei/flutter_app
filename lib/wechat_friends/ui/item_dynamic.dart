import 'package:flutter/material.dart';
import 'package:flutter_app/bean/friends_dynamic.dart';
import 'package:flutter_app/ui/popup_window.dart';

import '../../page_index.dart';

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

    String desc = this.dynamic.desc;

    GlobalKey popLeftKey = GlobalKey();

    return Material(
        color: Colors.white,
        child: Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ImageLoadView('${this.dynamic.userAvatar}',
                      height: 50, width: 50, radius: 5),
                  Expanded(
                      child: Container(
                          padding: EdgeInsets.only(left: 10.0, top: 8),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                /// 发布者昵称
                                Text('${this.dynamic.username}'),

                                /// 发布的文字描述
                                Visibility(
                                    visible: desc.isNotEmpty,
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
                                                    maxCrossAxisExtent:
                                                        imageWidth,
                                                    crossAxisSpacing: 2.0,
                                                    mainAxisSpacing: 2.0,
                                                    childAspectRatio: 1),
                                            itemBuilder: (context, index) =>
                                                ImageLoadView(
                                                    '${this.dynamic.images.isNotEmpty ? this.dynamic.images[index].image : ''}',
                                                    width: imageWidth,
                                                    height: imageWidth))
                                        : imageSize == 1
                                            ? Padding(
                                                padding:
                                                    EdgeInsets.only(top: 8.0),
                                                child: ImageLoadView(
                                                    this
                                                        .dynamic
                                                        ?.images
                                                        ?.first
                                                        ?.image,
                                                    height: 180,
                                                    fit: BoxFit.fitHeight))
                                            : SizedBox()),

                                /// 视频区域
                                Offstage(
                                    offstage: this.dynamic.video == null,
                                    child: Container(
                                        padding: EdgeInsets.only(top: 8.0),
                                        child: Stack(
                                            alignment: Alignment.center,
                                            children: <Widget>[
                                              ImageLoadView(
                                                  '${this.dynamic.video?.image}',
                                                  height: 180,
                                                  fit: BoxFit.fitHeight),
                                              IconButton(
                                                  icon: Icon(Icons.play_arrow,
                                                      color: Colors.white),
                                                  onPressed: () {})
                                            ]))),

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
                                Container(
                                    height: 35.0,
                                    child: Row(
                                        children: <Widget>[
                                          Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Text(
                                                    '${friendlyDateTime(this.dynamic.datetime)}',
                                                    style: TextStyle(
                                                        color: Colors.grey[500],
                                                        fontSize: 13)),
                                                Gaps.hGap10,
                                                Visibility(
                                                    visible:
                                                        this.dynamic.isSelf,
                                                    child: InkWell(
                                                        onTap: () {},
                                                        child: Text('删除',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .blueAccent))))
                                              ]),
                                          InkWell(
                                              key: popLeftKey,
                                              onTap: () {
                                                PopupWindow.showPopWindow(
                                                    context: context,
                                                    popKey: popLeftKey,
                                                    popWidget:
                                                        _buildExit(context),
                                                    popDirection:
                                                        PopDirection.left);
                                              },
                                              child: Container(
                                                  padding: EdgeInsets.all(5.0),
                                                  child: Icon(Icons.more_horiz,
                                                      color: Colors.black,
                                                      size: 20.0)))
                                        ],
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween)),

                                /// 点赞
                                Visibility(
                                    child: Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            top: 5,
                                            bottom: 5),
                                        color: Color(0xFFF3F3F5),
                                        child: Wrap(
                                            children: [
                                          Icon(Icons.favorite_border,
                                              color: Colors.blueAccent,
                                              size: 20.0),
                                          Gaps.hGap3,
                                        ]..addAll(this
                                                  .dynamic
                                                  .praise
                                                  .map((item) {
                                                return Text('$item,',
                                                    style:
                                                        TextStyles.textBlue14);
                                              }).toList()))),
                                    visible: this.dynamic.praise.length > 0),

                                Gaps.vGap(0.4),

                                /// 评论部分
                                Visibility(
                                    child: buildComments(this.dynamic.comment),
                                    visible: this.dynamic.comment.length > 0)
                              ])))
                ])));
  }

  Widget buildComments(List<CommentBean> data) {
    return Container(
        padding: EdgeInsets.all(10),
        color: Color(0xFFF3F3F5),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: data.map((comment) {
              return Text.rich(TextSpan(
                  style: TextStyle(fontSize: 15, color: grey3Color),
                  children: [
                    TextSpan(
                        text: comment.fromUser,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.blueAccent)),
                    TextSpan(text: '：${comment.content}')
                  ]..insertAll(
                      1,
                      comment.source
                          ? [TextSpan()]
                          : [
                              TextSpan(text: ' 回复 '),
                              TextSpan(
                                  text: comment.toUser,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.blueAccent))
                            ])));
            }).toList()));
  }

  Widget _buildExit(context) {
    return Container(
        width: 180,
        height: 36,
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(4.0))),
        child: Row(children: <Widget>[
          Expanded(
              child: FlatButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.favorite_border, color: Colors.white),
                  label: Text('赞', style: TextStyle(color: Colors.white)))),
          Expanded(
              child: FlatButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  label: Text('评论', style: TextStyle(color: Colors.white)),
                  icon: Icon(Icons.message, color: Colors.white)))
        ]));
  }
}
