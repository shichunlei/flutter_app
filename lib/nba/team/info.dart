import 'package:flutter/material.dart';

import '../../page_index.dart';
import '../index.dart';

class TeamInfoPage extends StatelessWidget {
  final Team team;

  TeamInfoPage({Key key, @required this.team}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                    child: Text(
                      '城市',
                      style: TextStyles.textGrey16,
                    ),
                    height: 30.0,
                    alignment: Alignment.centerLeft,
                  ),
                  flex: 1),
              Expanded(
                  child: Container(
                    child: Text(
                      '${team?.city}',
                      style: TextStyles.textDark16,
                    ),
                    height: 30.0,
                    alignment: Alignment.centerLeft,
                  ),
                  flex: 2)
            ],
          ),
          Divider(),
          Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                    child: Text(
                      '球馆',
                      style: TextStyles.textGrey16,
                    ),
                    height: 30.0,
                    alignment: Alignment.centerLeft,
                  ),
                  flex: 1),
              Expanded(
                  child: Container(
                    child: Text(
                      '${team?.venue}',
                      style: TextStyles.textDark16,
                    ),
                    height: 30.0,
                    alignment: Alignment.centerLeft,
                  ),
                  flex: 2)
            ],
          ),
          Divider(),
          Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                    child: Text(
                      '教练',
                      style: TextStyles.textGrey16,
                    ),
                    height: 30.0,
                    alignment: Alignment.centerLeft,
                  ),
                  flex: 1),
              Expanded(
                  child: Container(
                    child: Text(
                      '${team?.coach}',
                      style: TextStyles.textDark16,
                    ),
                    height: 30.0,
                    alignment: Alignment.centerLeft,
                  ),
                  flex: 2)
            ],
          ),
          Divider(),
          Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                    child: Text(
                      '加入NBA年份',
                      style: TextStyles.textGrey16,
                    ),
                    height: 30.0,
                    alignment: Alignment.centerLeft,
                  ),
                  flex: 1),
              Expanded(
                  child: Container(
                    child: Text(
                      '${team?.joinNBADate}年',
                      style: TextStyles.textDark16,
                    ),
                    height: 30.0,
                    alignment: Alignment.centerLeft,
                  ),
                  flex: 2)
            ],
          ),
          Divider(),
          Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                    child: Text(
                      '分区',
                      style: TextStyles.textGrey16,
                    ),
                    height: 30.0,
                    alignment: Alignment.centerLeft,
                  ),
                  flex: 1),
              Expanded(
                  child: Container(
                    child: Text(
                      '${team?.area}',
                      style: TextStyles.textDark16,
                    ),
                    height: 30.0,
                    alignment: Alignment.centerLeft,
                  ),
                  flex: 2)
            ],
          ),
          Divider(),
          Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                    child: Text(
                      '分区排名',
                      style: TextStyles.textGrey16,
                    ),
                    height: 30.0,
                    alignment: Alignment.centerLeft,
                  ),
                  flex: 1),
              Expanded(
                  child: Container(
                    child: Text(
                      'NO.${team?.serial}',
                      style: TextStyles.textDark16,
                    ),
                    height: 30.0,
                    alignment: Alignment.centerLeft,
                  ),
                  flex: 2)
            ],
          ),
          Divider(),
          Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                    child: Text(
                      '简介',
                      style: TextStyles.textGrey16,
                    ),
                    height: 30.0,
                    alignment: Alignment.centerLeft,
                  ),
                  flex: 1),
              Expanded(
                  child: Container(
                    child: Text(
                      '${team?.brief}',
                      style: TextStyles.textDark16,
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  flex: 2)
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          Divider(),
        ],
      ),
    );
  }
}
