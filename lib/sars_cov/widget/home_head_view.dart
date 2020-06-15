import 'package:flutter/material.dart';
import 'package:flutter_app/bean/sars_cov.dart';
import 'package:lpinyin/lpinyin.dart';

import '../../page_index.dart';
import '../page/area/area.dart';
import 'china_count_cardview.dart';

class HomeHeadView extends StatelessWidget {
  final SARSCov data;

  HomeHeadView({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Column(children: [
          Container(
              padding: EdgeInsets.all(10),
              child: Row(children: <Widget>[
                Row(children: <Widget>[
                  Container(
                      color: Colors.blue,
                      width: 5.0,
                      height: 30,
                      margin: EdgeInsets.only(right: 10)),
                  Text('全国新冠肺炎疫情',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold))
                ], mainAxisSize: MainAxisSize.min),
                Button(
                    width: 100.0,
                    halfRadius: true,
                    color: Color(0xFFF0F4FE),
                    height: 35.0,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.location_on,
                              size: 15, color: Color(0xFF3866FC)),
                          Text('北京',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF3866FC),
                                  fontWeight: FontWeight.bold)),
                          Icon(Icons.keyboard_arrow_right,
                              size: 15, color: Color(0xFF3866FC))
                        ],
                        mainAxisSize: MainAxisSize.min),
                    onPressed: () => pushNewPage(
                        context,
                        AreaPage(
                            province:
                                PinyinHelper.getPinyin('北京', separator: ''))))
              ], mainAxisAlignment: MainAxisAlignment.spaceBetween),
              color: Colors.white),
          Row(children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                    data == null
                        ? ""
                        : '截止${formatDateByMs(data?.modifyTime, formats: [
                            yyyy,
                            '-',
                            mm,
                            '-',
                            dd,
                            ' ',
                            HH,
                            ':',
                            nn
                          ])}全国数据统计',
                    style: TextStyle(color: Colors.grey[500], fontSize: 13))),
            GestureDetector(
                onTap: () {
                  showDiffDialog(context,
                      content: SingleChildScrollView(
                        child: Text(
                            "1. 数据来源：\n来自国家卫健委、各省市区卫健委、各省市区政府、港澳台官方渠道公开数据；\n2. 实时数据统计原则：\n a) 每日上午优先将全国数据与国家卫健委公布数据对齐（此时各省市数据尚未及时更新，会出现全国数据大于各省份合计数的情况）；\nb) 当各省公布数据总和大于国家公布数据时，则全国数据切换为各省合计数；\nc)「较昨日+」的数据使用当前国家总数减去国家卫健委公布的前一日数据，这个数值会根据实时数据发生变化；\nd) 疑似数据「较昨日+」因为会有转确诊与排除疑似两种情况，因此只采用国家每日公布的新增疑似数据，而不是两日的差异。\n3. 疫情趋势图：全国数据使用国家卫健委公布的截至前一日 24:00 数据，湖北数据使用湖北卫健委公布的截至前一日 24:00 数据，每日更新一次。\n4. 疑似数据因各省份未发布明细数据，目前仅同步全国总数，暂不呈现分省疑似病例。\n5. 治愈数据来源于各个省市区县政府官方微博和官方媒体，每日会有多次更新，更新速度快于其他数据。\n6. 页面显示的截止时间为标准北京时间，如您所在时区不是东八区，会自动转为当地时间显示。\n7. 丁香医生团队全力以赴提供权威、准确、及时的疫情数据，如有任何疑问，欢迎通过微信搜索「丁香医生 +」留言反馈。"),
                      ));
                },
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            bottomLeft: Radius.circular(15.0))),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(Icons.info_outline, size: 13),
                          Gaps.hGap5,
                          Text('数据说明',
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 12))
                        ])))
          ], mainAxisAlignment: MainAxisAlignment.spaceBetween),
          ChinaCountCardView(data: data)
        ]));
  }
}
