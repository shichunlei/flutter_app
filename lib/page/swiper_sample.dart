import 'package:flutter/material.dart';
import 'package:flutter_app/custom_widgets/dots_indicator.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../page_index.dart';

class SwiperSample extends StatelessWidget {
  SwiperSample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Swiper')),
        body: ListView(physics: BouncingScrollPhysics(), children: <Widget>[
          Container(
            height: 230,
            child: Swiper(
                itemBuilder: (BuildContext context, int index) =>
                    ImageLoadView(bannerImages[index], fit: BoxFit.cover),
                itemCount: bannerImages.length,
                pagination: SwiperPagination(
                    builder: SwiperPagination.fraction,
                    alignment: Alignment.bottomRight)),
          ),
          Gaps.vGap20,
          Container(
            height: 200,
            color: Colors.grey.shade800,
            padding: EdgeInsets.all(10.0),
            child: Swiper(
              itemBuilder: (BuildContext context, int index) => ImageLoadView(
                bannerImages[index],
                fit: BoxFit.cover,
              ),
              itemCount: bannerImages.length,
              pagination: SwiperCustomPagination(
                builder: (BuildContext context, SwiperPluginConfig config) {
                  return Container(
                    alignment: Alignment.bottomRight,
                    child: DotsIndicator(
                      dotsCount: bannerImages.length,
                      position: config.activeIndex,
                      reversed: false,
                      decorator: DotsDecorator(
                        activeColor: Colors.red,
                        activeSize: Size.square(12.0),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Gaps.vGap20,
          Container(
            height: 200,
            color: Colors.grey.shade800,
            child: Swiper(
              itemBuilder: (BuildContext context, int index) => ImageLoadView(
                bannerImages[index],
                fit: BoxFit.cover,
              ),
              itemCount: bannerImages.length,
              pagination: SwiperCustomPagination(
                builder: (BuildContext context, SwiperPluginConfig config) {
                  return Container(
                    alignment: Alignment.bottomCenter,
                    child: DotsIndicator(
                      dotsCount: bannerImages.length,
                      position: config.activeIndex,
                      reversed: false,
                      decorator: DotsDecorator(
                        size: const Size.square(9.0),
                        activeSize: const Size(18.0, 9.0),
                        activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Gaps.vGap20,
          Container(
              height: 200,
              color: Colors.grey.shade800,
              padding: EdgeInsets.all(10.0),
              child: Swiper(
                  itemBuilder: (BuildContext context, int index) =>
                      ImageLoadView(bannerImages[index],
                          borderRadius: BorderRadius.circular(10.0),
                          fit: BoxFit.cover),
                  itemCount: bannerImages.length,
                  viewportFraction: 0.8,
                  scale: 0.9,
                  pagination: SwiperPagination())),
          Gaps.vGap20,
          Container(
              height: 400,
              color: Colors.grey.shade500,
              padding: EdgeInsets.all(16.0),
              child: Swiper(
                  itemWidth: 300,
                  itemCount: Girl.girls.length,
                  layout: SwiperLayout.STACK,
                  itemBuilder: (BuildContext context, int index) =>
                      ImageLoadView(Girl.girls[index].image,
                          borderRadius: BorderRadius.circular(10.0),
                          fit: BoxFit.cover))),
          Gaps.vGap20,
          Container(
              height: 420,
              color: Colors.grey.shade500,
              padding: EdgeInsets.all(10.0),
              child: Swiper(
                  itemWidth: 300,
                  itemHeight: 400,
                  itemCount: Girl.girls.length,
                  layout: SwiperLayout.TINDER,
                  itemBuilder: (BuildContext context, int index) =>
                      ImageLoadView(Girl.girls[index].image,
                          borderRadius: BorderRadius.circular(10.0),
                          fit: BoxFit.cover))),
          Gaps.vGap20,
          Container(
            height: 340,
            color: Colors.grey.shade800,
            padding: EdgeInsets.all(16.0),
            child: Swiper(
              fade: 0.0,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0)),
                          image: DecorationImage(
                              image: NetworkImage(bannerImages[index]),
                              fit: BoxFit.cover)),
                    ),
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0))),
                        child: ListTile(
                            subtitle: Text("awesome image caption"),
                            title: Text("Awesome image")))
                  ],
                );
              },
              itemCount: bannerImages.length,
              scale: 0.9,
              pagination: SwiperPagination(),
            ),
          )
        ]));
  }
}
