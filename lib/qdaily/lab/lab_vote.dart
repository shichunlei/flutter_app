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

  LabVotePage({Key key, @required this.tag, this.post}) : super(key: key);

  @override
  createState() => _LabVotePageState();
}

class _LabVotePageState extends State<LabVotePage> {
  ResponseBean responseBean, baseData;
  List<Option> options = [];
  List<Option> result = [];
  Question question;

  LoaderState _status = LoaderState.Loading;

  List<bool> choices = [];

  bool isClick = false;

  bool isResult = false;

  @override
  void initState() {
    super.initState();

    getData(widget.post?.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: LoaderContainer(
        onReload: () => getData(widget.post?.id),
        contentView: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            LabInfoHeaderView(post: widget.post, tag: widget.tag),
            ListView.separated(
                padding:
                    EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 20),
                primary: false,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => isResult
                    ? ItemVoteOptions(option: result[index])
                    : ItemOptionCheckbox(
                        option: options[index],
                        isChecked: choices.elementAt(index),
                        onChecked: (value) {
                          choices
                            ..insert(index, value)
                            ..removeAt(index + 1);

                          isClick = choices.contains(true);

                          setState(() {});
                        }),
                itemCount: isResult ? result.length : options.length,
                separatorBuilder: (BuildContext context, int index) =>
                    Gaps.vGap5),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: isResult
                  ? Button(
                      onPressed: () {},
                      child: Text("要玩更多测试", style: TextStyle(fontSize: 18)),
                      textColor: Colors.black54,
                      halfRadius: true,
                      color: qdailyMajorColor,
                      disabledColor: qdailyMinorColor)
                  : Button(
                      onPressed: isClick
                          ? () {
                              setState(() {
                                _status = LoaderState.Loading;
                              });

                              getResultData(widget.post?.id);
                            }
                          : null,
                      child: Text("投票", style: TextStyle(fontSize: 18)),
                      textColor: Colors.black54,
                      halfRadius: true,
                      color: qdailyMajorColor,
                      disabledColor: qdailyMinorColor),
            ),
            Gaps.vGap20
          ],
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

      options.forEach((f) {
        f.selected = false;
        choices.add(false);
      });

      _status = LoaderState.Succeed;
      setState(() {});
    }
  }

  void getResultData(int id) async {
    baseData = await ApiService.getQDailyVoteResult(id);

    result.addAll(baseData.everyoneAttitude);
    setState(() {
      isResult = true;
      _status = LoaderState.Succeed;
    });
  }
}
