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

  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();

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
        refreshFooter: BallPulseFooter(
            key: _footerKey, color: Colors.red, backgroundColor: Colors.white),
        loadMore: isLoadComplete ? null : () async => getLabsData(lastKey),
        child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                Container(height: 5, color: Colors.grey[200]),
            itemBuilder: (context, index) {
              return ItemFeedTypeZero(
                  feedsBean: feeds[index],
                  tag: 'labs-${feeds[index]?.post?.id}',
                  isNew: index == 0 || index == 1,
                  onTap: () {
                    if (feeds[index].post.category.id == 2 // 我说
                            ||
                            feeds[index].post.category.id == 3 // 焦点小组
                        ) {
                      pushNewPage(
                          context,
                          LabISayPage(
                              id: feeds[index]?.post?.id,
                              tag:
                                  'labs-${feeds[index]?.post?.id}-${feeds[index]?.post?.category?.id}',
                              post: feeds[index]?.post,
                              isNew: index == 0 || index == 1));
                    } else if (feeds[index].post.category.id == 1) // 投票
                    {
                      pushNewPage(
                          context,
                          LabVotePage(
                              id: feeds[index]?.post?.id,
                              tag:
                                  'labs-${feeds[index]?.post?.id}-${feeds[index]?.post?.category?.id}',
                              post: feeds[index]?.post,
                              isNew: index == 0 || index == 1));
                    } else if (feeds[index].post.category.id == 6 // 你谁啊
                            ||
                            feeds[index].post.category.id == 5 // 你猜
                        ) //
                    {
                      pushNewPage(
                          context, LabYouGuessPage(post: feeds[index]?.post));
                    } else if (feeds[index].post.category.id == 4) // 42%
                    {
                      pushNewPage(
                          context, LabRatioPage(id: feeds[index]?.post?.id));
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
