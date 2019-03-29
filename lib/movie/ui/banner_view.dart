import 'package:flutter/material.dart';
import 'package:flutter_app/movie/bean/news.dart';
import 'package:flutter_app/utils/log_util.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:transparent_image/transparent_image.dart';

class BannerView extends StatefulWidget {
  final List<News> banner;

  BannerView({Key key, this.banner}) : super(key: key);

  @override
  _BannerViewState createState() => _BannerViewState();
}

class _BannerViewState extends State<BannerView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      height: 220.0,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            /// 圆角
            borderRadius: BorderRadius.circular(4.0),
            child: Stack(
              children: <Widget>[
                FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: widget.banner[index].cover,
                  fit: BoxFit.fill,
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
          LogUtil.v("你点击了${widget.banner[index].link}");
        },
      ),
    );
  }
}
