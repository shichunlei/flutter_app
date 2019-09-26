import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../page_index.dart';
import '../index.dart';

/// 我说/焦点小组
class LabISayPage extends StatefulWidget {
  final PostBean post;
  final String tag;
  final bool isNew;

  LabISayPage({
    Key key,
    @required this.tag,
    this.isNew = false,
    this.post,
  })  : assert(tag != null),
        super(key: key);

  @override
  createState() => _LabISayPageState();
}

class _LabISayPageState extends State<LabISayPage> {
  List<Option> options = [];
  ResponseBean responseBean;

  LoaderState _status = LoaderState.Loading;

  @override
  void initState() {
    super.initState();

    getData(widget.post.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: LoaderContainer(
        onReload: () => getData(widget.post.id),
        contentView: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(top: 0),
                children: <Widget>[
                  LabInfoHeaderView(
                    tag: widget.tag,
                    post: widget.post,
                  ),
                  StaggeredGridView.countBuilder(
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
                      itemCount: options.length),
                  LineViewLine(
                      child:
                          Text('没有更多了', style: TextStyle(color: Colors.grey)),
                      horizontalPadding: 80.0,
                      verticalPadding: 40)
                ],
              ),
            ),
            BottomAppbar(actions: <Widget>[
              IconButton(icon: Icon(Feather.edit), onPressed: () {}),
              IconButton(icon: Icon(Feather.share), onPressed: () {})
            ]),
          ],
        ),
        loaderState: _status,
      ),
    );
  }

  void getData(int labId) async {
    responseBean = await ApiService.getQdailyLabsDetailData(labId);

    if (responseBean == null) {
      // 请求失败
      _status = LoaderState.Failed;
    } else {
      options.addAll(responseBean?.options);
      _status = LoaderState.Succeed;
    }

    setState(() {});
  }
}
