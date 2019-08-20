import 'dart:io';

import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../generated/i18n.dart';
import '../store/index.dart';

import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

import '../page_index.dart';

class MinePage extends StatefulWidget {
  MinePage({Key key}) : super(key: key);

  @override
  createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  bool isEdit = false;

  File _imageFile;

  @override
  Widget build(BuildContext context) {
    return Store.connect<UserModel>(builder: (_, UserModel userModel, __) {
      return Scaffold(
          backgroundColor: Colors.grey[200],
          body: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Column(children: <Widget>[
                  Container(
                      height: 250,
                      child: Stack(children: <Widget>[
                        Arc(
                            child: ImageLoadView(backgroundImage,
                                fit: BoxFit.cover,
                                height: 210,
                                width: double.infinity),
                            height: 30,
                            edge: Edge.BOTTOM,
                            arcType: ArcType.CONVEX),
                        Positioned(
                            child: Container(
                              child: Column(children: <Widget>[
                                Align(
                                    alignment: Alignment.center,
                                    child: InkWell(
                                        onTap: isEdit
                                            ? () => pushNewPage(
                                                context,
                                                InputTextPage(
                                                    title: '修改姓名',
                                                    content:
                                                        '${userModel.getName()}',
                                                    maxLines: 1,
                                                    maxLength: 5),
                                                callBack: (value) => userModel
                                                    .setUser(name: value))
                                            : null,
                                        child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text('${userModel.getName()}',
                                                  style:
                                                      TextStyles.textWhite16),
                                              Offstage(
                                                  offstage: !isEdit,
                                                  child: Icon(Icons.edit,
                                                      color: Colors.white,
                                                      size: 15))
                                            ]))),
                                Gaps.vGap5,
                                Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      ImageLoadView(
                                          '${userModel.getAvatarPath()}',
                                          imageType: userModel.isLocal()
                                              ? ImageType.localFile
                                              : ImageType.network,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40.0)),
                                          width: 80,
                                          height: 80),
                                      Offstage(
                                          offstage: !isEdit,
                                          child: IconButton(
                                              icon: Icon(Icons.photo_camera,
                                                  color: Colors.white),
                                              onPressed: () => choiceImage()))
                                    ])
                              ]),
                            ),
                            bottom: 0,
                            right: 0,
                            left: 0),
                      ])),
                  Divider(),
                  SelectTextItem(
                      leading: Icon(Icons.email, size: 26),
                      title: '邮箱',
                      content: '${userModel.getEmail()}',
                      margin: EdgeInsets.only(left: 16.0, right: 8),
                      onTap: isEdit
                          ? () => pushNewPage(
                                  context,
                                  InputTextPage(
                                    title: '修改邮箱',
                                    content: '${userModel.getEmail()}',
                                    maxLines: 1,
                                    keyboardType: TextInputType.emailAddress,
                                  ), callBack: (value) {
                                userModel.setUser(email: value);
                              })
                          : null,
                      textAlign: TextAlign.right),
                  Divider(),
                  Container(height: 1000)
                ]),
              ),
              Container(
                height: Utils.navigationBarHeight,
                child: AppBar(
                  elevation: 0.0,
                  title: Text('个人中心'),
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  actions: <Widget>[
                    IconButton(
                        icon: Text(isEdit
                            ? "${S.of(context).save}"
                            : '${S.of(context).edit}'),
                        onPressed: () => setState(() => isEdit = !isEdit))
                  ],
                ),
              ),
            ],
          ));
    });
  }

  choiceImage() {
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(actions: <Widget>[
              CupertinoDialogAction(
                  child: const Text('拍摄', style: TextStyles.textBlue16),
                  onPressed: () => fromCamera()),
              CupertinoDialogAction(
                  child: const Text('从相册选择', style: TextStyles.textBlue16),
                  onPressed: () => fromGallery()),
              CupertinoDialogAction(
                  child: Text('${S.of(context).cancel}',
                      style: TextStyles.textRed16),
                  onPressed: () => Navigator.pop(context))
            ]));
  }

  /// 从相机
  fromCamera() async {
    Navigator.of(context).pop();
    try {
      var image = await ImagePicker.pickImage(source: ImageSource.camera);

      _cropImage(image);
    } catch (e) {
      print(e);
    }
  }

  /// 从相册
  fromGallery() async {
    Navigator.of(context).pop();
    try {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      _cropImage(image);
    } catch (e) {
      print(e);
    }
  }

  setImgPath(File file) async {
    debugPrint("setImgPath()====$file");
    setState(() {
      _imageFile = file;
    });
    debugPrint('${_imageFile.path}');
    _cropImage(file);
  }

  /// 裁剪
  Future<Null> _cropImage(File imageFile) async {
    assert(imageFile != null);
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      ratioX: 1.0,
      ratioY: 1.0,
      maxWidth: 512,
      maxHeight: 512,
    );

    debugPrint('cropImage=============${croppedFile.path}');
    Store.value<UserModel>(context)
        .setUser(avatarPath: croppedFile.path, isLocalImage: true);
  }
}
