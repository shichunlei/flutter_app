import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ImageWidget extends StatefulWidget {
  @override
  createState() => ImageWidgetState();
}

class ImageWidgetState extends State<ImageWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: Text("Widget Image or Icon"),
      ),
      body: new Scrollbar(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: new Center(
            child: new Column(
              children: <Widget>[
                /// 占位符淡入图片
                FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image:
                      'https://flutterchina.club/images/assets-and-images/icon.png',
                  width: 200.0,
                  height: 200.0,
                  fit: BoxFit.fill,
                ),
                FadeInImage.assetNetwork(
                  placeholder: 'images/flutter_logo.png',
                  image:
                      'https://flutterchina.club/images/assets-and-images/icon.png',
                  width: 200.0,
                  height: 200.0,
                  fit: BoxFit.fill,
                ),

                /// 给图片添加圆角
                ClipRRect(
                  /// 圆角
                  borderRadius: BorderRadius.circular(4.0),
                  child: Image.network(
                    "https://flutterchina.club/images/assets-and-images/icon.png",
                    width: 100.0,
                    height: 120.0,
                    fit: BoxFit.fill,
                  ),
                ),
                Image.asset('images/flutter_logo.png'),
                Image.asset(
                  'images/flutter_logo.png',
                  width: 130, //图片宽度
                  height: 130, //图片高度
                  fit: BoxFit.fill, //适配显示方式，fill表示宽高填充满
                ),
                Image.asset(
                  'images/flutter_logo.png',
                  width: 40,
                  color: Colors.red, //混合的颜色，和colorBlendMode一起使用
                  colorBlendMode:
                      BlendMode.overlay, //颜色和图片混合模式，功能较强大，其它模式参见官方文档或源码
                ),
                Image.asset(
                  'images/flutter_logo.png',
                  width: 50,
                  height: 50,
                  repeat: ImageRepeat.repeat, //在宽高内重复平铺图片，直到铺满
                ),
                Image(
                    image: AssetImage("images/flutter_logo.png"), width: 20.0),

                /// 加载网络图片
                Image.network(
                  "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4",
                  width: 140.0,
                ),

                /// 加载网络图片
                Image(
                  image: NetworkImage(
                      "https://img-blog.csdnimg.cn/20181226135809459.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3l1emhpcWlhbmdfMTk5Mw==,size_16,color_FFFFFF,t_70"),
                  width: 240.0,
                ),

                /// ICON
                Icon(
                  Icons.adb,
                ),
                Icon(
                  Icons.adb,
                  size: 50, //icon大小
                ),
                Icon(
                  Icons.adb,
                  color: Colors.red, //icon颜色
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
