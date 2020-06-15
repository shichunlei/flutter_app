import 'package:flutter/material.dart';
import 'package:flutter_app/bean/sars_cov.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../../page_index.dart';
import 'title_container.dart';

class MapView extends StatelessWidget {
  final SARSCov data;

  MapView({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(children: [
        TitleContainer(title: "疫情地图"),
        AspectRatio(
            child: ImageLoadView('${data?.imgUrl}'), aspectRatio: 1236 / 1020),
        TitleContainer(title: "全国疫情趋势图"),
        AspectRatio(
            aspectRatio: 1765 / 920,
            child: Swiper(
                autoplay: true,
                itemCount: data?.quanGuoTrendChart?.length,
                itemBuilder: (BuildContext context, int index) => ImageLoadView(
                    '${data?.quanGuoTrendChart[index].imgUrl}',
                    fit: BoxFit.fill),
                onTap: (int index) {})),
        TitleContainer(title: "湖北/非湖北"),
        AspectRatio(
            aspectRatio: 1765 / 920,
            child: Swiper(
                autoplay: true,
                itemCount: data?.hbFeiHbTrendChart?.length,
                itemBuilder: (BuildContext context, int index) => ImageLoadView(
                    '${data?.hbFeiHbTrendChart[index].imgUrl}',
                    fit: BoxFit.fill),
                onTap: (int index) {})),
      ]),
    );
  }
}
