import 'package:flutter/material.dart';
import 'package:flutter_app/bean/movie.dart';

import '../../page_index.dart';

class ItemSoonView extends StatefulWidget {
  final Movie movie;
  final VoidCallback onTap;

  ItemSoonView(this.movie, {Key key, this.onTap}) : super(key: key);

  @override
  _ItemSoonViewState createState() => _ItemSoonViewState();
}

class _ItemSoonViewState extends State<ItemSoonView>
    with AutomaticKeepAliveClientMixin<ItemSoonView> {
  @override
  bool get wantKeepAlive => true;

  Color cardBackgroundColor = Color(0xff35374c);

  @override
  void initState() {
    super.initState();

    getBackgroundColor();
  }

  void getBackgroundColor() async {
    cardBackgroundColor =
        await Utils.getImageDominantColor(widget.movie.images.small);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String desc = '';
    widget.movie.genres.map((genre) {
      desc += genre;
      desc += ' ';
    }).toList();

    return GestureDetector(
      child: Card(
        color: cardBackgroundColor,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: new Container(
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: <
                Widget>[
              /// 电影主图
              ImageLoadView(widget.movie.images.medium.toString(),
                  height: 180, width: 120),
              SizedBox(width: 8),

              /// 右侧部分
              Expanded(
                child: Column(

                    /// 垂直居上
                    mainAxisAlignment: MainAxisAlignment.start,

                    /// 水平居左
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      /// 中文名
                      Text(
                        widget.movie.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22.0,
                        ),
                      ),
                      SizedBox(height: 8.0),

                      /// 上映信息
                      Text(
                        desc,
                        style: TextStyle(color: Colors.white, fontSize: 12.0),
                      ),
                      SizedBox(height: 8.0),

                      /// 演员
                      Wrap(
                          spacing: 5.0,
                          children: widget.movie.casts.map((cast) {
                            return CircleAvatar(
                                backgroundImage:
                                    NetworkImage(cast.avatars.small),
                                radius: 22.0);
                          }).toList()),
                      SizedBox(height: 8.0),

                      /// 中国大陆上映日期
                      Container(
                          child: Text(
                              '${widget.movie.mainland_pubdate.split('-')[1]}月${widget.movie.mainland_pubdate.split('-')[2]}日上映',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 22.0))),

                      /// 想看
                      RaisedButton(
                        color: Color(0x2affffff),
                        onPressed: () {},
                        elevation: 0,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.favorite,
                                  color: Colors.white, size: 18),
                              SizedBox(width: 4),
                              Text('想看', style: TextStyle(color: Colors.white))
                            ]),
                      )
                    ]),
              ),
            ]),
          ),
        ),
      ),
      onTap: widget.onTap,
    );
  }
}
