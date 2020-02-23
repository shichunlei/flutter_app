import 'package:flutter/material.dart';
import 'package:flutter_app/bean/sars_cov.dart';
import 'package:flutter_app/ui/image_load_view.dart';

class ItemAreaNewsView extends StatelessWidget {
  final ProvinceNews news;
  final bool isFirst;
  final bool isLast;

  ItemAreaNewsView(
      {Key key, @required this.news, this.isFirst: false, this.isLast: false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            color: Color(0xFFF8F8F8),
            padding: EdgeInsets.only(left: 10),
            width: 50,
            child: Column(
              children: [
                Container(
                  height: 10,
                  width: 1,
                  color: isFirst ? Colors.transparent : Color(0xFFCAD1F8),
                ),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Color(0xFF0B5CFB),
                  ),
                ),
                Container(
                  height: 110,
                  width: 1,
                  color: isLast ? Colors.transparent : Color(0xFFCAD1F8),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 5, right: 10),
              height: 130,
              width: double.infinity,
              color: Color(0xFFF8F8F8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: <Widget>[
                      Text(
                        '${news?.cTime}',
                        style: TextStyle(fontSize: 15, color: Colors.black54),
                      ),
                      Offstage(
                        offstage: !isFirst,
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            '最新',
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                          color: Colors.blue,
                        ),
                      )
                    ],
                  ),
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    clipBehavior: Clip.antiAlias,
                    margin: EdgeInsets.all(5),
                    child: Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          width: double.infinity,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        '${news?.title}',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text('\n来源：${news?.media}'),
                                    ],
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                  ),
                                ),
                              ),
                              Visibility(
                                child: ImageLoadView(
                                  '${news?.thumb}',
                                  width: 100,
                                  height: 94,
                                  fit: BoxFit.cover,
                                ),
                                visible: news?.thumb != "",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
