import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import '../../page_index.dart';
import '../index.dart';

class MovieCommentPage extends StatefulWidget {
  final String id;
  final Color itemBackgroundColor;

  MovieCommentPage(
    this.id, {
    Key key,
    this.itemBackgroundColor = Colors.blueAccent,
  }) : super(key: key);

  @override
  createState() => _MovieCommentPageState();
}

class _MovieCommentPageState extends State<MovieCommentPage> {
  List<Reviews> comments = [];

  int page = 1;
  int pageSize = 20;

  bool isFirst = true;
  bool isLoadComplete = false;

  @override
  void initState() {
    super.initState();

    getCommentsList(widget.id, page, RefreshType.DEFAULT);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('短评'),
      ),
      body: _buildBodyView(),
    );
  }

  void getCommentsList(movieId, int page, loadDataType) async {
    List<Reviews> reviews =
        await ApiService.getComments(movieId, page: page, limit: pageSize);
    if (isFirst) {
      isFirst = false;
      if (reviews.isEmpty) {
        Toast.show(context, '暂无评论');
        isLoadComplete = true;
      }
    } else {
      if (reviews.isEmpty) {
        Toast.show(context, '数据加载完成...');
        isLoadComplete = true;
      }
    }

    comments.addAll(reviews);

    if (mounted) setState(() {});
  }

  Widget _buildBodyView() {
    if (isFirst && comments.isEmpty) {
      return LoadingWidget();
    }
    return EasyRefresh(
      footer: BallPulseFooter(),
      onLoad: isLoadComplete
          ? null
          : () async {
              page++;
              getCommentsList(widget.id, page, RefreshType.LOAD_MORE);
            },
      child: ListView.builder(
        itemBuilder: (context, index) {
          return ItemComment(
              comment: comments[index], background: widget.itemBackgroundColor);
        },
        itemCount: comments.length,
        physics: const BouncingScrollPhysics(),
      ),
    );
  }
}
