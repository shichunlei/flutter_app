import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class ItemSchedule extends StatelessWidget {
  final ScheduleList item;
  final bool isTeam;

  ItemSchedule({Key key, this.item, @required this.isTeam})
      : assert(isTeam != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var leftStyle = item.leftGoal > item.rightGoal
        ? TextStyles.textBoldBlue14
        : TextStyles.textGrey14;
    var rightStyle = item.leftGoal > item.rightGoal
        ? TextStyles.textGrey14
        : TextStyles.textBoldBlue14;

    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: item.matchPeriod == "0"
            ? null
            : () => pushNewPage(context, MatchPage(mid: item.mid)),
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    '${formatDateByStr(item.startTime, formats: isTeam ? [
                        mm,
                        '-',
                        dd
                      ] : [HH, ':', nn])}',
                    style: TextStyles.textDark16,
                  ),
                  Text('${item.matchDesc.replaceAll("NBA", "")}',
                      style: TextStyles.textGrey14),
                ],
              ),
              Gaps.hGap8,
              Expanded(
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage('${item.leftBadge}'),
                      radius: 15,
                    ),
                    Gaps.hGap8,
                    Text('${item.leftName}',
                        style: item.matchPeriod == "0"
                            ? TextStyles.textGreyC14
                            : item.matchPeriod == "1"
                                ? TextStyles.textBlue14
                                : leftStyle),
                    Expanded(
                      child: item.matchPeriod == "0"
                          ? Text(
                              '未开始',
                              textAlign: TextAlign.center,
                              style: TextStyles.textGreyC14,
                            )
                          : item.matchPeriod == "1"
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text('${item.leftGoal} - ${item.rightGoal}',
                                        textAlign: TextAlign.center,
                                        style: TextStyles.textBlue14),
                                    Gaps.vGap8,
                                    Text('${item.quarterDesc}',
                                        textAlign: TextAlign.center,
                                        style: TextStyles.textBlue14)
                                  ],
                                )
                              : RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: '${item.leftGoal}',
                                        style: leftStyle),
                                    TextSpan(
                                        text: ' - ',
                                        style: TextStyles.textDark14),
                                    TextSpan(
                                        text: '${item.rightGoal}',
                                        style: rightStyle)
                                  ]),
                                ),
                    ),
                    Text('${item.rightName}',
                        style: item.matchPeriod == "0"
                            ? TextStyles.textGreyC14
                            : item.matchPeriod == "1"
                                ? TextStyles.textBlue14
                                : rightStyle),
                    Gaps.hGap8,
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage('${item.rightBadge}'),
                      radius: 15,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
