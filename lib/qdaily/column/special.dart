import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter/material.dart';
import '../index.dart';

import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import '../../page_index.dart';

class SpecialPage extends StatefulWidget {
  final int columnId;
  final String imageTag;
  final String image;

  SpecialPage({Key key, @required this.columnId, this.imageTag, this.image})
      : super(key: key);

  @override
  createState() => _SpecialPageState();
}

class _SpecialPageState extends State<SpecialPage> {
  String lastKey = '0';

  ColumnBean column;

  ResponseBean responseBean;

  List<FeedsBean> feeds = [];

  bool isLoadComplete = false;

  double width;

  LoaderState status = LoaderState.Loading;

  @override
  void initState() {
    super.initState();

    width = Utils.width;

    getColumnInfo(widget.columnId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: LoaderContainer(
          loaderState: status,
          contentView: EasyRefresh.custom(
            footer: BallPulseFooter(),
            header: MaterialHeader(),
            onLoad: isLoadComplete
                ? null
                : () async => getColumnIndex(lastKey, widget.columnId),
            onRefresh: () async => getColumnInfo(widget.columnId),
            slivers: <Widget>[
              _buildHeaderView(),
              _buildSubscriber(),
              _buildDataView(),
            ],
          ),
        ));
  }

  Widget _buildHeaderView() {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      actions: <Widget>[
        IconButton(
            icon: Icon(Feather.share, color: Colors.white), onPressed: null)
      ],
      expandedHeight: width,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
            tag: widget.imageTag,
            child: ImageLoadView(
              '${widget.image}',
              width: width,
              height: width,
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('${column?.name}',
                        style: TextStyle(fontSize: 30, color: Colors.white)),
                    Gaps.vGap5,
                    Text('${column?.description}',
                        style: TextStyle(fontSize: 15, color: Colors.white)),
                    Gaps.vGap10,
                    CircleAvatar(
                        child: Image.asset('images/qdaily/all_column_unsub.png',
                            height: 55, width: 55),
                        radius: 30,
                        backgroundColor: Colors.white),
                    column != null && column.authors.length > 0
                        ? ColumnAuthorView(author: column?.authors?.first)
                        : Gaps.vGap20
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Widget _buildSubscriber() {
    double avatarSize = (width - 2 * 30 - 5 * 8) / 6;

    return SliverToBoxAdapter(
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(children: <Widget>[
            LineViewLine(
                child: Text('  ${column?.subscriberNum}人订阅了本栏目  ',
                    style: TextStyle(color: Colors.grey))),
            Gaps.vGap10,
            Wrap(
                spacing: 8,
                runSpacing: 10,
                children: column != null
                    ? column.subscribers.map((subscriber) {
                        return ImageLoadView('${subscriber.avatar}',
                            width: avatarSize,
                            height: avatarSize,
                            shape: BoxShape.circle);
                      }).toList()
                    : [])
          ])),
    );
  }

  Widget _buildDataView() {
    return column?.showType == 2 // gridView
        ? SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 704 / 1000,
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5),
            delegate: SliverChildBuilderDelegate(
                (_, index) => ItemFeedTypeBook(
                    feed: feeds[index],
                    onTap: () => pushNewPage(
                        context, BookDetailPage(id: feeds[index]?.post?.id)),
                    width: (width - 5) / 2),
                childCount: feeds.length),
          )
        : column?.showType == 1 // listView
            ? SliverList(
                delegate: SliverChildBuilderDelegate(
                    (_, index) => ItemFeedTypeTwo(
                        feedsBean: feeds[index],
                        onTap: () => pushNewPage(context,
                            ArticleDetail(id: feeds[index]?.post?.id))),
                    childCount: feeds.length),
              )
            : SliverToBoxAdapter();
  }

  void getColumnInfo(int columnId) async {
    responseBean = await ApiService.getQDailyColumnInfo(columnId);
    feeds.clear();

    if (responseBean == null) {
      // 请求失败
      debugPrint('网络请求失败');
      status = LoaderState.Failed;
    } else {
      column = responseBean.column;
      this.lastKey = responseBean.lastKey;
      feeds.addAll(responseBean.feeds);
      isLoadComplete = !responseBean.hasMore;
      status = LoaderState.Succeed;
    }
    setState(() {});
  }

  void getColumnIndex(String lastKey, int columnId) async {
    ResponseBean responseBean =
        await ApiService.getQDailyColumnIndex(columnId, lastKey);

    if (responseBean == null) {
      // 请求失败
      debugPrint('网络请求失败');
    } else {
      this.lastKey = responseBean.lastKey;
      feeds.addAll(responseBean.feeds);
      isLoadComplete = !responseBean.hasMore;

      debugPrint('${this.lastKey}=============$isLoadComplete');
      setState(() {});
    }
  }
}
