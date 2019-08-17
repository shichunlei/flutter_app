import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../page_index.dart';
import '../index.dart';

/// 我说/焦点小组
class LabISayPage extends StatefulWidget {
  final int id;
  final PostBean post;
  final String tag;
  final bool isNew;

  LabISayPage({
    Key key,
    @required this.id,
    @required this.tag,
    this.isNew = false,
    this.post,
  })  : assert(id != null),
        assert(tag != null),
        super(key: key);

  @override
  createState() => _LabISayPageState();
}

class _LabISayPageState extends State<LabISayPage> {
  List<Option> options = [];
  ResponseBean responseBean;

  @override
  void initState() {
    super.initState();

    getData(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    double width = Utils.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: <Widget>[
        Expanded(
          child: ListView(padding: EdgeInsets.only(top: 0), children: <Widget>[
            Container(
              child: Column(children: <Widget>[
                Container(
                  height: width * 2 / 3,
                  child: Stack(children: <Widget>[
                    Hero(
                        tag: widget.tag,
                        child: ImageLoadView('${widget.post?.image}',
                            fit: BoxFit.cover,
                            height: width * 2 / 3,
                            width: width)),
                    Container(
                      padding: EdgeInsets.only(
                          top: 10 + Utils.topSafeHeight, right: 10),
                      alignment: Alignment.topRight,
                      child: Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            Image.asset(
                                widget.isNew
                                    ? 'images/qdaily/icon_lab_vot_new.png'
                                    : 'images/qdaily/icon_lab_vot_join.png',
                                height: 47.5,
                                width: 57),
                            widget.isNew
                                ? SizedBox()
                                : Container(
                                    child: Text(
                                      '${widget.post?.recordCount}',
                                      style: TextStyle(
                                          color: Color(0xFFFFD003),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    margin: EdgeInsets.only(top: 3))
                          ]),
                    ),
                  ]),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('${widget.post?.title}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        Text('${widget.post?.description}',
                            style: TextStyle(color: Colors.grey))
                      ]),
                )
              ]),
            ),
            Container(height: 10, color: Colors.grey[100]),
            Container(
                child: StaggeredGridView.countBuilder(
                    padding: EdgeInsets.only(top: 5, left: 5, right: 5),
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 4,
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                    itemBuilder: (context, index) {
                      if (options[index].image == null ||
                          options[index].image.isEmpty) {
                        return ItemOptionText(option: options[index]);
                      } else {
                        return ItemOptionImage(option: options[index]);
                      }
                    },
                    staggeredTileBuilder: (index) => StaggeredTile.fit(2),
                    itemCount: options.length)),
            LineViewLine(
                child: Text('没有更多了', style: TextStyle(color: Colors.grey)),
                horizontalPadding: 80.0,
                verticalPadding: 40)
          ]),
        ),
        BottomAppbar(actions: <Widget>[
          IconButton(icon: Icon(FeatherIcons.edit), onPressed: () {}),
          IconButton(icon: Icon(FeatherIcons.share), onPressed: () {})
        ]),
      ]),
    );
  }

  void getData(int labId) async {
    responseBean = await ApiService.getQdailyLabsDetailData(labId);

    if (responseBean == null) {
      // 请求失败
    } else {
      options.addAll(responseBean?.options);

      setState(() {});
    }
  }
}
