import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import '../page_index.dart';
import 'index.dart';

class CommentPage extends StatefulWidget {
  final int id;
  final String dataType;
  final int commentCount;

  CommentPage(
      {Key key, @required this.id, this.dataType, this.commentCount = 0})
      : super(key: key);

  @override
  createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  String lastKey = '0';

  ResponseBean response;

  List<CommentBean> comments = [];

  bool isLoadComplete = false;

  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();

  @override
  void initState() {
    super.initState();

    print('${widget.commentCount}===============');

    if (widget.commentCount > 0) getCommentData(widget.id, lastKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar:
          AppBar(title: Text('${widget.commentCount}条评论'), centerTitle: true),
      body: widget.commentCount == 0
          ? EmptyPage(text: '暂无评论', imageAsset: 'images/empty.jpeg')
          : comments.isEmpty ? getLoadingWidget() : _buildBodyView(),
    );
  }

  void getCommentData(int id, String lastKey) async {
    response = await ApiService.getQdailyCommentData(id,
        lastKey: lastKey, dataType: widget.dataType);
    if (response == null) {
      // 请求失败
    } else {
      this.lastKey = response?.lastKey;
      comments.addAll(response.comments);
      isLoadComplete = !response.hasMore;

      print('${this.lastKey}=============$isLoadComplete');
      setState(() {});
    }
  }

  Widget _buildBodyView() {
    return EasyRefresh(
        refreshFooter: BallPulseFooter(
            key: _footerKey, color: Colors.red, backgroundColor: Colors.white),
        loadMore: isLoadComplete
            ? null
            : () async => getCommentData(widget.id, lastKey),
        child: ListView.builder(
            itemBuilder: (context, index) =>
                ItemComment(comment: comments[index]),
            itemCount: comments.length));
  }
}
