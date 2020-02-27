import 'dart:async';

import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

import '../../page_index.dart';
import '../index.dart';

/// 你猜
class LabYouGuessPage extends StatefulWidget {
  final String tag;
  final PostBean post;

  LabYouGuessPage({Key key, @required this.post, this.tag}) : super(key: key);

  @override
  createState() => _LabYouGuessPageState();
}

class _LabYouGuessPageState extends State<LabYouGuessPage>
    with SingleTickerProviderStateMixin {
  List<Question> list = [];
  ResponseBean data;

  int currentPage = 0;

  PageController _controller;

  LoaderState _status = LoaderState.Loading;

  @override
  void initState() {
    super.initState();

    _controller = PageController(initialPage: currentPage);

    loadQuestions();
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: LoaderContainer(
        onReload: () => loadQuestions(),
        contentView: Column(children: <Widget>[
          ChoiceNoView(
            index: currentPage + 1,
            total: list.length,
          ),
          Expanded(
              child: PageView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _controller,
                  itemBuilder: (_, index) => LabChoiceItemView(
                      question: list[index],
                      onTap: (bool value) => next(index, value)),
                  itemCount: list.length,
                  onPageChanged: (index) =>
                      setState(() => currentPage = index))),
        ]),
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
                    id: widget.post.id,
                    dataType: '${widget.post.dataType}',
                    commentCount: widget.post.commentCount))),
        IconButton(icon: Icon(Feather.share), onPressed: () {})
      ]),
    );
  }

  void loadQuestions() async {
    data = await ApiService.getQDailyChoices(widget.post.id);
    if (data == null) {
      _status = LoaderState.Failed;
    } else {
      list = data.questions;
      _status = LoaderState.Succeed;
    }
    setState(() {});
  }

  void next(int index, bool value) async {
    if (value) {
      Timer(Duration(milliseconds: 1500), () {
        if (index == list.length - 1) {
          debugPrint("最后一个问题");
          Navigator.pop(context);
        } else {
          _controller.animateToPage(index + 1,
              duration: Duration(milliseconds: 500), curve: Curves.decelerate);
        }
      });
    }
  }
}
