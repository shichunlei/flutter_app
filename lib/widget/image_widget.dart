import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ImageWidget extends StatefulWidget {
  @override
  createState() => ImageWidgetState();
}

class ImageWidgetState extends State<ImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Widget Image And Icon"),
        ),
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              /// 占位符淡入图片
              FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image:
                    'https://img1.mukewang.com/545862800001e2d802200220-100-100.jpg',
                fit: BoxFit.cover,
              ),
              Divider(),
              FadeInImage.assetNetwork(
                placeholder: 'images/flutter_logo.png',
                image:
                    'https://avatars2.githubusercontent.com/u/20411648?s=460&v=4',
                fit: BoxFit.fill,
              ),
              Divider(),

              /// 给图片添加圆角
              ClipRRect(
                /// 圆角
                borderRadius: BorderRadius.circular(14.0),
                child: Image.network(
                  "https://flutterchina.club/images/assets-and-images/icon.png",
                  fit: BoxFit.fill,
                ),
              ),
              Divider(),
              Image.asset('images/timg.gif'),
              Divider(),
              Image.asset(
                'images/flutter_logo.png',
                width: 130, //图片宽度
                height: 130, //图片高度
                fit: BoxFit.scaleDown, //适配显示方式，fill表示宽高填充满
              ),
              Divider(),
              Image.asset(
                'images/flutter_logo.png',
                width: 40,
                color: Colors.red, //混合的颜色，和colorBlendMode一起使用
                colorBlendMode:
                    BlendMode.overlay, //颜色和图片混合模式，功能较强大，其它模式参见官方文档或源码
              ),
              Divider(),
              Image.asset(
                'images/flutter_logo.png',
                width: 50,
                height: 50,
                repeat: ImageRepeat.repeat, //在宽高内重复平铺图片，直到铺满
              ),
              Divider(),
              Image(image: AssetImage("images/flutter_logo.png")),
              Divider(),

              /// 加载网络图片
              Image.network(
                "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4",
              ),
              Divider(),

              /// 加载网络图片
              Image(
                image: NetworkImage(
                    "https://github.com/hjnilsson/country-flags/blob/master/png1000px/cn.png?raw=true"),
              ),

              Divider(),

              /// 导入第三方库图片
              Image.asset(
                  'packages/flutter_gallery_assets/people/ali_landscape.png'),
            ],
          ),
        ));
  }
}
