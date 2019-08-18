import 'dart:io';

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
    return Store.connect<UserModel>(builder: (_, UserModel _data, __) {
      return Scaffold(
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            Container(
              child: AppBar(
                elevation: 0.0,
                title: Text('个人中心'),
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                      icon: Text(isEdit
                          ? "${S.of(context).save}"
                          : '${S.of(context).edit}'),
                      onPressed: () {
                        setState(() {
                          isEdit = !isEdit;
                        });
                      })
                ],
              ),
            ),
            Container(
                height: 150,
                width: double.infinity,
                child: Center(
                  child: Stack(children: <Widget>[
                    CircleAvatar(
                        radius: 40,
                        backgroundImage: _data.isLocal()
                            ? FileImage(File('${_data.getAvatarPath()}'))
                            : NetworkImage('${_data.getAvatarPath()}')),
                    Offstage(
                        offstage: !isEdit,
                        child: IconButton(
                            icon: Icon(Icons.photo_camera, color: Colors.white),
                            onPressed: () => choiceImage()))
                  ], alignment: Alignment.center),
                ),
                color: Theme.of(context).primaryColor),
            Divider(),
            SelectTextItem(
                leading: Icons.verified_user,
                title: '姓名',
                content: '${_data.getName()}',
                margin: EdgeInsets.only(left: 16.0, right: 8),
                onTap: isEdit
                    ? () => pushNewPage(
                            context,
                            InputTextPage(
                              title: '修改姓名',
                              content: '${_data.getName()}',
                              maxLines: 1,
                              maxLength: 5,
                            ), callBack: (value) {
                          _data.setUser(name: value);
                        })
                    : null,
                textAlign: TextAlign.right),
            Divider(),
            SelectTextItem(
                title: '邮箱',
                content: '${_data.getEmail()}',
                margin: EdgeInsets.only(left: 16.0, right: 8),
                onTap: isEdit
                    ? () => pushNewPage(
                            context,
                            InputTextPage(
                              title: '修改邮箱',
                              content: '${_data.getEmail()}',
                              maxLines: 1,
                              keyboardType: TextInputType.emailAddress,
                            ), callBack: (value) {
                          _data.setUser(email: value);
                        })
                    : null,
                textAlign: TextAlign.right),
            Divider(),
            Container(height: 1000)
          ]),
        ),
      );
    });
  }

  choiceImage() {
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(actions: <Widget>[
              CupertinoDialogAction(
                child: const Text('拍摄', style: TextStyles.textBlue16),
                onPressed: () {
                  fromCamera();
                },
              ),
              CupertinoDialogAction(
                child: const Text('从相册选择', style: TextStyles.textBlue16),
                onPressed: () {
                  fromGallery();
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
