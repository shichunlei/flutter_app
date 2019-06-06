import 'package:flutter/material.dart';
import 'package:flutter_app/bean/bean_index.dart';
import 'package:flutter_app/qdaily/ui/banner_view.dart';
import 'package:flutter_app/service/api_service.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import '../page_index.dart';
import 'article_detail.dart';
import 'lab/lab_i_say.dart';
import 'lab/lab_ratio.dart';
import 'lab/lab_vote.dart';
import 'lab/lab_you_guess.dart';
import 'ui/item_column_type_one.dart';
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
  List<ColumnBean> columns = [];

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
      List<Widget> _list = [];

      this.lastKey = responseBean?.lastKey;
      isLoadComplete = !responseBean.hasMore;

      banners.addAll(responseBean.banners);
      if (responseBean.banners.isNotEmpty)
        _list..add(BannerView(banners: banners));

      if (responseBean.feeds.isNotEmpty) {
        feeds.addAll(responseBean?.feeds);

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
          _list..add(view);
        });
      }

      if (responseBean.columns.isNotEmpty) {
        columns.addAll(responseBean.columns);

        responseBean.columns.forEach((column) {
          Widget view = ItemColumnTypeOne(
              id: column.id,
              icon: column.icon,
              title: column.name,
              imageLarge: column.imageLarge,
              showType: column.showType);

          _list.insert(column.location, view);
        });
      }
      list.addAll(_list);
      debugPrint(
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
            physics: const AlwaysScrollableScrollPhysics(),
            separatorBuilder: (BuildContext context, int index) =>
                Container(height: 5, color: Colors.grey[200]),
            itemBuilder: (BuildContext context, int index) => list[index],
            itemCount: list.length));
  }
}
