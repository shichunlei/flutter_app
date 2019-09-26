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

  List<FeedsBean> feeds = [];

  bool isLoadComplete = false;

  ResponseBean responseBean;

  @override
  void initState() {
    super.initState();

    getLabsData(lastKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: feeds.length == 0 ? getLoadingWidget() : _buildBodyView());
  }

  Widget _buildBodyView() {
    return EasyRefresh(
        footer: BallPulseFooter(),
        onLoad: isLoadComplete ? null : () async => getLabsData(lastKey),
        child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) => Gaps.vGap5,
            itemBuilder: (context, index) {
              return ItemFeedTypeZero(
                  feedsBean: feeds[index],
                  tag: 'labs-${feeds[index]?.post?.id}',
                  isNew: index == 0 || index == 1,
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
                      pushNewPage(context,
                          LabYouGuessPage(post: feeds[index]?.post, tag: tag));
                    }
                    if (feeds[index]?.post?.category?.id == 6) {
                      // 你谁啊
                      pushNewPage(context,
                          LabWhoPage(post: feeds[index]?.post, tag: tag));
                    }
                  });
            },
            itemCount: feeds.length));
  }

  void getLabsData(String lastKey) async {
    responseBean = await ApiService.getQdailyLabsData(lastKey);

    if (responseBean == null) {
      // 请求失败
    } else {
      this.lastKey = responseBean?.lastKey;
      feeds.addAll(responseBean?.feeds);
      isLoadComplete = !responseBean.hasMore;

      print('${this.lastKey}=============$isLoadComplete');
      setState(() {});
    }
  }
}
