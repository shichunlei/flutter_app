import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/store/index.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../page_index.dart';

/// 根据Android或IOS显示不同风格dialog
///
Future<Null> showDiffDialog(BuildContext context,
    {Widget title,
    Widget content,
    String yesText,
    String noText,
    EdgeInsetsGeometry titlePadding,
    EdgeInsetsGeometry contentPadding =
        const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
    Function pressed,
    Function cancelPressed}) async {
  await showDialog(
      context: context,
      builder: (context) => Utils.isAndroid
          ? AlertDialog(
              title: title,
              titlePadding: titlePadding,
              content: content,
              contentPadding: contentPadding,
              actions: <Widget>[
                  FlatButton(
                    onPressed: cancelPressed ?? () => Navigator.pop(context),
                    child: Text(noText ??= S.of(context).cancel),
                  ),
                  FlatButton(
                      onPressed: () => pressed(),
                      child: Text(yesText ??= S.of(context).sure))
                ])
          : CupertinoAlertDialog(
              title: title,
              content: Padding(
                  padding: const EdgeInsets.only(top: 20.0), child: content),
              actions: <Widget>[
                  CupertinoDialogAction(
                      onPressed: cancelPressed ?? () => Navigator.pop(context),
                      child: Text(noText ??= S.of(context).cancel)),
                  CupertinoDialogAction(
                      onPressed: () => pressed(),
                      child: Text(yesText ??= S.of(context).sure))
                ]));
}

/// 歌曲播放列表
///
/// [context] 上下文
///
void showMusicListBottomSheet(BuildContext context) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (BuildContext context) => Store.connect<MusicModel>(
          builder: (_, MusicModel snapshot, __) => Container(
              height: Utils.height * 2 / 3,
              child: Column(children: <Widget>[
                Container(
                    padding: EdgeInsets.all(10.0),
                    child: Row(children: <Widget>[
                      Icon(snapshot.modeIcon),
                      Gaps.hGap10,
                      RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(children: [
                            TextSpan(
                                text: snapshot.mode == 0
                                    ? '顺序播放'
                                    : snapshot.mode == 1 ? "随机播放" : "单曲循环",
                                style: TextStyles.textBlue16),
                            TextSpan(
                                text: '（共${snapshot.allSongs.length}首）',
                                style: TextStyles.textBlue14)
                          ]))
                    ])),
                Container(height: 1, color: Colors.grey),
                Expanded(
                    child: ListView.separated(
                        itemBuilder: (_, index) {
                          bool isPlaying = snapshot.curIndex == index;
                          return ListTile(
                              leading: ImageLoadView(
                                  '${snapshot.allSongs[index].albumArtUrl}',
                                  width: isPlaying ? 50 : 40,
                                  height: isPlaying ? 50 : 40,
                                  shape: BoxShape.circle,
                                  child: isPlaying
                                      ? Container(
                                          width: isPlaying ? 50 : 40,
                                          height: isPlaying ? 50 : 40,
                                          child: CircularProgressIndicator(
                                              value: snapshot.progress,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Colors.redAccent)))
                                      : null),
                              title: Text('${snapshot.allSongs[index].title}',
                                  maxLines: 1),
                              subtitle: Text(
                                  '${snapshot.allSongs[index].artists}',
                                  maxLines: 1),
                              onTap: () {
                                Navigator.pop(context);
                                snapshot.playSongByIndex(index);
                              },
                              selected: isPlaying);
                        },
                        itemCount: snapshot.allSongs.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            Container(height: 0.1, color: Colors.grey)))
              ]))));
}

showLoginDialog(BuildContext context) async {
  showDialog<Null>(
      context: context, //BuildContext对象
      barrierDismissible: false,
      builder: (BuildContext context) => LoginDialog());
}

class LoginDialog extends Dialog {
  LoginDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
            Widget>[
          Container(
              width: 320,
              height: 430,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              child: OverflowBox(
                  alignment: Alignment.bottomCenter,
                  maxHeight: 515,
                  child: Stack(
                      alignment: AlignmentDirectional.topCenter,
                      children: <Widget>[
                        Positioned(
                            child: ImageLoadView(
                                'https://raw.githubusercontent.com/yukilzw/dy_flutter/master/images/login/syn.webp',
                                height: 180.0,
                                fit: BoxFit.fitHeight)),
                        Positioned(
                            top: 170,
                            left: 30,
                            child: Text('登录',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30))),
                        Positioned(top: 100, right: 15, child: CloseButton()),
                        Padding(
                            padding:
                                EdgeInsets.only(left: 30, right: 30, top: 230),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Button(
                                      child: Text('账号登录',
                                          style: TextStyle(fontSize: 18)),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      borderRadius: 5,
                                      color: Color(0xffff5d23)),
                                  Padding(
                                      padding:
                                          EdgeInsets.only(top: 20, bottom: 15),
                                      child: Button(
                                          child: Text('快速注册',
                                              style: TextStyle(fontSize: 18)),
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          borderRadius: 5,
                                          borderColor: Color(0xffff5d23),
                                          textColor: Color(0xffff5d23),
                                          buttonShape: ButtonShape.OUTLINE)),
                                  RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                              color: grey9Color,
                                              fontSize: 12,
                                              height: 1.2),
                                          children: [
                                        TextSpan(text: '使用即为同意'),
                                        TextSpan(
                                            text: '《隐私权政策》',
                                            style: TextStyle(
                                                color: Color(0xffff7701))),
                                        TextSpan(text: '、'),
                                        TextSpan(
                                            text: '《用户注册协议》',
                                            style: TextStyle(
                                                color: Color(0xffff7701))),
                                        TextSpan(text: '和'),
                                        TextSpan(
                                            text: '《用户阳光行为准则》',
                                            style: TextStyle(
                                                color: Color(0xffff7701)))
                                      ])),
                                  LineViewLine(
                                      lineColor: Colors.black26,
                                      child: Text('快速登录',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Color(0xff707070))),
                                      horizontalPadding: 40.0,
                                      verticalPadding: 20.0,
                                      lineHeight: 2.0),
                                  Material(
                                      type: MaterialType.transparency,
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            IconButton(
                                                icon: Icon(FontAwesome.weixin),
                                                onPressed: () {}),
                                            IconButton(
                                                icon: Icon(FontAwesome.qq),
                                                onPressed: () {}),
                                            IconButton(
                                                icon: Icon(FontAwesome.weibo),
                                                onPressed: () {})
                                          ]))
                                ]))
                      ])))
        ]));
  }
}

showLoadingDialog(BuildContext context, String text) async {
  showDialog<Null>(
      context: context, //BuildContext对象
      barrierDismissible: false,
      builder: (BuildContext context) => LoadingDialog(text: text));
}

class LoadingDialog extends Dialog {
  final String text;

  LoadingDialog({
    Key key,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      LoadingWidget(text: text, bgColor: Colors.white);
}

class LoadingWidget extends StatelessWidget {
  LoadingWidget({
    Key key,
    this.text: '加载中...',
    this.bgColor: const Color(0x4b000000),
  }) : super(key: key);

  final String text;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    int index = Random().nextInt(loadingWidgets.length - 1);

    return Material(
        type: MaterialType.transparency,
        child: Center(
            child: Container(
                width: 120.0,
                height: 120.0,
                decoration: ShapeDecoration(
                    color: bgColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)))),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(child: loadingWidgets[index]),
                      Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: Text(text, style: TextStyles.textGrey12))
                    ]))));
  }
}
