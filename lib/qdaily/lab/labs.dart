import 'package:flutter/material.dart';
import '../../page_index.dart';
import '../index.dart';

import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class LabsPage extends StatefulWidget {
  final String title;

  LabsPage({Key key, this.title}) : super(key: key);

  @override
  createState() => _LabsPageState();
}

class _LabsPageState extends State<LabsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  String lastKey = '0';

  bool isLoadComplete = false;

  ResponseBean responseBean;

  LoaderState status = LoaderState.Loading;

  List<Widget> list = [];

  @override
  void initState() {
    super.initState();

    getLabsData(lastKey);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: LoaderContainer(
            loaderState: status,
            contentView: EasyRefresh(
                footer: BallPulseFooter(),
                onLoad:
                    isLoadComplete ? null : () async => getLabsData(lastKey),
                child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        Gaps.vGap5,
                    itemBuilder: (context, index) {
                      return list[index];
                    },
                    itemCount: list.length))));
  }

  void getLabsData(String lastKey) async {
    responseBean = await ApiService.getQDailyLabsData(lastKey);

    if (responseBean == null) {
      // 请求失败
      status = LoaderState.Failed;
    } else {
      List<Widget> _list = [];

      this.lastKey = responseBean?.lastKey;
      isLoadComplete = !responseBean.hasMore;

      responseBean?.feeds?.forEach((item) {
        int index = responseBean.feeds.indexOf(item);

        Widget view;
        view = ItemFeedTypeZero(
            feedsBean: item,
            tag: 'labs-${item?.post?.id}',
            isNew: index == 0 || index == 1,
            onTap: () {
              String tag = 'labs-${item?.post?.id}-${item?.post?.category?.id}';

              if (item?.post?.category?.id == 1) {
                // 投票
                pushNewPage(context, LabVotePage(tag: tag, post: item?.post));
              }
              if (item?.post?.category?.id == 2) {
                // 我说
                pushNewPage(context, LabISayPage(tag: tag, post: item?.post));
              }
              if (item?.post?.category?.id == 3) {
                // 焦点小组
                // pushNewPage(context, LabISayPage(tag: tag, post: feed?.post));
              }
              if (item?.post?.category?.id == 4) {
                // 42%
                pushNewPage(context, LabRatioPage(post: item?.post, tag: tag));
              }
              if (item?.post?.category?.id == 5) {
                //你猜
                pushNewPage(
                    context, LabYouGuessPage(post: item?.post, tag: tag));
              }
              if (item?.post?.category?.id == 6) {
                // 你谁啊
                pushNewPage(context, LabWhoPage(post: item?.post, tag: tag));
              }
            });

        _list..add(view);
      });

      if (responseBean.topics.isNotEmpty) {
        responseBean.topics.forEach((item) {
          Widget view = ItemLabTopicsView(insertContent: item.insertContent);
          _list..insert(item.insertLocation, view);
        });
      }

      list.addAll(_list);
      status = LoaderState.Succeed;
    }
    setState(() {});
  }
}
