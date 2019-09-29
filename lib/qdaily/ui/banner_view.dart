import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../page_index.dart';
import '../index.dart';

class BannerView extends StatelessWidget {
  final List<BannersBean> banners;

  BannerView({Key key, @required this.banners}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 32 / 19,
      child: Swiper(
          itemBuilder: (BuildContext context, int index) => InkWell(
                onTap: () => pushNewPage(
                    context, ArticleDetail(id: banners[index]?.post?.id)),
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: <Widget>[
                    ImageLoadView(banners[index]?.image),
                    Container(
                        width: double.infinity,
                        color: Color(0x2b000000),
                        child: Text('${banners[index]?.post?.title}',
                            style:
                                TextStyle(color: Colors.white, fontSize: 22)),
                        padding: EdgeInsets.only(left: 20, bottom: 30))
                  ],
                ),
              ),
          itemCount: banners.length,
          pagination: SwiperPagination()),
    );
  }
}
