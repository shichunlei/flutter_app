import 'package:flutter/material.dart';
import 'package:flutter_app/bean/sars_cov.dart';

import '../../page_index.dart';
import 'title_container.dart';

class ProtectView extends StatefulWidget {
  ProtectView({Key key}) : super(key: key);

  @override
  createState() => _ProtectViewState();
}

class _ProtectViewState extends State<ProtectView> {
  int _currentPage = 0;

  var data;

  @override
  void initState() {
    super.initState();

    data = fetchData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(children: <Widget>[
        TitleContainer(title: "预防手册"),
        buildIndicator(),
        FutureBuilder<PreventManualBase>(
            future: data,
            builder: (BuildContext context,
                AsyncSnapshot<PreventManualBase> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.data != null) {
                List<PreventManual> result1 = snapshot.data?.result1;
                List<PreventManual> result2 = snapshot.data?.result2;

                return IndexedStack(children: <Widget>[
                  Container(
                      height: 204,
                      child: ListView.separated(
                          itemBuilder: (_, index) {
                            return Material(
                                color: Colors.white,
                                child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        height: 40,
                                        child: Row(children: <Widget>[
                                          Image.asset(
                                            'images/yiqing_yidian_one.png',
                                            width: 18,
                                            height: 18,
                                          ),
                                          Gaps.hGap5,
                                          Expanded(
                                              child: Text(
                                                  '${result1[index].title}',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis))
                                        ]))));
                          },
                          itemCount: result1.length,
                          shrinkWrap: true,
                          primary: false,
                          padding: EdgeInsets.zero,
                          separatorBuilder: (BuildContext context, int index) =>
                              Gaps.vGap(1))),
                  Container(
                      height: 204,
                      child: ListView.separated(
                          itemBuilder: (_, index) {
                            return Material(
                                color: Colors.white,
                                child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        height: 40,
                                        child: Row(children: <Widget>[
                                          Image.asset(
                                              'images/yiqing_yidian_two.png',
                                              width: 18,
                                              height: 18),
                                          Gaps.hGap5,
                                          Expanded(
                                              child: Text(
                                                  '${result2[index].title}',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis))
                                        ]))));
                          },
                          itemCount: result2.length,
                          shrinkWrap: true,
                          primary: false,
                          padding: EdgeInsets.zero,
                          separatorBuilder: (BuildContext context, int index) =>
                              Gaps.vGap(1)))
                ], index: _currentPage);
              } else {
                return Container(height: 204);
              }
            }),
        Container(
            padding: EdgeInsets.all(10),
            child: Text('新冠肺炎预防须知',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
            alignment: Alignment.center),
        Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            width: double.infinity,
            child: Column(children: [
              Row(children: <Widget>[
                Icon(Icons.info, color: Color(0xFF035CF8)),
                Gaps.hGap5,
                Text('个人清洁')
              ]),
              Gaps.vGap5,
              buildRow('经常保持双手清洁，尤其在触摸口、鼻或眼之前。'),
              buildRow('经常用洗手液和清水清洗双手，搓手最少20秒，并用纸巾擦干。'),
              buildRow('打喷嚏或咳嗽时应用纸巾掩盖口鼻，把用过的纸巾弃置于有盖垃圾箱内，然后彻底清洁双手。'),
              Gaps.vGap5,
              Row(children: <Widget>[
                Icon(Icons.add_circle, color: Color(0xFFE93F3D)),
                Gaps.hGap5,
                Text('尽量避免')
              ]),
              Gaps.vGap5,
              buildRow('减少前往人流密集的场所。如不可避免，应戴上外科口罩。'),
              buildRow('避免到访医院。如有必要到访医院，应佩戴外科口罩及时刻注重个人和手部卫生。'),
              buildRow('避免接触动物（包括野味）、禽鸟或其粪便；避免到海鲜、活禽市场或农场。'),
              buildRow('切勿进食野味及切勿光顾有提供野味的餐馆。'),
              buildRow("注意食物安全和卫生，避免进食或饮用生或未熟透的动物产品，包括奶类、蛋类和肉类。"),
              Gaps.vGap5,
              Row(children: <Widget>[
                Icon(Icons.do_not_disturb_on, color: Color(0xFF60BD6D)),
                Gaps.hGap5,
                Text('尽快就诊')
              ]),
              Gaps.vGap5,
              buildRow("如有身体不适，特别是有发烧或咳嗽，应戴上外科口罩并尽快就诊。")
            ]),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey[300]))
      ]),
    );
  }

  Widget buildIndicator() {
    return Container(
        height: 48.0,
        margin: const EdgeInsets.only(top: 10.0, left: 15, right: 15),
        padding: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
            color: Color(0xFFF3F6F8), borderRadius: BorderRadius.circular(5)),
        child: Row(children: <Widget>[
          Expanded(
              child: Button(
                  onPressed: () {
                    setState(() {
                      _currentPage = 0;
                    });
                  },
                  child: Text('预防指南', style: TextStyle(fontSize: 18)),
                  buttonShape: ButtonShape.Fillet,
                  borderRadius: 5.0,
                  textColor:
                      _currentPage == 0 ? Colors.black : Color(0Xff808080),
                  height: 40.0,
                  color:
                      _currentPage == 0 ? Colors.white : Colors.transparent)),
          Gaps.hGap5,
          Expanded(
              child: Button(
                  onPressed: () {
                    setState(() {
                      _currentPage = 1;
                    });
                  },
                  child: Text('检查诊断', style: TextStyle(fontSize: 18)),
                  buttonShape: ButtonShape.Fillet,
                  borderRadius: 5.0,
                  height: 40.0,
                  textColor:
                      _currentPage == 1 ? Colors.black : Color(0Xff808080),
                  color: _currentPage == 1 ? Colors.white : Colors.transparent))
        ]));
  }

  Widget buildRow(String text) {
    return Row(children: <Widget>[
      Gaps.hGap6,
      Image.asset('images/point.png', width: 10, height: 10),
      Gaps.hGap5,
      Expanded(child: Text(text, style: TextStyle(fontSize: 13)))
    ]);
  }

  Future<PreventManualBase> fetchData() async {
    PreventManualBase base = await ApiService.getSARSCovPreventManualData();

    return base;
  }
}
