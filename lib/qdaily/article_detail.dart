import 'package:badges/badges.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_html/flutter_html.dart';

import '../page_index.dart';

import 'index.dart';

class ArticleDetail extends StatefulWidget {
  final int id;

  ArticleDetail({Key key, @required this.id}) : super(key: key);

  @override
  createState() => _ArticleDetailState();
}

class _ArticleDetailState extends State<ArticleDetail> {
  DetailBean detailBean;
  PostBean post;
  AuthorBean author;

  ResponseBean responseBean;

  @override
  void initState() {
    super.initState();

    getArticleInfo(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: detailBean != null && post != null && author != null
          ? SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(children: <Widget>[
                /// 头部
                detailBean.isFullPage
                    ? _buildLongHeader()
                    : _buildShortHeader(),

                /// 文章简介
                Offstage(
                    offstage: post?.description?.length == 0 ||
                        post.description == null,
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
                    data: '${detailBean.description}',
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
                        post: detailBean.posts[index],
                        onTap: () => pushReplacement(context,
                            ArticleDetail(id: detailBean.posts[index].id))),
                    padding: EdgeInsets.only(top: 0),
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: detailBean.posts.length),
              ]),
            )
          : LoadingWidget(),
      bottomNavigationBar: BottomAppbar(actions: <Widget>[
        IconButton(
            icon: Badge(
                shape: BadgeShape.circle,
                badgeContent: Text('${post?.praiseCount ?? 0}',
                    style: TextStyle(color: Colors.white, fontSize: 10)),
                child: Icon(Feather.heart)),
            onPressed: () {}),
        IconButton(
            icon: Badge(
                shape: BadgeShape.circle,
                badgeContent: Text('${post?.commentCount ?? 0}',
                    style: TextStyle(color: Colors.white, fontSize: 10)),
                child: Icon(Feather.message_square)),
            onPressed: () => pushNewPage(
                context,
                CommentPage(
                    id: post?.id,
                    dataType: '${post?.dataType}',
                    commentCount: post?.commentCount))),
        IconButton(icon: Icon(Feather.share), onPressed: () {})
      ]),
    );
  }

  Widget _buildShortHeader() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ImageLoadView(
            '${post.image}',
            width: Utils.width,
            height: Utils.width * 202 / 340,
            alignment: Alignment.bottomCenter,
            child: _buildColumnView(
                0, Utils.navigationBarHeight - Utils.topSafeHeight),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 20),
            child: Column(children: <Widget>[
              Row(children: <Widget>[
                ImageLoadView('${post.category.normal}',
                    width: 20, height: 20, shape: BoxShape.circle),
                SizedBox(width: 5),
                Text('${post.category.title}')
              ]),
              SizedBox(height: 8),
              Text('${post.title}', style: TextStyle(fontSize: 22)),
              SizedBox(height: 8),
              Row(children: <Widget>[
                ImageLoadView('${author.avatar}',
                    width: 25, height: 25, shape: BoxShape.circle),
                SizedBox(width: 5),
                Text('${author.name}'),
                Spacer(),
                Text(post?.publishTime)
              ])
            ]),
          ),
        ]);
  }

  Widget _buildLongHeader() {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: ImageLoadView(
        '${detailBean.image}',
        height: Utils.height,
        width: Utils.width,
        fit: BoxFit.fitHeight,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildColumnView(Utils.topSafeHeight, Utils.navigationBarHeight),
              Container(
                padding: EdgeInsets.only(
                    left: 20, right: 20, bottom: Utils.navigationBarHeight),
                child: Column(children: <Widget>[
                  Row(children: <Widget>[
                    ImageLoadView('${post.category.imageLab}',
                        width: 20, height: 20, shape: BoxShape.circle),
                    SizedBox(width: 5),
                    Text('${post.category.title}',
                        style: TextStyle(color: Colors.white))
                  ]),
                  SizedBox(height: 8),
                  Text('${post.title}',
                      style: TextStyle(fontSize: 22, color: Colors.white)),
                  SizedBox(height: 8),
                  Row(children: <Widget>[
                    ImageLoadView('${author.avatar}',
                        width: 25, height: 25, shape: BoxShape.circle),
                    SizedBox(width: 5),
                    Text('${author.name}',
                        style: TextStyle(color: Colors.white)),
                    Spacer(),
                    Text(post?.publishTime,
                        style: TextStyle(color: Colors.white))
                  ])
                ]),
              )
            ]),
      ),
    );
  }

  Widget _buildColumnView(double topPadding, double height) {
    return post.column == null
        ? Center()
        : InkWell(
            onTap: () => pushNewPage(
                context,
                SpecialPage(
                    columnId: post.column.id,
                    image: post.column.imageLarge,
                    imageTag: 'cloumn-image-${post.column.id}')),
            child: Container(
              color: Color.fromRGBO(0, 0, 0, 0.4),
              height: height,
              padding: EdgeInsets.only(top: topPadding, left: 20, right: 20),
              child: Row(children: <Widget>[
                Hero(
                    tag: 'cloumn-image-${post.column.id}',
                    child: ImageLoadView('${post.column.image}',
                        width: 40, height: 40)),
                SizedBox(width: 10),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('${post.column.name}',
                          style: TextStyle(fontSize: 13, color: Colors.white)),
                      SizedBox(height: 4),
                      Text(
                          '${post.column.subscriberNum} 人已订阅，更新至${post.column.postCount}篇',
                          style: TextStyle(fontSize: 12, color: Colors.white))
                    ]),
                Spacer(),
                Image.asset('images/qdaily/all_column_unsub.png',
                    width: 40, height: 40)
              ]),
            ));
  }

  void getArticleInfo(int id) async {
    responseBean = await ApiService.getQDailyArticleInfoData(id);
    debugPrint('------------------${responseBean.toString()}');

    post = responseBean.post;
    author = responseBean.author;

    debugPrint('${post.id}===============${post.dataType}');

    detailBean = await ApiService.getQDailyArticleData(id);

    if (mounted) setState(() {});
  }
}
