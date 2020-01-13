import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/ui/state_view/error.dart';
import 'package:flutter_app/ui/state_view/loading.dart';

import 'state.dart';
import 'loading_dialog.dart';

typedef GlobalContentBuilder<T> = Widget Function(
    BuildContext buildContext, T t);

class MultiStateWidget<T> extends StatefulWidget {
  final Widget loading;
  final Widget error;

  final GlobalContentBuilder builder;

  final StreamController<BaseState> controller;

  MultiStateWidget({
    Key key,
    this.error,
    this.loading,
    @required this.builder,
    @required this.controller,
  })  : assert(builder != null || controller != null),
        super(key: key);

  @override
  createState() => _MultiStateWidgetState<T>();
}

class _MultiStateWidgetState<T> extends State<MultiStateWidget> {
  HideDialogCallBack hideDialogCallBack;

  Widget lastWidget;

  @override
  void initState() {
    super.initState();
  }

  void hideDialog() {
    if (hideDialogCallBack != null) {
      hideDialogCallBack();
      hideDialogCallBack = null;
    }
  }

  @override
  void dispose() {
    hideDialog();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<BaseState>(
        stream: widget.controller.stream,
        builder: (context, snap) {
          Widget result;
          if (snap.data != null) {
            if (snap.data is LoadingState) {
              result = LoadingView();
            } else if (snap.data is ErrorState) {
              hideDialog();
              result = ErrorPage();
            } else if (snap.data is ShowDialogState) {
              Future.microtask(() {
                hideDialogCallBack = LoadingDialog.showDialog(context);
              });

              if (lastWidget != null) {
                result = lastWidget;
              }
            } else if (snap.data is HideDialogState) {
              hideDialog();
              if (lastWidget != null) {
                result = lastWidget;
              }
            } else if (snap.data is ContentState) {
              hideDialog();
              result = widget.builder(context, (snap.data as ContentState).t);
            }
          }

          if (result == null) {
            result = SizedBox();
          }

          return lastWidget = result;
        },
      ),
    );
  }
}
