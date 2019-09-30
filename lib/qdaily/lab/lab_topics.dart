import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';

import '../../page_index.dart';
import '../index.dart';

class TopicLabsPage extends StatefulWidget {
  final String title;
  final int id;

  TopicLabsPage({Key key, this.title, this.id}) : super(key: key);

  @override
  createState() => _TopicLabsPageState();
}

class _TopicLabsPageState extends State<TopicLabsPage> {
  ResponseBean responseBean;

  List<FeedsBean> feeds = [];

  String lastKey = '0';
  bool isLoadComplete = false;

  LoaderState _status = LoaderState.Loading;

  @override
  void initState() {
    super.initState();

    getTopicNews(widget.id, RefreshType.DEFAULT);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: Text('${widget.title}')),
      body: LoaderContainer(
          contentView: EasyRefresh(
            footer: BallPulseFooter(),
            header: MaterialHeader(),
            onLoad: isLoadComplete
                ? null
                : () async => getTopicNews(widget.id, RefreshType.LOAD_MORE),
            onRefresh: () async => getTopicNews(widget.id, RefreshType.REFRESH),
            child: ListView.separated(
                itemBuilder: (_, index) {
                  return ItemFeedTypeZero(
                      feedsBean: feeds[index],
                      tag: 'labs-${feeds[index]?.post?.id}',
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
                      });
                },
                separatorBuilder: (_, index) => Gaps.vGap5,
                itemCount: feeds.length),
          ),
          loaderState: _status),
    );
  }

  void getTopicNews(int id, RefreshType type) async {
    if (type == RefreshType.REFRESH || RefreshType.DEFAULT == type) {
      feeds.clear();
      lastKey = '0';
    }
    responseBean = await ApiService.getQDailyTopicNews(id, lastKey);

    if (null != responseBean) {
      feeds.addAll(responseBean.feeds);
      _status = LoaderState.Succeed;
      this.lastKey = responseBean?.lastKey;
      isLoadComplete = !responseBean.hasMore;
    } else {
      _status = LoaderState.Failed;
    }

    setState(() {});
  }
}
