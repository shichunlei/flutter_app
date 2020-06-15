import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/bean/sars_cov.dart';
import 'package:flutter_app/page_index.dart';

class AnalyzePage extends StatefulWidget {
  AnalyzePage({Key key}) : super(key: key);

  @override
  createState() => _AnalyzePageState();
}

class _AnalyzePageState extends State<AnalyzePage> {
  LoaderState state = LoaderState.Loading;

  ScrollController controller = ScrollController();

  double navAlpha = 0;
  double headerHeight = 150;

  List<Analyze> list = [];

  int curIndex = 0;

  String bigPic = '';
  String pubTime = '';

  bool isShow = false;

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      var offset = controller.offset;
      if (offset <= 0) {
        isShow = false;
        if (navAlpha != 0) setState(() => navAlpha = 0);
      } else if (offset < headerHeight && offset > 0) {
        navAlpha = 1 - (headerHeight - offset) / headerHeight;
        if (navAlpha > 0.8) {
          isShow = true;
        } else {
          isShow = false;
        }
        setState(() {});
      } else {
        isShow = true;
        setState(() => navAlpha = 1);
      }
    });

    getAnalyzeData();
  }

  @override
  void dispose() {
    super.dispose();

    controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: <Widget>[
          LoaderContainer(
            contentView: SingleChildScrollView(
              controller: controller,
              child: Stack(
                children: <Widget>[
                  Image.network(
                    '$bigPic',
                    fit: BoxFit.fitWidth,
                  ),
                  Positioned(
                    child: buildTitleView(),
                    top: 156,
                    left: 15,
                    right: 15,
                  ),
                ],
              ),
            ),
            loaderState: state,
          ),
          Opacity(
            child: Container(
              height: Utils.navigationBarHeight,
              child: AppBar(
                automaticallyImplyLeading: false,
                title: Visibility(
                  child: buildTitleView(),
                  visible: isShow,
                ),
                centerTitle: true,
                backgroundColor: Color(0xFF291747),
              ),
            ),
            opacity: navAlpha,
          ),
        ],
      ),
    );
  }

  Widget buildTitleView() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.white,
      ),
      margin: EdgeInsets.symmetric(horizontal: 3, vertical: 5),
      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 12),
      child: Row(
        children: <Widget>[
          Text(
            '$pubTime',
            style: TextStyle(color: Colors.black54, fontSize: 14),
          ),
          Button(
            height: 30.0,
            width: 100.0,
            halfRadius: true,
            textColor: Color(0xFF0257EC),
            child: Row(
              children: <Widget>[
                Text(
                  '查看往期',
                  style: TextStyle(color: Color(0xFF0257EC), fontSize: 13),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: Color(0xFF0257EC),
                  size: 14,
                ),
              ],
              mainAxisSize: MainAxisSize.min,
            ),
            onPressed: () {
              showModalBottomSheet(
                  builder: (BuildContext context) {
                    return ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                          Gaps.vGap(1),
                      itemBuilder: (BuildContext context, int index) =>
                          ListTile(
                        title: Text(
                          '${list[index]?.pubTime}',
                          style: TextStyle(
                              color: curIndex == index
                                  ? Colors.red
                                  : Colors.black54),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          if (curIndex != index) {
                            setState(() {
                              controller.jumpTo(0);
                              state = LoaderState.Loading;
                            });

                            Timer(Duration(milliseconds: 800), () {
                              bigPic = list[index]?.bigPic;
                              pubTime = list[index]?.pubTime;

                              curIndex = index;
                              setState(() {
                                state = LoaderState.Succeed;
                              });
                            });
                          }
                        },
                      ),
                      itemCount: list.length,
                    );
                  },
                  context: context);
            },
            color: Color(0xFFE3F1FE),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }

  void getAnalyzeData() async {
    List<Analyze> _list = await ApiService.getSARSCovAnalyzeData();

    list.addAll(_list);

    bigPic = list[curIndex]?.bigPic;

    pubTime = list[curIndex]?.pubTime;

    if (mounted) {
      setState(() {
        state = LoaderState.Succeed;
      });
    }
  }
}
