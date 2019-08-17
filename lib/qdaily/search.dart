import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import '../page_index.dart';
import 'index.dart';

class SearchPage extends StatefulWidget {
  final String query;

  SearchPage({Key key, this.query}) : super(key: key);

  @override
  createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var keywords;
  String lastKey = '0';

  DataBean data;
  List<FeedsBean> feeds = [];

  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();

  bool isLoadComplete = false;

  @override
  void initState() {
    super.initState();

    keywords = widget.query;

    getSearchData(keywords, lastKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: feeds.length == 0 ? getLoadingWidget() : _buildBodyView());
  }

  Future<void> getSearchData(String keywords, String lastKey) async {
    data = await ApiService.getQDailySearchData(keywords, lastKey);

    if (data == null) {
      ///
    } else {
      this.lastKey = data?.lastKey;
      isLoadComplete = !data.hasMore;
      feeds.addAll(data.feeds);
      setState(() {});
    }
  }

  Widget _buildBodyView() {
    return EasyRefresh(
        refreshFooter: BallPulseFooter(
            key: _footerKey, color: Colors.red, backgroundColor: Colors.white),
        loadMore: isLoadComplete
            ? null
            : () async => getSearchData(keywords, lastKey),
        child: ListView.separated(
            itemBuilder: (context, index) {
              FeedsBean feed = feeds[index];
              Widget view;

              if (feed.type == 1) {
                if (feed.newsList.isNotEmpty) {
                  view = ItemFeedTypeIndex(
                      feedsBean: feed,
                      onTap: () => pushNewPage(
                          context, ArticleDetail(id: feed?.post?.id)));
                } else {
                  view = ItemFeedTypeOne(
                      feedsBean: feed,
                      onTap: () => pushNewPage(
                          context, ArticleDetail(id: feed?.post?.id)));
                }
              }
              if (feed.type == 2) {
                view = ItemFeedTypeTwo(
                    feedsBean: feed,
                    onTap: () => pushNewPage(
                        context, ArticleDetail(id: feed?.post?.id)));
              }
              if (feed.type == 0) {
                view = ItemFeedTypeZero(
                    feedsBean: feed,
                    onTap: () {
                      if (feed?.post?.category?.id == 2 // 我说
                              ||
                              feed?.post?.category?.id == 3 // 焦点小组
                          ) {
                        pushNewPage(
                            context,
                            LabISayPage(
                                id: feed?.post?.id,
                                tag:
                                    'labs-${feed?.post?.id}-${feed?.post?.category?.id}',
                                post: feed?.post));
                      } else if (feed?.post?.category?.id == 1) // 投票
                      {
                        pushNewPage(
                            context,
                            LabVotePage(
                                id: feed?.post?.id,
                                tag:
                                    'labs-${feed?.post?.id}-${feed?.post?.category?.id}',
                                post: feed?.post));
                      } else if (feed?.post?.category?.id == 6 // 你谁啊
                              ||
                              feed?.post?.category?.id == 5 // 你猜
                          ) {
                        pushNewPage(context, LabYouGuessPage(post: feed?.post));
                      } else if (feed?.post?.category?.id == 4) // 42%
                      {
                        pushNewPage(context, LabRatioPage(id: feed?.post?.id));
                      }
                    },
                    tag: 'labs-${feed?.post?.id}');
              }

              return view;
            },
            physics: const AlwaysScrollableScrollPhysics(),
            separatorBuilder: (BuildContext context, int index) =>
                Container(height: 5, color: Colors.grey[200]),
            itemCount: feeds.length));
  }
}
