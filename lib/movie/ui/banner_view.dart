import 'package:flutter/material.dart';
import 'package:flutter_app/bean/news.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

import '../../page_index.dart';

class BannerView extends StatefulWidget {
  final List<News> banner;

  BannerView({Key key, this.banner}) : super(key: key);

  @override
  _BannerViewState createState() => _BannerViewState();
}

class _BannerViewState extends State<BannerView> {
  double radius = 5.0;
  double height = 210.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      height: height,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            /// 圆角
            borderRadius: BorderRadius.circular(radius),
            child: Stack(
              children: <Widget>[
                ImageLoadView(widget.banner[index].cover, height: height),
                Opacity(
                  opacity: 0.4,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius:
                            BorderRadius.all(Radius.circular(radius))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        widget.banner[index].title,
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                      Text(
                        widget.banner[index].summary,
                        maxLines: 2,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: widget.banner.length,
        viewportFraction: 0.8,
        scale: 0.9,
        autoplay: true,
        onTap: (index) {
          pushNewPage(
            context,
            WebViewPage(
              url: widget.banner[index].link,
              title: widget.banner[index].title,
            ),
          );
        },
      ),
    );
  }
}
