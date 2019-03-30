import 'package:flutter/material.dart';
import 'package:flutter_app/custom_widgets/swiper_widget.dart';
import 'package:flutter_app/global/data.dart';

class SwiperPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 3.25 / 5.62,
              child: Swiper(
                indicatorAlignment: AlignmentDirectional.bottomEnd,
                speed: 400,
                indicator: CircleSwiperIndicator(),
                children: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map((i) {
                  Image.network('images/newyear_picture$i.jpg',
                      fit: BoxFit.fill);
                }).toList(),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
              child: SizedBox(
                height: 200.0,
                child: Swiper(
                  circular: true,
                  //reverse: true, //反向
                  indicator: RectangleSwiperIndicator(),
                  children: banner_images
                      .map((image) => Image.network(image, fit: BoxFit.fill))
                      .toList(),
                ),
              ),
            ),
            AspectRatio(
              aspectRatio: 16.0 / 9.0,
              child: Swiper(
                indicatorAlignment: AlignmentDirectional.topEnd,
                circular: true,
                indicator: NumberSwiperIndicator(),
                children: banner_images
                    .map((image) => Image.network(image, fit: BoxFit.fill))
                    .toList(),
              ),
            ),
            AspectRatio(
              aspectRatio: 16.0 / 9.0,
              child: Swiper.builder(
                indicatorAlignment: AlignmentDirectional.topEnd,
                circular: true,
                childCount: banner_images.length,
                indicator: NumberSwiperIndicator(),
                itemBuilder: (context, index) {
                  //print(index);
                  return Image.network(banner_images[index], fit: BoxFit.fill);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NumberSwiperIndicator extends SwiperIndicator {
  @override
  Widget build(BuildContext context, int index, int itemCount) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black45, borderRadius: BorderRadius.circular(20.0)),
      margin: EdgeInsets.only(top: 10.0, right: 5.0),
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
      child: Text('${++index}/$itemCount',
          style: TextStyle(color: Colors.white70, fontSize: 12.0)),
    );
  }
}
