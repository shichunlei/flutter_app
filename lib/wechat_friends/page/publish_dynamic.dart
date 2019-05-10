import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_app/ui/line.dart';

import 'package:flutter_app/utils/log_util.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_app/wechat_friends/ui/assets_view.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class PublishDynamicPage extends StatefulWidget {
  final List<Asset> images;

  PublishDynamicPage({Key key, this.images}) : super(key: key);

  @override
  createState() => _PublishDynamicPageState();
}

class _PublishDynamicPageState extends State<PublishDynamicPage> {
  List<Asset> images = [];

  int maxImages = 9;

  @override
  void initState() {
    super.initState();

    images = widget.images;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0.0,
        actions: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
            child: RaisedButton(
                onPressed: () {
                  /// TODO
                  Navigator.of(context).pop();
                },
                child: Text('发表', style: TextStyle(color: Colors.white)),
                color: Colors.green),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              height: 100,
              child: TextField(),
            ),
            Line(color: Colors.grey),
            GridView.builder(
                padding: EdgeInsets.all(10.0),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: (Utils.width - 20) / 3,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                    childAspectRatio: 1.0),
                itemBuilder: (context, index) => AssetView(
                      asset: images[index],
                      onTap: () {
                        if (images.length < maxImages &&
                            index == images.length - 1) {
                          loadAssets();
                        }

                        /// TODO 进入预览界面
                      },
                      index: index,
                      showAdd: images.length < maxImages &&
                          index == images.length - 1,
                    ),
                itemCount: images.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                primary: false),
            Line(color: Colors.grey),
            ListTile(
                leading: Icon(Icons.location_on),
                title: Text('所在位置'),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {}),
            Line(color: Colors.grey),
            ListTile(
                leading: Icon(Icons.remove_red_eye),
                title: Text('谁可以看'),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {}),
            Line(color: Colors.grey),
            ListTile(
                leading: Icon(Icons.attachment),
                title: Text('提醒谁看'),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {}),
            Line(color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Future<void> loadAssets() async {
    try {
      images = await MultiImagePicker.pickImages(
          maxImages: maxImages,
          options: CupertinoOptions(takePhotoIcon: "chat"));
    } on PlatformException catch (e) {
      LogUtil.v('${e.message}');
    }

    if (images.isNotEmpty && images.length < maxImages) {
      images.add(Asset('', '', 0, 0));
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {});
  }
}
