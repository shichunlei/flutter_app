import 'package:flutter/material.dart';
import 'package:flutter_app/bean/sars_cov.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../ui/item_rumor.dart';
import 'title_container.dart';

class RumorView extends StatelessWidget {
  final List<RumourBean> rumour;

  RumorView({Key key, @required this.rumour}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(children: [
        TitleContainer(title: "辟谣"),
        AspectRatio(
            aspectRatio: 0.8,
            child: Container(
                child: Swiper(
                    itemCount: 10,
                    itemBuilder: (_, index) =>
                        ItemRumor(index: index + 1, rumour: rumour[index]),
                    viewportFraction: 0.85,
                    scale: 0.9,
                    autoplay: true)))
      ]),
    );
  }
}
