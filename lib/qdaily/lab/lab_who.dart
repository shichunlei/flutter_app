import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../page_index.dart';
import '../index.dart';

/// 你谁啊
class LabWhoPage extends StatefulWidget {
  final String tag;
  final PostBean post;

  LabWhoPage({Key key, @required this.tag, @required this.post})
      : super(key: key);

  @override
  createState() => _LabWhoPageState();
}

class _LabWhoPageState extends State<LabWhoPage>
    with SingleTickerProviderStateMixin {
  ResponseBean data;
  PostBean post;
  List<Question> questions = [];

  int currentPage = 0;

  PageController _controller;

  LoaderState _status = LoaderState.Loading;

  @override
  void initState() {
    super.initState();

    _controller = PageController(initialPage: currentPage);

    getWhoData(widget.post.id);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: LoaderContainer(
        onReload: () => getWhoData(widget.post.id),
        contentView: Column(children: <Widget>[
          ChoiceNoView(
            index: currentPage + 1,
            total: questions.length,
          ),
          Expanded(
              child: PageView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _controller,
                  itemBuilder: (_, index) => LabWhoItemView(
                        question: questions[index],
                        index: index,
                        callBack: (bool, _index) {
                          if (bool) {
                            print('===============$_index');
                            if (_index + 1 < questions.length) {
                              _controller.animateToPage(_index + 1,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.decelerate);
                            } else {
                              Toast.show(context, '最后一个问题了');
                            }
                          }
                        },
                      ),
                  itemCount: questions.length,
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

  void getWhoData(int id) async {
    data = await ApiService.getQDailyWho(id);

    if (data != null) {
      questions = data.questions;
      _status = LoaderState.Succeed;
    } else {
      _status = LoaderState.Failed;
    }
    setState(() {});
  }
}
