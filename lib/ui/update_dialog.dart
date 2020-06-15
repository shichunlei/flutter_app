import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../page_index.dart';

class UpdateDialog extends StatefulWidget {
  final String url;
  final String savePath;

  UpdateDialog({Key key, @required this.url, @required this.savePath})
      : super(key: key);

  @override
  _UpdateDialogState createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  CancelToken _cancelToken = CancelToken();
  bool _isDownload = false;
  double _value = 0;

  @override
  void dispose() {
    if (!_cancelToken.isCancelled && _value != 1) {
      _cancelToken.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        /// 使用false禁止返回键返回，达到强制升级目的
        return true;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0)),
                width: 280.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                        height: 140.0,
                        width: 280.0,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: const Radius.circular(8.0),
                              topRight: const Radius.circular(8.0)),
                          image: DecorationImage(
                              image: AssetImage('images/update_head.jpg'),
                              fit: BoxFit.cover),
                        )),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text("新版本更新", style: TextStyles.textDark16),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        child: Text("1.添加追书神器板块。\n\n2.修改了一些BUG。\n\n3.代码做了一些优化",
                            style: TextStyles.textDark14)),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 15.0, left: 15.0, right: 15.0, top: 5.0),
                      child: _isDownload
                          ? LinearProgressIndicator(
                              backgroundColor: Colors.grey,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.lightBlue),
                              value: _value)
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 110.0,
                                  height: 36.0,
                                  child: FlatButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    textColor: Colors.lightBlue,
                                    color: Colors.transparent,
                                    disabledTextColor: Colors.white,
                                    disabledColor: Colors.grey,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: BorderSide(
                                            color: Colors.lightBlue,
                                            width: 0.8)),
                                    child: Text("残忍拒绝",
                                        style: TextStyles.textBlue16),
                                  ),
                                ),
                                Container(
                                  width: 110.0,
                                  height: 36.0,
                                  child: FlatButton(
                                    onPressed: () {
                                      if (defaultTargetPlatform ==
                                          TargetPlatform.iOS) {
                                        Navigator.of(context).pop();

                                        /// TODO 跳转到APP Store
                                      } else {
                                        setState(() {
                                          _isDownload = true;
                                        });
                                        _download(context, widget.url,
                                            widget.savePath);
                                      }
                                    },
                                    textColor: Colors.white,
                                    color: Colors.lightBlue,
                                    disabledTextColor: Colors.white,
                                    disabledColor: Colors.grey,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                    child: Text("立即更新",
                                        style: TextStyles.textWhite16),
                                  ),
                                )
                              ],
                            ),
                    )
                  ],
                )),
          )),
    );
  }

  /// 下载apk
  _download(BuildContext context, String url, String savePath) async {
    debugPrint("---------------$savePath");

    try {
      HttpUtils().download(url, savePath,
          onReceiveProgress: (int count, int total) async {
        setState(() => _value = count / total);

        if (count == total) {
          Navigator.of(context).pop();

          /// VersionUtils.install(savePath);
          showInstallDialog(savePath.toString());
        }
      }, cancelToken: _cancelToken);
    } catch (e) {
      Toast.show(context, "下载失败!");
      debugPrint(e.toString());
    }
  }

  void showInstallDialog(String savePath) async {
    showDiffDialog(context,
        title: Text('安装提示'),
        titlePadding: EdgeInsets.all(20),
        content: Text('$savePath\n你是否安装该APP'),
        contentPadding: EdgeInsets.only(left: 20, right: 20), pressed: () {
      /// TODO 进行安装操作
      Navigator.of(context).pop();
    }, yesText: "安装");
  }
}
