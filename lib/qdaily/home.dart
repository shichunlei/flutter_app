import 'package:flutter/material.dart';
import 'package:flutter_app/bean/qdaily.dart';
import 'package:flutter_app/bean/qdaily_app.dart';
import 'package:flutter_app/qdaily/ui/banner_view.dart';
import 'package:flutter_app/service/api_service.dart';
import 'package:flutter_app/utils/loading_util.dart';
import 'package:flutter_app/utils/route_util.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'article_detail.dart';
import 'lab/lab_i_say.dart';
import 'lab/lab_ratio.dart';
import 'lab/lab_vote.dart';
import 'lab/lab_you_guess.dart';
import 'ui/item_feed_type_index.dart';
import 'ui/item_feed_type_one.dart';
import 'ui/item_feed_type_two.dart';
import 'ui/item_feed_type_zero.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  String lastKey = '0';

  ResponseBean responseBean;
  List<FeedsBean> feeds = [];
  List<BannersBean> banners = [];

  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();

  bool isLoadComplete = false;

  List<Widget> list = [];

  @override
  void initState() {
    super.initState();

    getHomeData(lastKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: feeds.length == 0 ? getLoadingWidget() : _buildBodyView());
  }

  void getHomeData(String lastKey) async {
    responseBean = await ApiService.getQdailyHomeData(lastKey);

    if (responseBean == null) {
      // 请求失败
    } else {
      this.lastKey = responseBean?.lastKey;
      feeds.addAll(responseBean?.feeds);
      isLoadComplete = !responseBean.hasMore;

      banners.addAll(responseBean.banners);
      if (responseBean.banners.isNotEmpty)
        list..add(BannerView(banners: banners));

      responseBean.feeds.forEach((feed) {
        Widget view;
        if (feed.type == 1) {
          if (feed.newsList.isNotEmpty) {
            view = ItemFeedTypeIndex(
                feedsBean: feed,
                onTap: () =>
                    pushNewPage(context, ArticleDetail(id: feed?.post?.id)));
          } else {
            view = ItemFeedTypeOne(
                feedsBean: feed,
                onTap: () =>
                    pushNewPage(context, ArticleDetail(id: feed?.post?.id)));
          }
        }
        if (feed.type == 2) {
          view = ItemFeedTypeTwo(
              feedsBean: feed,
              onTap: () =>
                  pushNewPage(context, ArticleDetail(id: feed?.post?.id)));
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
                    ) //
                {
                  pushNewPage(context, LabYouGuessPage(post: feed?.post));
                } else if (feed?.post?.category?.id == 4) // 42%
                {
                  pushNewPage(context, LabRatioPage(id: feed?.post?.id));
                }
              },
              tag: 'labs-${feed?.post?.id}');
        }
        list..add(view);
      });
      print(
          '${this.lastKey}=============$isLoadComplete===============${list.length}');
      setState(() {});
    }
  }

  Widget _buildBodyView() {
    return EasyRefresh(
        refreshFooter: BallPulseFooter(
            key: _footerKey, color: Colors.red, backgroundColor: Colors.white),
        loadMore: isLoadComplete ? null : () async => getHomeData(lastKey),
        child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return Center();
            },
            itemBuilder: (BuildContext context, int index) => list[index],
            itemCount: list.length));
  }
}
