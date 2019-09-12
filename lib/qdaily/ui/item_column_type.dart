import 'package:flutter/material.dart';
import 'package:flutter_app/service/api_service.dart';

import '../../page_index.dart';
import '../index.dart';

class ItemColumnTypeView extends StatefulWidget {
  final int id;
  final String icon;
  final String imageLarge;
  final String title;
  final int showType;

  ItemColumnTypeView(
      {Key key,
      @required this.id,
      this.icon,
      this.imageLarge,
      this.title,
      @required this.showType})
      : super(key: key);

  @override
  createState() => _ItemColumnTypeViewState();
}

class _ItemColumnTypeViewState extends State<ItemColumnTypeView> {
  final ScrollController _scrollController = new ScrollController();

  ResponseBean responseBean;

  List<FeedsBean> feeds = [];
  bool isLoadComplete = false;
  String lastKey = '0';

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      /// 判断当前滑动位置是不是到达最后，触发加载更多回调
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        getColumnItems(widget.id);
      }
    });

    getColumnItems(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 305,
      child: Column(children: <Widget>[
        ItemTopView(icon: widget.icon, title: widget.title, onPressed: () {}),
        Flexible(
            child: ListView.separated(
                controller: _scrollController,
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => widget.showType == 1
                    ? ItemFeedTypeTwo(
                        feedsBean: feeds[index],
                        onTap: () => pushNewPage(
                            context, ArticleDetail(id: feeds[index]?.post?.id)),
                        width: Utils.width * 2 / 3)
                    : ItemFeedTypeBook(
                        feed: feeds[index],
                        onTap: () => pushNewPage(context,
                            BookDetailPage(id: feeds[index]?.post?.id)),
                        width: (Utils.width - 15) / 2),
                separatorBuilder: (context, index) =>
                    Container(width: 5, color: Colors.grey[200]),
                itemCount: feeds.length))
      ]),
    );
  }

  void getColumnItems(int id) async {
    ResponseBean responseBean =
        await ApiService.getQdailyColumnIndex(id, lastKey);

    if (responseBean == null) {
      // 请求失败
      debugPrint('网络请求失败');
    } else {
      this.lastKey = responseBean.lastKey;
      feeds.addAll(responseBean.feeds);
      isLoadComplete = !responseBean.hasMore;

      debugPrint(
          'ItemColumnTypeOne===========${this.lastKey}=============$isLoadComplete');
      setState(() {});
    }
  }
}
