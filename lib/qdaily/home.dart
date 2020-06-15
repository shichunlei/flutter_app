import 'package:flutter/material.dart';
import 'package:flutter_app/enum/enum.dart';

import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import '../page_index.dart';
import 'index.dart';

class QHomePage extends StatefulWidget {
  QHomePage({Key key}) : super(key: key);

  @override
  createState() => _HomePageState();
}

class _HomePageState extends State<QHomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  String lastKey = '0';

  ResponseBean responseBean;
  List<BannersBean> banners = [];

  bool isLoadComplete = false;

  List<Widget> list = [];

  LoaderState state = LoaderState.Loading;

  @override
  void initState() {
    super.initState();

    getHomeData(lastKey);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: LoaderContainer(
          loaderState: state,
          contentView: EasyRefresh(
              footer: BallPulseFooter(),
              onLoad: isLoadComplete ? null : () async => getHomeData(lastKey),
              child: ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (BuildContext context, int index) =>
                      Gaps.vGap5,
                  itemBuilder: (BuildContext context, int index) => list[index],
                  itemCount: list.length)),
        ));
  }

  void getHomeData(String lastKey) async {
    responseBean = await ApiService.getQDailyHomeData(lastKey);

    if (responseBean == null) {
      // 请求失败
      state = LoaderState.Failed;
    } else {
      List<Widget> _list = [];

      this.lastKey = responseBean?.lastKey;
      isLoadComplete = !responseBean.hasMore;

      banners.addAll(responseBean?.banners);
      if (responseBean.banners.isNotEmpty)
        _list..add(BannerView(banners: banners));

      if (responseBean.feeds.isNotEmpty) {
        responseBean?.feeds?.forEach((feed) {
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
                showTop: true,
                onTap: () {
                  String tag =
                      'labs-${feed?.post?.id}-${feed?.post?.category?.id}';

                  if (feed?.post?.category?.id == 1) {
                    // 投票
                    pushNewPage(
                        context, LabVotePage(tag: tag, post: feed?.post));
                  }
                  if (feed?.post?.category?.id == 2) {
                    // 我说
                    pushNewPage(
                        context, LabISayPage(tag: tag, post: feed?.post));
                  }
                  if (feed?.post?.category?.id == 3) {
                    // 焦点小组
                    // pushNewPage(context, LabISayPage(tag: tag, post: feed?.post));
                  }
                  if (feed?.post?.category?.id == 4) {
                    // 42%
                    pushNewPage(
                        context, LabRatioPage(post: feed?.post, tag: tag));
                  }
                  if (feed?.post?.category?.id == 5) {
                    //你猜
                    pushNewPage(
                        context, LabYouGuessPage(post: feed?.post, tag: tag));
                  }
                  if (feed?.post?.category?.id == 6) {
                    // 你谁啊
                    pushNewPage(
                        context, LabWhoPage(post: feed?.post, tag: tag));
                  }
                },
                tag: 'labs-${feed?.post?.id}');
          }
          _list..add(view);
        });
      }

      if (responseBean.columns.isNotEmpty) {
        responseBean.columns.forEach((column) {
          Widget view = ItemColumnTypeView(
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

      state = LoaderState.Succeed;
    }
    setState(() {});
  }
}
