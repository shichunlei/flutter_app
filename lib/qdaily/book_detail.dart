import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../page_index.dart';
import 'index.dart';

class BookDetailPage extends StatefulWidget {
  final int id;

  BookDetailPage({Key key, @required this.id}) : super(key: key);

  @override
  createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  BookBean detailBean;
  PostBean post;
  AuthorBean author;

  ResponseBean responseBean;

  @override
  void initState() {
    super.initState();

    getBookInfo(widget.id);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Container(
        height: Utils.height,
        child: Stack(alignment: Alignment.bottomCenter, children: <Widget>[
          responseBean == null || detailBean == null
              ? getLoadingWidget()
              : SingleChildScrollView(
                  child: Column(children: <Widget>[
                    Stack(children: <Widget>[
                      ImageLoadView('${post?.image}',
                          fit: BoxFit.fitHeight, height: Utils.height),
                      Container(
                          color: Color.fromRGBO(255, 255, 255, 0.7),
                          height: Utils.height),
                      Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                        ImageLoadView('${post?.image}',
                            width: Utils.width / 2,
                            height: Utils.width / 2 * 239 / 163),
                        Html(
                            data: '${detailBean?.desc}',
                            defaultTextStyle: TextStyle(
                                fontSize: 14, color: Color(0xFF363636)),
                            padding: EdgeInsets.all(8.0),
                            blockSpacing: 2.0,
                            useRichText: true)
                      ])
                    ]),

                    /// 文章简介
                    Offstage(
                        offstage: post?.description?.length == 0 ||
                            post?.description == null,
                        child: Column(children: <Widget>[
                          Container(
                            child: Text('${post?.description}',
                                style: TextStyle(
                                    color: Color(0xFF9C9C9C), fontSize: 22)),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                  top: 30, bottom: 0, left: 80, right: 80),
                              height: 1,
                              color: Color(0xFF9C9C9C))
                        ])),

                    /// 文章内容
                    Html(
                        data: '${detailBean?.detail}',
                        defaultTextStyle: TextStyle(fontSize: 18),
                        padding: EdgeInsets.all(8.0),
                        blockSpacing: 2.0,
                        useRichText: true),

                    /// 标签
                    Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Wrap(
                            spacing: 5,
                            runSpacing: 5,
                            children: detailBean.tags
                                .map((tag) => Chip(
                                    label: Text('$tag',
                                        style: TextStyle(color: Colors.white))))
                                .toList())),

                    /// 推荐
                    ListView.builder(
                        itemBuilder: (context, index) => ItemFeedTypeRecommend(
                            post: detailBean?.posts[index],
                            onTap: () => pushReplacement(
                                context,
                                ArticleDetail(
                                    id: detailBean?.posts[index]?.id))),
                        padding: EdgeInsets.only(top: 0),
                        primary: false,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: detailBean?.posts?.length ?? 0),

                    SizedBox(
                        height: Utils.navigationBarHeight - Utils.topSafeHeight)
                  ]),
                ),
          BottomAppbar(actions: <Widget>[
            IconButton(icon: Icon(FeatherIcons.heart), onPressed: () {}),
            IconButton(
                icon: Badge(
                    shape: BadgeShape.circle,
                    badgeContent: Text('${post?.commentCount}',
                        style: TextStyle(color: Colors.white, fontSize: 10)),
                    child: Icon(FeatherIcons.messageSquare)),
                onPressed: () => pushNewPage(
                    context,
                    CommentPage(
                        id: post?.id,
                        dataType: '${post?.dataType}',
                        commentCount: post?.commentCount))),
            IconButton(icon: Icon(FeatherIcons.share), onPressed: () {})
          ]),
        ]),
      ),
    );
  }

  void getBookInfo(int id) async {
    responseBean = await ApiService.getQDailyArticleInfoData(id);
    post = responseBean?.post;
    author = responseBean?.author;

    detailBean = await ApiService.getQDailyBookData(id);

    setState(() {});
  }
}
