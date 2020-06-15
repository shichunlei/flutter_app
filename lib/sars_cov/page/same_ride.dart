import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/bean/sars_cov.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import '../../page_index.dart';

class SameRidePage extends StatefulWidget {
  SameRidePage({Key key}) : super(key: key);

  @override
  createState() => _SameRidePageState();
}

class _SameRidePageState extends State<SameRidePage> {
  ScrollController controller;

  double expandedHeight;

  double opacity = 0.0;

  final Color primary = Color(0xff291747);
  final Color active = Color(0xff6C48AB);

  var _noController = TextEditingController();
  var _arriveController = TextEditingController();

  final _nodeNo = FocusNode();
  final _nodeArrive = FocusNode();

  String datetime = '';
  String type = '1';

  List<SameRide> list = [];

  bool showLoading = false;

  @override
  void initState() {
    super.initState();

    expandedHeight = Utils.width * 171 / 400 - Utils.topSafeHeight;

    controller = ScrollController()
      ..addListener(() {
        var offset = controller.offset;
        if (offset < 0) {
          if (opacity != 0) setState(() => opacity = 0);
        } else if (offset < expandedHeight && offset >= 0) {
          setState(
              () => opacity = 1 - (expandedHeight - offset) / expandedHeight);
        } else {
          if (opacity != 1) setState(() => opacity = 1);
        }
      });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EasyRefresh.custom(scrollController: controller, slivers: [
        SliverAppBar(
          pinned: true,
          automaticallyImplyLeading: false,
          backgroundColor: primary,
          title: Text(
            "同乘查询",
            style: TextStyle(color: Color.fromRGBO(255, 255, 255, opacity)),
          ),
          expandedHeight: expandedHeight,
          flexibleSpace: FlexibleSpaceBar(
            background: ImageLoadView(
                'https://mat1.gtimg.com/bbs/static/20200205-title.png'),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              SelectTextItem(
                title: '交通类型',
                content: '$type',
                margin: EdgeInsets.only(left: 16.0, right: 8),
                onTap: () {},
                textAlign: TextAlign.right,
                bgColor: Colors.transparent,
              ),
              Line(margin: EdgeInsets.zero),
              SelectTextItem(
                title: '出行时间',
                content: '$datetime',
                margin: EdgeInsets.only(left: 16.0, right: 8),
                onTap: () {
                  showDatePicker(
                          context: context,
                          firstDate: DateTime.parse("20200101"),
                          initialDate: datetime == ""
                              ? DateTime.now()
                              : DateTime.parse(datetime),
                          lastDate: DateTime.now(),
                          initialDatePickerMode: DatePickerMode.day)
                      .then((dateTime) {
                    setState(() {
                      datetime = formatDate(dateTime,
                          formats: [yyyy, '-', mm, '-', dd]);
                    });
                  });
                },
                textAlign: TextAlign.right,
                bgColor: Colors.transparent,
              ),
              Line(margin: EdgeInsets.zero),
              TextFieldItem(
                title: "车次",
                hintText: "例如：G20、Y501",
                controller: _noController,
                focusNode: _nodeNo,
                nextFocusNode: _nodeArrive,
                textAlign: TextAlign.end,
              ),
              Line(margin: EdgeInsets.zero),
              TextFieldItem(
                title: "到达地点",
                hintText: "例如：北京、杭州",
                controller: _arriveController,
                focusNode: _nodeArrive,
                textAlign: TextAlign.end,
              ),
              Line(margin: EdgeInsets.only(bottom: 10)),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Button(
                        onPressed: () {
                          showLoading = true;
                          showLoadingDialog(context, '加载中...');

                          getSameRideData(datetime, type);
                        },
                        child: Text('查询', style: TextStyle(fontSize: 18)),
                        halfRadius: true,
                        color: Colors.pink,
                      ),
                    ),
                    Gaps.hGap24,
                    Expanded(
                      child: Button(
                        onPressed: () {
                          list.clear();
                          _arriveController.text = '';
                          _noController.text = '';
                          datetime = '';
                          type = '';
                          setState(() {});
                        },
                        child: Text('重置', style: TextStyle(fontSize: 18)),
                        halfRadius: true,
                        buttonShape: ButtonShape.OUTLINE,
                        textColor: Colors.pink,
                        borderColor: Colors.pink,
                      ),
                    ),
                  ],
                ),
              ),
              Line(),
            ],
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
          (_, index) {
            return Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14.0))),
              elevation: 10.0,
              color: list[index]?.bgColor,
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            '${list[index]?.posStart}',
                            textAlign: TextAlign.start,
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 100.0,
                            child: Column(
                              children: [
                                Text(
                                  '${list[index]?.type}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Image.asset(
                                  'images/right.png',
                                  fit: BoxFit.fitWidth,
                                ),
                                Text(
                                  '${list[index]?.no}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${list[index]?.posEnd}',
                            textAlign: TextAlign.end,
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    ),
                    Line(
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(vertical: 8),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          '${list[index]?.date}',
                          style: TextStyle(color: Colors.white54, fontSize: 15),
                        ),
                        Gaps.hGap40,
                        Expanded(
                          child: Text(
                            '${list[index]?.who}',
                            style:
                                TextStyle(color: Colors.white54, fontSize: 15),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    )
                  ],
                ),
              ),
            );
          },
          childCount: list.length,
        )),
      ]),
    );
  }

  void getSameRideData(String date, String type) async {
    list = await ApiService.getSameRideData(
        date: date,
        type: type,
        arrive: _arriveController.text,
        no: _noController.text);

    if (showLoading) {
      Navigator.pop(context);
      showLoading = false;
    }

    if (mounted) setState(() {});
  }
}
