import 'package:flutter/material.dart';
import 'package:flutter_app/bean/sars_cov.dart';
import 'package:flutter_app/page_index.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';

class ItemTrajectory extends StatelessWidget {
  final Trajectory item;

  ItemTrajectory({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: <Widget>[
                  Icon(
                    Icons.location_on,
                    color: Color(0xFF4674FC),
                  ),
                  Gaps.hGap5,
                  Expanded(
                    child: RichText(
                        text: TextSpan(
                            text: '位置：',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black),
                            children: <TextSpan>[
                          TextSpan(
                            text: '${item.province}${item.city}${item.county}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ])),
                  ),
                ],
              ),
              Gaps.vGap5,
              Row(
                children: <Widget>[
                  Icon(
                    Icons.access_time,
                    color: Color(0xFF4674FC),
                  ),
                  Gaps.hGap5,
                  Expanded(
                    child: RichText(
                        text: TextSpan(
                            text: '发布时间：',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black),
                            children: <TextSpan>[
                          TextSpan(
                            text: '${formatDateByStr(item.pubTime, formats: [
                              yyyy,
                              '-',
                              mm,
                              '-',
                              dd
                            ])}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ])),
                  ),
                ],
              ),
              Gaps.vGap5,
              Row(
                children: <Widget>[
                  Icon(
                    Icons.account_circle,
                    color: Color(0xFF4674FC),
                  ),
                  Gaps.hGap5,
                  Expanded(
                    child: RichText(
                        text: TextSpan(
                            text: '病患信息：',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black),
                            children: <TextSpan>[
                          TextSpan(
                            text: '${item.userName}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ])),
                  )
                ],
              ),
              Gaps.vGap5,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.event_note,
                    color: Color(0xFF4674FC),
                  ),
                  Gaps.hGap5,
                  Expanded(
                    child: RichText(
                        text: TextSpan(
                            text: '其他信息：',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black),
                            children: <TextSpan>[
                          TextSpan(
                            text: '${item.otherInfo ?? "暂无"}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ])),
                  ),
                ],
              ),
              Line(
                margin: EdgeInsets.symmetric(vertical: 5),
                color: Colors.grey[200],
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.near_me,
                    color: Color(0xFF4674FC),
                  ),
                  Gaps.hGap5,
                  Text(
                    '行为轨迹：',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black),
                  ),
                ],
              ),
              Timeline.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                primary: false,
                itemBuilder: (BuildContext context, int index) {
                  return TimelineModel(
                      RichText(
                          text: TextSpan(
                              text: '${item.track[index].time} ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black),
                              children: <TextSpan>[
                            TextSpan(
                              text: '${item.track[index].action}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ])),
                      isFirst: index == 0,
                      isLast: index == item.track.length - 1,
                      iconBackground: Colors.blue);
                },
                itemCount: item.track.length,
                position: TimelinePosition.Left,
              ),
              Gaps.vGap5,
              Text(
                '信息来源：${item?.source}',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
