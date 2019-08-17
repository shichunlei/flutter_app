import 'package:badges/badges.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../comment.dart';
import '../index.dart';

/// 投票
class LabVotePage extends StatefulWidget {
  final int id;
  final PostBean post;
  final String tag;
  final bool isNew;

  LabVotePage(
      {Key key,
      @required this.id,
      @required this.tag,
      this.isNew = false,
      this.post})
      : super(key: key);

  @override
  createState() => _LabVotePageState();
}

class _LabVotePageState extends State<LabVotePage> {
  ResponseBean responseBean;
  List<Option> options = [];

  @override
  void initState() {
    super.initState();

    getData(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    double width = Utils.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: <Widget>[
        Expanded(
          child: ListView(padding: EdgeInsets.only(top: 0), children: <Widget>[
            Container(
              child: Column(children: <Widget>[
                Container(
                  height: width * 2 / 3,
                  child: Stack(children: <Widget>[
                    Hero(
                        tag: widget.tag,
                        child: ImageLoadView('${widget.post?.image}',
                            fit: BoxFit.cover,
                            height: width * 2 / 3,
                            width: width)),
                    Container(
                      padding: EdgeInsets.only(
                          top: 10 + Utils.topSafeHeight, right: 10),
                      alignment: Alignment.topRight,
                      child: Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            Image.asset(
                                widget.isNew
                                    ? 'images/qdaily/icon_lab_vot_new.png'
                                    : 'images/qdaily/icon_lab_vot_join.png',
                                height: 47.5,
                                width: 57),
                            widget.isNew
                                ? SizedBox()
                                : Container(
                                    child: Text(
                                      '${widget.post?.recordCount}',
                                      style: TextStyle(
                                          color: Color(0xFFFFD003),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    margin: EdgeInsets.only(top: 3))
                          ]),
                    ),
                  ]),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('${widget.post?.title}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        Text('${widget.post?.description}',
                            style: TextStyle(color: Colors.grey))
                      ]),
                )
              ]),
            ),
            Container(height: 10, color: Colors.grey[100]),
            ListView.builder(
                padding:
                    EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 20),
                primary: false,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ItemOptionCheckbox(option: options[index]);
                },
                itemCount: options.length),
            RaisedButton(
                elevation: 0.0,
                onPressed: null,
                child: Text('投票'),
                color: Color(0xFFFFD003),
                shape: StadiumBorder()),
            SizedBox(height: 30)
          ]),
        ),
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
                      id: widget.id,
                      dataType: '${widget.post.dataType}',
                      commentCount: widget.post.commentCount))),
          IconButton(icon: Icon(FeatherIcons.share), onPressed: () {})
        ])
      ]),
    );
  }

  void getData(int labId) async {
    responseBean = await ApiService.getQdailyLabsDetailData(labId);

    if (responseBean == null) {
      // 请求失败
    } else {
      options.addAll(responseBean.questions[0].options);
      setState(() {});
    }
  }
}
