import 'dart:convert';

import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:badges/badges.dart';

import '../../page_index.dart';
import '../index.dart';

/// 你猜/你谁啊/
class LabYouGuessPage extends StatefulWidget {
  final PostBean post;

  LabYouGuessPage({Key key, @required this.post}) : super(key: key);

  @override
  createState() => _LabYouGuessPageState();
}

class _LabYouGuessPageState extends State<LabYouGuessPage>
    with SingleTickerProviderStateMixin {
  List<Question> list = [];

  int currentPage = 0;

  PageController _controller;

  @override
  void initState() {
    super.initState();
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
      body: Column(children: <Widget>[
        Container(
            padding: EdgeInsets.only(top: Utils.topSafeHeight + 10, bottom: 20),
            child: LineViewLine(
                horizontalPadding: 30,
                child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.yellow,
                    child: Text('${currentPage + 1} / ${list.length}')))),
        Expanded(
            child: PageView(
                controller: _controller,
                children: list
                    .map((question) => ItemLabPageView(
                        question: question,
                        onTap: () {
                          if (currentPage == list.length - 1) {
                            Navigator.pop(context);
                          } else {
                            _controller.animateToPage(currentPage + 1,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.decelerate);
                          }
                        }))
                    .toList(),
                onPageChanged: (index) => setState(() => currentPage = index))),
        BottomAppbar(actions: <Widget>[
          IconButton(
              icon: Badge(
                  shape: BadgeShape.circle,
                  badgeContent: Text('${widget.post.commentCount}',
                      style: TextStyle(color: Colors.white, fontSize: 10)),
                  child: Icon(FeatherIcons.messageSquare)),
              onPressed: () => pushNewPage(
                  context,
                  CommentPage(
                      id: widget.post.id,
                      dataType: '${widget.post.dataType}',
                      commentCount: widget.post.commentCount))),
          IconButton(icon: Icon(FeatherIcons.share), onPressed: () {})
        ]),
      ]),
    );
  }

  void loadQuestions() async {
    rootBundle.loadString('assets/data/whos.json').then((value) {
      List _list = json.decode(value);

      _list.forEach((item) {
        List<Option> _options = [];
        item['options'].forEach((option) {
          _options..add(Option(id: option['id'], content: option['content']));
        });
        list
          ..add(Question(
              options: _options,
              id: item['id'],
              image: item['image'],
              title: item['title']));
      });

      setState(() {});
    });

    _controller = PageController(initialPage: currentPage);

    setState(() {});
  }
}
