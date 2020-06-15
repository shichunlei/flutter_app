import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/phoenix_header.dart';

import '../page_index.dart';
import 'index.dart';

class TagsPage extends StatefulWidget {
  final String title;
  final int id;

  TagsPage({Key key, this.id, this.title}) : super(key: key);

  @override
  createState() => _TagsPageState();
}

class _TagsPageState extends State<TagsPage> {
  String lastKey = '0';

  List<FeedsBean> feeds = [];

  bool isLoadComplete = false;

  ResponseBean dataBean;

  LoaderState status = LoaderState.Loading;

  @override
  void initState() {
    super.initState();

    getTagNews(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(title: Text('${widget.title}')),
        body: feeds.length == 0 ? LoadingWidget() : _buildBodyView());
  }

  Widget _buildBodyView() {
    return LoaderContainer(
      loaderState: status,
      contentView: EasyRefresh(
          header: PhoenixHeader(),
          footer: BallPulseFooter(),
          onLoad: isLoadComplete
              ? null
              : () async => getTagNews(widget.id, lastKey: lastKey),
          onRefresh: () async => getTagNews(widget.id),
          child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) => Gaps.vGap5,
              itemBuilder: (context, index) {
                return feeds[index].type == 1
                    ? ItemFeedTypeOne(
                        feedsBean: feeds[index],
                        onTap: () => pushNewPage(
                            context, ArticleDetail(id: feeds[index]?.post?.id)))
                    : ItemFeedTypeTwo(
                        feedsBean: feeds[index],
                        onTap: () => pushNewPage(context,
                            ArticleDetail(id: feeds[index]?.post?.id)));
              },
              itemCount: feeds.length)),
    );
  }

  void getTagNews(int tagId, {String lastKey = '0'}) async {
    if (lastKey == '0') {
      feeds.clear();
    }
    dataBean = await ApiService.getQDailyNewsDataByCategory(tagId, lastKey);

    if (dataBean == null) {
      // 请求失败
      status = LoaderState.Failed;
    } else {
      this.lastKey = dataBean?.lastKey;
      feeds.addAll(dataBean?.feeds);
      isLoadComplete = !dataBean.hasMore;

      print('${this.lastKey}=============$isLoadComplete');

      status = LoaderState.Succeed;
    }
    setState(() {});
  }
}
