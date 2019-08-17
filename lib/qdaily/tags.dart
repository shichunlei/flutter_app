import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import '../page_index.dart';
import 'index.dart';

class TagsPage extends StatefulWidget {
  final String title;
  final int id;
  final String type;

  TagsPage({Key key, this.id, this.title, this.type}) : super(key: key);

  @override
  createState() => _TagsPageState();
}

class _TagsPageState extends State<TagsPage> {
  String lastKey = '0';

  List<FeedsBean> feeds = [];

  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();

  bool isLoadComplete = false;

  ResponseBean dataBean;

  @override
  void initState() {
    super.initState();

    getTagNews(widget.id, lastKey: lastKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text('${widget.title}')),
        body: feeds.length == 0 ? getLoadingWidget() : _buildBodyView());
  }

  Widget _buildBodyView() {
    return EasyRefresh(
        refreshFooter: BallPulseFooter(
            key: _footerKey, color: Colors.red, backgroundColor: Colors.white),
        loadMore: isLoadComplete
            ? null
            : () async => getTagNews(widget.id, lastKey: lastKey),
        child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                Container(height: 5, color: Colors.grey[200]),
            itemBuilder: (context, index) {
              return feeds[index].type == 1
                  ? ItemFeedTypeOne(
                      feedsBean: feeds[index],
                      onTap: () => pushNewPage(
                          context, ArticleDetail(id: feeds[index]?.post?.id)))
                  : ItemFeedTypeTwo(
                      feedsBean: feeds[index],
                      onTap: () => pushNewPage(
                          context, ArticleDetail(id: feeds[index]?.post?.id)));
            },
            itemCount: feeds.length));
  }

  void getTagNews(int tagId, {String lastKey = '0'}) async {
    dataBean = await ApiService.getQdailyNewsDataByCategory(tagId, lastKey);

    if (dataBean == null) {
      // 请求失败
    } else {
      this.lastKey = dataBean?.lastKey;
      feeds.addAll(dataBean?.feeds);
      isLoadComplete = !dataBean.hasMore;

      print('${this.lastKey}=============$isLoadComplete');
      setState(() {});
    }
  }
}
