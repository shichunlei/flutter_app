import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bean/qdaily.dart';
import 'package:flutter_app/bean/qdaily_app.dart';
import 'package:flutter_app/qdaily/ui/item_feed_type_two.dart';
import 'package:flutter_app/qdaily/ui/line_text_line.dart';
import 'package:flutter_app/service/api_service.dart';
import 'package:flutter_app/utils/loading_util.dart';
import 'package:flutter_app/utils/route_util.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import '../../ui/image_load_view.dart';
import '../article_detail.dart';
import '../book_detail.dart';
import '../ui/item_feed_typr_book.dart';

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
  List<AuthorBean> authors = [];
  List<SubscriberBean> subscribers = [];

  ResponseBean responseBean;

  List<FeedsBean> feeds = [];

  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();

  bool isLoadComplete = false;

  double width;

  @override
  void initState() {
    super.initState();

    width = Utils.width;

    getColumnInfo(widget.columnId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: feeds.isEmpty || column == null
          ? getLoadingWidget()
          : Stack(children: <Widget>[
              EasyRefresh(
                refreshFooter: BallPulseFooter(
                    color: Colors.red,
                    backgroundColor: Colors.white,
                    key: _footerKey),
                loadMore: isLoadComplete
                    ? null
                    : () async => getColumnIndex(lastKey, widget.columnId),
                child: ListView(
                    padding: EdgeInsets.only(top: 0),
                    children: <Widget>[
                      _buildHeaderView(),
                      _buildSubscriber(),
                      _buildDataView()
                    ]),
              ),
              Container(
                height: Utils.navigationBarHeight,
                child: AppBar(
                    backgroundColor: Colors.transparent,
                    actions: <Widget>[
                      IconButton(
                          icon: Icon(FeatherIcons.share, color: Colors.white),
                          onPressed: null)
                    ],
                    elevation: 0.0),
              )
            ]),
    );
  }

  Widget _buildHeaderView() {
    return Stack(alignment: Alignment.bottomCenter, children: <Widget>[
      Hero(
          tag: widget.imageTag,
          child: ImageLoadView('${widget.image}',
              width: width, height: width, fit: BoxFit.cover)),
      Container(
        padding: EdgeInsets.only(left: 30, right: 30, bottom: 20),
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Text('${column?.name}',
              style: TextStyle(fontSize: 30, color: Colors.white)),
          SizedBox(height: 5),
          Text('${column?.description}',
              style: TextStyle(fontSize: 15, color: Colors.white)),
          SizedBox(height: 10),
          CircleAvatar(
              child: Image.asset('images/qdaily/all_column_unsub.png',
                  height: 55, width: 55),
              radius: 30,
              backgroundColor: Colors.white)
        ]),
      )
    ]);
  }

  Widget _buildSubscriber() {
    double avatarSize = (width - 2 * 30 - 5 * 8) / 6;

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Column(children: <Widget>[
        LineTextLine(text: '  ${column?.subscriberNum}人订阅了本栏目  '),
        SizedBox(height: 10),
        Wrap(
            spacing: 8,
            runSpacing: 10,
            children: subscribers.map((subscriber) {
              return ImageLoadView(
                '${subscriber.avatar}',
                width: avatarSize,
                height: avatarSize,
                borderRadius: BorderRadius.all(Radius.circular(avatarSize / 2)),
              );
            }).toList())
      ]),
    );
  }

  Widget _buildDataView() {
    return column?.showType == 2 // gridview
        ? GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 704 / 1000,
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5),
            itemBuilder: (context, index) => ItemFeedTypeBook(
                feed: feeds[index],
                onTap: () => pushNewPage(
                    context, BookDetailPage(id: feeds[index]?.post?.id)),
                width: (width - 5) / 2),
            itemCount: feeds.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            primary: false)
        : column?.showType == 1 // listview
            ? ListView.builder(
                itemBuilder: (context, index) => ItemFeedTypeTwo(
                    feedsBean: feeds[index],
                    onTap: () => pushNewPage(
                        context, ArticleDetail(id: feeds[index]?.post?.id))),
                itemCount: feeds.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                primary: false)
            : Center();
  }

  void getColumnInfo(int columnId) async {
    responseBean = await ApiService.getQdailyColumnInfo(columnId);

    if (responseBean == null) {
      // 请求失败
      print('网络请求失败');
    } else {
      column = responseBean.column;
      authors.addAll(responseBean.authors);
      subscribers.addAll(responseBean.subscribers);
      setState(() {});
    }

    getColumnIndex(lastKey, columnId);
  }

  void getColumnIndex(String lastKey, int columnId) async {
    ResponseBean responseBean =
        await ApiService.getQdailyColumnIndex(columnId, lastKey);

    if (responseBean == null) {
      // 请求失败
      print('网络请求失败');
    } else {
      this.lastKey = responseBean.lastKey;
      feeds.addAll(responseBean.feeds);
      isLoadComplete = !responseBean.hasMore;

      print('${this.lastKey}=============$isLoadComplete');
      setState(() {});
    }
  }
}
