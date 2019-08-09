import 'package:flutter/material.dart';
import 'package:flutter_app/bean/reviews.dart';
import 'package:flutter_app/utils/toast.dart';
import 'package:flutter_app/global/config.dart';
import 'package:flutter_app/service/api_service.dart';
import 'package:flutter_app/movie/ui/item_comment.dart';
import 'package:flutter_app/utils/loading_util.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class MovieCommentPage extends StatefulWidget {
  final String id;
  final Color itemBackgroundColor;

  MovieCommentPage(
    this.id, {
    Key key,
    this.itemBackgroundColor = Colors.blueAccent,
  }) : super(key: key);

  @override
  _MovieCommentPageState createState() => _MovieCommentPageState();
}

class _MovieCommentPageState extends State<MovieCommentPage> {
  List<Reviews> comments = [];

  int page = 1;
  int pagesize = 20;

  bool isFirst = true;
  bool isLoadComplete = false;

  GlobalKey<EasyRefreshState> _easyRefreshKey = GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();

  @override
  void initState() {
    super.initState();

    getCommentsList(widget.id, page, pagesize, RefreshType.DEFAULT);
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

  void getCommentsList(movieId, int page, int pagesize, loadDataType) async {
    List<Reviews> reviews = await ApiService.getComments(movieId,
        start: (page - 1) * pagesize, count: pagesize);
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

    setState(() {});
  }

  Widget _buildBodyView() {
    if (isFirst && comments.isEmpty) {
      return getLoadingWidget();
    }
    return EasyRefresh(
      key: _easyRefreshKey,
      refreshFooter: BallPulseFooter(
        key: _footerKey,
        color: Colors.indigo,
        backgroundColor: Colors.white,
      ),
      loadMore: isLoadComplete
          ? null
          : () async {
              page++;
              getCommentsList(widget.id, page, pagesize, RefreshType.LOAD_MORE);
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
