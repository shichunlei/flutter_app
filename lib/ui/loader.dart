import 'package:flutter/material.dart';

import '../page_index.dart';

/// https://github.com/H-YKING/BeeUi/blob/master/lib/src/loader.dart
class LoaderContainer extends StatefulWidget {
  final LoaderState loaderState;
  final Widget loadingView;
  final Widget errorView;
  final Widget emptyView;
  final Widget contentView;
  final Function onReload;
  final String reloadText;
  final String errorTip;
  final String emptyTip;

  LoaderContainer(
      {Key key,
      @required this.contentView,
      this.emptyView,
      this.errorView,
      @required this.loaderState,
      this.loadingView,
      this.onReload,
      this.reloadText,
      this.errorTip,
      this.emptyTip})
      : super(key: key);

  @override
  createState() => _LoaderContainerState();
}

class _LoaderContainerState extends State<LoaderContainer> {
  @override
  Widget build(BuildContext context) {
    Widget currentWidget;
    switch (widget.loaderState) {
      case LoaderState.Loading:
        currentWidget = widget.loadingView ?? LoadingView();
        break;
      case LoaderState.Failed:
        currentWidget = widget.errorView ??
            _ClassicalErrorView(
                onReload: () => widget.onReload(),
                reloadText: widget.reloadText,
                errorTip: widget.errorTip);
        break;
      case LoaderState.NoData:
        currentWidget =
            widget.emptyView ?? _ClassicalNoDataView(emptyTip: widget.emptyTip);
        break;
      case LoaderState.Succeed:
      case LoaderState.NoAction:
        currentWidget = widget.contentView;
        break;
    }
    return currentWidget;
  }
}

class _ClassicalErrorView extends StatelessWidget {
  _ClassicalErrorView({@required this.onReload, this.reloadText, this.errorTip})
      : super();

  final Function onReload;
  final String reloadText;
  final String errorTip;

  @override
  Widget build(BuildContext context) => Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Icon(Icons.portable_wifi_off, size: 70, color: Colors.grey[500]),
            Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(errorTip ?? '亲的网络有点问题~',
                    style: TextStyle(fontSize: 12.0, color: Colors.grey[400]))),
            Padding(padding: EdgeInsets.only(bottom: 10)),
            Button(
              onPressed: onReload,
              height: 30,
              width: 110,
              halfRadius: true,
              child: Text(reloadText ?? '重新加载', style: TextStyle(fontSize: 14)),
            )
          ]));
}

class _ClassicalNoDataView extends StatelessWidget {
  final String emptyTip;

  _ClassicalNoDataView({this.emptyTip}) : super();

  @override
  Widget build(BuildContext context) => Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Icon(Icons.signal_cellular_no_sim,
                size: 70, color: Colors.grey[300]),
            Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(emptyTip ?? '暂无数据',
                    style: TextStyle(fontSize: 12.0, color: Colors.grey[400])))
          ]));
}
