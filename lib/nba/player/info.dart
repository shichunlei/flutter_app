import 'package:flutter/material.dart';
import 'package:flutter_app/page_index.dart';

import '../index.dart';

class PlayerInfoPage extends StatelessWidget {
  final Player playerBaseInfo;

  PlayerInfoPage({Key key, this.playerBaseInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List honorList = [];
    if (playerBaseInfo?.honor != "")
      honorList = playerBaseInfo.honor.split(',');

    return SingleChildScrollView(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                      child: Text('球队', style: TextStyles.textGrey16),
                      height: 30.0,
                      alignment: Alignment.centerLeft),
                  flex: 1),
              Expanded(
                  child: InkWell(
                    child: Container(
                        child: Text('${playerBaseInfo?.teamName} >',
                            style: TextStyles.textDark16),
                        height: 30.0,
                        alignment: Alignment.centerLeft),
                    onTap: () => pushNewPage(
                        context,
                        TeamHomePage(
                            id: playerBaseInfo?.teamId,
                            title: playerBaseInfo?.teamName)),
                  ),
                  flex: 3)
            ],
          ),
          Divider(),
          Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                      child: Text('号码', style: TextStyles.textGrey16),
                      height: 30.0,
                      alignment: Alignment.centerLeft),
                  flex: 1),
              Expanded(
                  child: Container(
                      child: Text('${playerBaseInfo?.jerseyNum}',
                          style: TextStyles.textDark16),
                      height: 30.0,
                      alignment: Alignment.centerLeft),
                  flex: 3)
            ],
          ),
          Divider(),
          Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                      child: Text('位置', style: TextStyles.textGrey16),
                      height: 30.0,
                      alignment: Alignment.centerLeft),
                  flex: 1),
              Expanded(
                  child: Container(
                      child: Text('${playerBaseInfo?.position}',
                          style: TextStyles.textDark16),
                      height: 30.0,
                      alignment: Alignment.centerLeft),
                  flex: 3)
            ],
          ),
          Divider(),
          Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                      child: Text('选秀年', style: TextStyles.textGrey16),
                      height: 30.0,
                      alignment: Alignment.centerLeft),
                  flex: 1),
              Expanded(
                  child: Container(
                      child: Text('${playerBaseInfo?.draftYear}年',
                          style: TextStyles.textDark16),
                      height: 30.0,
                      alignment: Alignment.centerLeft),
                  flex: 3)
            ],
          ),
          Divider(),
          Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                      child: Text('生日', style: TextStyles.textGrey16),
                      height: 30.0,
                      alignment: Alignment.centerLeft),
                  flex: 1),
              Expanded(
                  child: Container(
                      child: Text('${playerBaseInfo?.birthDate}',
                          style: TextStyles.textDark16),
                      height: 30.0,
                      alignment: Alignment.centerLeft),
                  flex: 3)
            ],
          ),
          Divider(),
          Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                      child: Text('年龄', style: TextStyles.textGrey16),
                      height: 30.0,
                      alignment: Alignment.centerLeft),
                  flex: 1),
              Expanded(
                  child: Container(
                      child: Text('${getAge(playerBaseInfo?.birthDate)}岁',
                          style: TextStyles.textDark16),
                      height: 30.0,
                      alignment: Alignment.centerLeft),
                  flex: 3)
            ],
          ),
          Divider(),
          Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                      child: Text('体重', style: TextStyles.textGrey16),
                      height: 30.0,
                      alignment: Alignment.centerLeft),
                  flex: 1),
              Expanded(
                  child: Container(
                      child: Text('${playerBaseInfo?.weight}',
                          style: TextStyles.textDark16),
                      height: 30.0,
                      alignment: Alignment.centerLeft),
                  flex: 3)
            ],
          ),
          Divider(),
          Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                      child: Text('身高', style: TextStyles.textGrey16),
                      height: 30.0,
                      alignment: Alignment.centerLeft),
                  flex: 1),
              Expanded(
                  child: Container(
                      child: Text('${playerBaseInfo?.height}',
                          style: TextStyles.textDark16),
                      height: 30.0,
                      alignment: Alignment.centerLeft),
                  flex: 3)
            ],
          ),
          Divider(),
          Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                      child: Text('效力年数', style: TextStyles.textGrey16),
                      height: 30.0,
                      alignment: Alignment.centerLeft),
                  flex: 1),
              Expanded(
                  child: Container(
                      child: Text('${playerBaseInfo?.years}年',
                          style: TextStyles.textDark16),
                      height: 30.0,
                      alignment: Alignment.centerLeft),
                  flex: 3)
            ],
          ),
          Divider(),
          Row(children: <Widget>[
            Expanded(
                child: Container(
                    child: Text('球员荣誉', style: TextStyles.textGrey16),
                    height: 30.0,
                    alignment: Alignment.centerLeft),
                flex: 1),
            Expanded(
                child: honorList.length > 0
                    ? ListView.separated(
                        padding: EdgeInsets.zero,
                        itemBuilder: (_, index) {
                          List itemList = honorList[index].split('|');

                          return Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                          child: Text('${itemList[0]}',
                                              style: TextStyles.textBoldDark16)),
                                      Text('${itemList[1]}次',
                                          style: TextStyles.textDark16)
                                    ],
                                  ),
                                  Text('${itemList[2]}',
                                      style: TextStyles.textDark14)
                                ],
                              ),
                              alignment: Alignment.centerLeft);
                        },
                        itemCount: honorList.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        primary: false,
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(),
                      )
                    : Container(
                        height: 30.0,
                        child: Text('无', style: TextStyles.textDark16),
                        alignment: Alignment.centerLeft),
                flex: 3)
          ], crossAxisAlignment: CrossAxisAlignment.start),
          Divider(),
        ],
      ),
    );
  }
}
