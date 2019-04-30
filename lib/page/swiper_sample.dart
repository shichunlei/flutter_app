import 'package:flutter/material.dart';
import 'package:flutter_app/global/data.dart';
import 'package:flutter_app/ui/image_load_view.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

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
                    ImageLoadView(banner_images[index], fit: BoxFit.cover),
                itemCount: banner_images.length,
                pagination: SwiperPagination(
                    builder: SwiperPagination.fraction,
                    alignment: Alignment.bottomRight)),
          ),
          SizedBox(height: 20.0),
          Container(
            height: 200,
            color: Colors.grey.shade800,
            padding: EdgeInsets.all(10.0),
            child: Swiper(
                itemBuilder: (BuildContext context, int index) =>
                    ImageLoadView(banner_images[index], fit: BoxFit.cover),
                itemCount: banner_images.length,
                pagination: SwiperCustomPagination(
                    builder: (BuildContext context, SwiperPluginConfig config) {
                  return Container(
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: Text(
                          '${config.activeIndex + 1}/${config.itemCount}'));
                })),
          ),
          SizedBox(height: 20.0),
          Container(
              height: 200,
              color: Colors.grey.shade800,
              padding: EdgeInsets.all(10.0),
              child: Swiper(
                  itemBuilder: (BuildContext context, int index) =>
                      ImageLoadView(banner_images[index],
                          borderRadius: BorderRadius.circular(10.0),
                          fit: BoxFit.cover),
                  itemCount: banner_images.length,
                  viewportFraction: 0.8,
                  scale: 0.9,
                  pagination: SwiperPagination())),
          SizedBox(height: 20.0),
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
          SizedBox(height: 20.0),
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
          SizedBox(height: 20.0),
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
                              image: NetworkImage(banner_images[index]),
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
              itemCount: banner_images.length,
              scale: 0.9,
              pagination: SwiperPagination(),
            ),
          )
        ]));
  }
}
