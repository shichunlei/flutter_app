import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/page_index.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../index.dart';
import '../ui/bottom_appbar.dart';

/// 42%
class LabRatioPage extends StatefulWidget {
  final String tag;
  final PostBean post;

  LabRatioPage({Key key, @required this.tag, this.post}) : super(key: key);

  @override
  createState() => _LabRatioPageState();
}

class _LabRatioPageState extends State<LabRatioPage>
    with TickerProviderStateMixin {
  ResponseBean data;
  List<Question> questions = [];

  // 42% 第一个问题
  Question genderQuestion;

  // 42% 区间问题
  Question slideQuestion;

  LoaderState _status = LoaderState.Loading;

  int currentPaper = 0;

  int currentPage = 1;

  @override
  void initState() {
    super.initState();

    getRatioData(widget.post?.id);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          body: LoaderContainer(
            contentView: SingleChildScrollView(
              child: Column(children: <Widget>[
                LabInfoHeaderView(tag: widget.tag, post: widget.post),
                Gaps.vGap8,
                IndexedStack(index: currentPaper, children: <Widget>[
                  LabRadioFirstView(
                    genderQuestion: genderQuestion,
                    slideQuestion: slideQuestion,
                    callBack: (bool, choice, slider) {
                      if (bool) setState(() => currentPaper = 1);
                    },
                  ),
                  LabRatioPageView(
                      questions: questions,
                      callBack: (int value) =>
                          setState(() => currentPage = value))
                ])
              ]),
            ),
            loaderState: _status,
          ),
          bottomNavigationBar: BottomAppbar(actions: <Widget>[
            IconButton(
                icon: Badge(
                    shape: BadgeShape.circle,
                    badgeContent: Text('${widget.post.commentCount}',
                        style: TextStyle(color: Colors.white, fontSize: 10)),
                    child: Icon(Feather.message_square)),
                onPressed: () => pushNewPage(
                    context,
                    CommentPage(
                        id: widget.post?.id,
                        dataType: '${widget.post.dataType}',
                        commentCount: widget.post.commentCount))),
            IconButton(icon: Icon(Feather.share), onPressed: () {})
          ]),
        ),
        onWillPop: _onBackPressed);
  }

  void getRatioData(int id) async {
    data = await ApiService.getQDailyTots(id);

    if (data != null) {
      genderQuestion = data.genderQuestion;
      slideQuestion = data.slideQuestion;
      _status = LoaderState.Succeed;

      questions = data.questions;
    } else {
      _status = LoaderState.Failed;
    }

    setState(() {});
  }

  Future<bool> _onBackPressed() async {
    if (currentPaper == 1 && currentPage < questions.length) {
      showDiffDialog(
        context,
        title: Text('提示'),
        content: Text('您还没有回答完问题，确定要退出？'),
        contentPadding: EdgeInsets.all(20),
        titlePadding: EdgeInsets.only(top: 20, left: 20),
        pressed: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
      );
      return false;
    } else {
      return true;
    }
  }
}
