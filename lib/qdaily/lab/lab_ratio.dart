import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/generated/i18n.dart';
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

  String choice = "";
  double sliderValue = 0.0;

  int currentPaper = 0;

  int currentPage = 1;

  @override
  void initState() {
    super.initState();

    getRatioData(widget.post?.id);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          body: Column(
            children: <Widget>[
              Expanded(
                child: LoaderContainer(
                  contentView: SingleChildScrollView(
                    child: Column(children: <Widget>[
                      LabInfoHeaderView(tag: widget.tag, post: widget.post),
                      Gaps.vGap8,
                      IndexedStack(index: currentPaper, children: <Widget>[
                        buildGenderSliderView(),
                        Column(
                          children: <Widget>[
                            ChoiceNoView(
                              index: currentPage,
                              total: questions.length,
                            ),
                            LabRatioPageView(
                              questions: questions,
                              callBack: (int value) {
                                setState(() {
                                  currentPage = value;
                                });
                              },
                            ),
                          ],
                        )
                      ])
                    ]),
                  ),
                  loaderState: _status,
                ),
              ),
              BottomAppbar(actions: <Widget>[
                IconButton(
                    icon: Badge(
                        shape: BadgeShape.circle,
                        badgeContent: Text('${widget.post.commentCount}',
                            style:
                                TextStyle(color: Colors.white, fontSize: 10)),
                        child: Icon(Feather.message_square)),
                    onPressed: () => pushNewPage(
                        context,
                        CommentPage(
                            id: widget.post?.id,
                            dataType: '${widget.post.dataType}',
                            commentCount: widget.post.commentCount))),
                IconButton(icon: Icon(Feather.share), onPressed: () {})
              ]),
            ],
          ),
        ),
        onWillPop: _onBackPressed);
  }

  Widget buildGenderSliderView() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 8, bottom: 15),
            child: Text(
              '${genderQuestion?.content}',
              style: TextStyles.textDark16,
            ),
          ),
          Container(
            color: Colors.grey[400],
            padding: EdgeInsets.all(15),
            child: Row(
              children: <Widget>[
                ChoiceChip(
                  label: Text(
                    '${genderQuestion != null ? genderQuestion?.options[0]?.title : ""}',
                    style: TextStyles.textDark16,
                  ),
                  selected: choice == "0",
                  backgroundColor: qdailyMinorColor,
                  selectedColor: qdailyMajorColor,
                  onSelected: (value) {
                    setState(() {
                      choice = value ? "0" : "";
                    });
                  },
                ),
                ChoiceChip(
                  label: Text(
                    '${genderQuestion != null ? genderQuestion?.options[1]?.title : ""}',
                    style: TextStyles.textDark16,
                  ),
                  selected: choice == "1",
                  backgroundColor: qdailyMinorColor,
                  selectedColor: qdailyMajorColor,
                  onSelected: (value) {
                    setState(() {
                      choice = value ? "1" : "";
                    });
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15, bottom: 15),
            child: Text(
              '${slideQuestion?.content}',
              style: TextStyles.textDark16,
            ),
          ),
          Slider(
            value: sliderValue,
            onChanged: (double value) {
              setState(() {
                sliderValue = value;
              });
            },
            max: slideQuestion?.maxScore ?? 10,
            min: 0,
            divisions: 100,
          ),
          Row(
            children: <Widget>[
              Text(
                '${slideQuestion != null ? slideQuestion?.options[0]?.title : ""}',
                style: TextStyles.textBoldDark16,
              ),
              Text(
                '${slideQuestion != null ? slideQuestion?.options[1]?.title : ""}',
                style: TextStyles.textBoldDark16,
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          Gaps.vGap5,
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  '${slideQuestion != null ? slideQuestion?.options[0]?.content : ""}',
                  style: TextStyles.textGrey14,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  '${slideQuestion != null ? slideQuestion?.options[1]?.content : ""}',
                  style: TextStyles.textGrey14,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          Gaps.vGap20,
          Button(
            onPressed: choice != "" && choice.length > 0 && sliderValue > 0
                ? () {
                    setState(() {
                      currentPaper = 1;
                    });
                  }
                : null,
            text: '下一步',
            textColor: Colors.black54,
            borderRadius: 30,
            color: qdailyMajorColor,
            disabledColor: qdailyMinorColor,
          ),
          Gaps.vGap40
        ],
      ),
    );
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
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('提示'),
              content: Text('您还没有回答完问题，确定要退出？'),
              contentPadding: EdgeInsets.all(20),
              titlePadding: EdgeInsets.only(top: 20, left: 20),
              actions: <Widget>[
                FlatButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(S.of(context).cancel)),
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text(S.of(context).sure)),
              ],
            );
          });
      return false;
    } else {
      return true;
    }
  }
}
