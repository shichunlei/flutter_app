import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bean/friends_dynamic.dart';
import 'package:flutter_app/generated/i18n.dart';
import '../ui/item_dynamic.dart';

import 'package:multi_image_picker/multi_image_picker.dart';

import '../../page_index.dart';
import 'publish_dynamic.dart';

class WeChatFriendsCircle extends StatefulWidget {
  WeChatFriendsCircle({Key key}) : super(key: key);

  @override
  createState() => _WeChatFriendsCircleState();
}

class _WeChatFriendsCircleState extends State<WeChatFriendsCircle> {
  List<FriendsDynamic> friendsDynamic = [];

  double navAlpha = 0;
  double headerHeight;
  ScrollController scrollController = ScrollController();

  Color c = Colors.grey;
  String title = '';

  List<Asset> images = List<Asset>();

  int maxImages = 9;

  @override
  void initState() {
    super.initState();

    getData();

    headerHeight = 250;

    scrollController.addListener(() {
      var offset = scrollController.offset;
      if (offset <= 0) {
        if (navAlpha != 0) {
          setState(() => navAlpha = 0);
        }
      } else if (offset < headerHeight) {
        if (headerHeight - offset <= Utils.navigationBarHeight) {
          setState(() {
            c = Colors.black;
            title = '朋友圈';
          });
        } else {
          c = Colors.white;
          title = '';
        }
        setState(() => navAlpha = 1 - (headerHeight - offset) / headerHeight);
      } else if (navAlpha != 1) {
        setState(() => navAlpha = 1);
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              controller: scrollController,
              child: Column(children: <Widget>[
                Stack(
                  alignment: Alignment.bottomRight,
                  children: <Widget>[
                    Container(
                        child: ImageLoadView(backgroundImage,
                            height: headerHeight, width: Utils.width),
                        margin: EdgeInsets.only(bottom: 30.0)),
                    Container(
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 10, right: 10),
                                child: Text('张三',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17)),
                              ),
                              ImageLoadView(
                                  'http://cdn.duitang.com/uploads/item/201409/18/20140918141220_N4Tic.thumb.700_0.jpeg',
                                  height: 70,
                                  width: 70,
                                  radius: 5)
                            ]),
                        margin: EdgeInsets.only(right: 10))
                  ],
                ),
                Gaps.vGap10,
                ListView.separated(
                  itemBuilder: (context, index) =>
                      ItemDynamic(friendsDynamic[index]),
                  itemCount: friendsDynamic.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  primary: false,
                  separatorBuilder: (BuildContext context, int index) =>
                      Container(
                    height: 0.4,
                    color: Colors.grey,
                  ),
                )
              ]),
            ),
            ToolBar(
              backgroundColor:
                  Color.fromARGB((navAlpha * 255).toInt(), 180, 180, 180),
              title: Text(title,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Color.fromARGB(
                          (navAlpha * 255).toInt(), 255, 255, 255))),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.add_a_photo,
                    color: Colors.white,
                  ),
                  onPressed: () => _showDialog(context),
                )
              ],
            ),
          ],
        ));
  }

  void getData() async {
    FileUtil.getInstance()
        .readDataFromAssets("assets/data/", "friends.json")
        .then((data) {
      friendsDynamic = FriendsDynamic.fromMapList(json.decode(data));
      setState(() {});
    });
  }

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(actions: <Widget>[
              CupertinoDialogAction(
                child: Text('拍摄', style: TextStyles.textBlue16),
                onPressed: () {
                  /// TODO
                  Navigator.pop(context);
                },
              ),
              CupertinoDialogAction(
                child: Text('从相册选择', style: TextStyles.textBlue16),
                onPressed: () {
                  loadAssets();
                  Navigator.pop(context);
                },
              ),
              CupertinoDialogAction(
                child: Text('${S.of(context).cancel}',
                    style: TextStyles.textRed16),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ]));
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: maxImages,
        enableCamera: false,
        selectedAssets: images,
        materialOptions: MaterialOptions(
          actionBarColor: "#ff00a5",
          actionBarTitle: "Flutter App",
          actionBarTitleColor: "#ffffffff",
          allViewTitle: "All Photos",
          useDetailsView: true,
          lightStatusBar: false,
          selectCircleStrokeColor: "#ff11ab",
          statusBarColor: '#ff00a5',
          startInAllView: true,
          selectionLimitReachedText: "You can't select any more.",
        ),
        cupertinoOptions: CupertinoOptions(
          selectionFillColor: "#ff11ab",
          selectionTextColor: "#ff00a5",
          selectionCharacter: "✓",
        ),
      );

      for (var r in resultList) {
        var t = r.name;
        print(t);
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;

      debugPrint(images.toString());

      if (images.isNotEmpty) {
        pushNewPage(
            context, PublishDynamicPage(images: images, maxImages: maxImages));
      }
    });
  }
}
