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

  ResponseBean data;
  List<FeedsBean> feeds = [];

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
        body: feeds.length == 0 ? LoadingWidget() : _buildBodyView());
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
        footer: BallPulseFooter(),
        onLoad: isLoadComplete
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
                      String tag =
                          'labs-${feeds[index]?.post?.id}-${feeds[index]?.post?.category?.id}';

                      if (feeds[index]?.post?.category?.id == 1) {
                        // 投票
                        pushNewPage(context,
                            LabVotePage(tag: tag, post: feeds[index]?.post));
                      }
                      if (feeds[index]?.post?.category?.id == 2) {
                        // 我说
                        pushNewPage(context,
                            LabISayPage(tag: tag, post: feeds[index]?.post));
                      }
                      if (feeds[index]?.post?.category?.id == 3) {
                        // 焦点小组
                        // pushNewPage(context, LabISayPage(tag: tag, post: feed?.post));
                      }
                      if (feeds[index]?.post?.category?.id == 4) {
                        // 42%
                        pushNewPage(context,
                            LabRatioPage(post: feeds[index]?.post, tag: tag));
                      }
                      if (feeds[index]?.post?.category?.id == 5) {
                        //你猜
                        pushNewPage(
                            context,
                            LabYouGuessPage(
                                post: feeds[index]?.post, tag: tag));
                      }
                      if (feeds[index]?.post?.category?.id == 6) {
                        // 你谁啊
                        pushNewPage(context,
                            LabWhoPage(post: feeds[index]?.post, tag: tag));
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
