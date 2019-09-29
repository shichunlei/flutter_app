import 'package:badges/badges.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../comment.dart';
import '../index.dart';

/// 投票
class LabVotePage extends StatefulWidget {
  final PostBean post;
  final String tag;
  final bool isNew;

  LabVotePage({Key key, @required this.tag, this.isNew = false, this.post})
      : super(key: key);

  @override
  createState() => _LabVotePageState();
}

class _LabVotePageState extends State<LabVotePage> {
  ResponseBean responseBean;
  List<Option> options = [];
  Question question;

  LoaderState _status = LoaderState.Loading;

  List<bool> choices = [];

  bool isClick = false;

  @override
  void initState() {
    super.initState();

    getData(widget.post?.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LoaderContainer(
        onReload: () => getData(widget.post?.id),
        contentView: Column(children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(top: 0),
              children: <Widget>[
                LabInfoHeaderView(post: widget.post, tag: widget.tag),
                Container(height: 10, color: Colors.grey[100]),
                ListView.separated(
                    padding: EdgeInsets.only(
                        top: 10, left: 10, right: 10, bottom: 20),
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => ItemOptionCheckbox(
                        option: options[index],
                        isChecked: choices.elementAt(index),
                        onChecked: (value) {
                          choices
                            ..insert(index, value)
                            ..removeAt(index + 1);

                          isClick = choices.contains(true);

                          setState(() {});
                        }),
                    itemCount: options.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        Gaps.vGap5),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Button(
                      onPressed: isClick
                          ? () => pushNewPage(
                              context, LabVoteResultPage(id: widget.post.id))
                          : null,
                      text: '投票',
                      textColor: Colors.black54,
                      borderRadius: 30,
                      color: qdailyMajorColor,
                      disabledColor: qdailyMinorColor),
                ),
                Gaps.vGap20
              ],
            ),
          ),
          BottomAppbar(actions: <Widget>[
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
          ])
        ]),
        loaderState: _status,
      ),
    );
  }

  void getData(int labId) async {
    responseBean = await ApiService.getQDailyVote(labId);

    if (responseBean == null) {
      // 请求失败
      _status = LoaderState.Failed;
    } else {
      question = responseBean.question;
      options.addAll(question.options);

      options.forEach((f) => choices.add(false));

      _status = LoaderState.Succeed;
      setState(() {});
    }
  }
}
