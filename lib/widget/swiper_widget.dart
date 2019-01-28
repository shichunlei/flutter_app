import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SwiperWidget extends StatefulWidget {
  @override
  createState() => SwiperWidgetState();
}

class SwiperWidgetState extends State<SwiperWidget> {
  List<String> _images = [];

  @override
  void initState() {
    super.initState();

    _images.add(
        "https://img-blog.csdnimg.cn/20181226135809459.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3l1emhpcWlhbmdfMTk5Mw==,size_16,color_FFFFFF,t_70");
    _images.add(
        "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1910982517,3636589052&fm=26&gp=0.jpg");
    _images.add(
        "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1910982517,3636589052&fm=26&gp=0.jpg");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Text("SwiperWidget"),
          alignment: Alignment.center,
        ),
      ),
      body: Container(
        height: 130.0,
        child: Swiper(
          /// 初始的时候下标位置
          index: 0,

          /// 无限轮播模式开关
          loop: true,

          ///
          itemBuilder: (context, index) {
            return Image.network(
              _images[index],
              fit: BoxFit.fill,
            );
          },

          ///
          itemCount: _images.length,

          /// 设置 new SwiperPagination() 展示默认分页指示器
          pagination: SwiperPagination(),

          /// 设置 new SwiperControl() 展示默认分页按钮
          control: SwiperControl(),

          /// 自动播放开关.
          autoplay: true,

          /// 动画时间，单位是毫秒
          duration: 300,

          /// 当用户点击某个轮播的时候调用
          onTap: (index) {
            print("你点击了第$index个");
          },

          /// 滚动方向，设置为Axis.vertical如果需要垂直滚动
          scrollDirection: Axis.vertical,
        ),
      ),
    );
  }
}
