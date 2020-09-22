import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'base_model.dart';

class ProviderStatelessWidget<T extends BaseModel> extends StatelessWidget {
  final ValueWidgetBuilder<T> builder;
  final T model;
  final Widget child;

  ProviderStatelessWidget({
    Key key,
    @required this.builder,
    @required this.model,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    model.setContext(context);
    return ChangeNotifierProvider<T>.value(
        value: model, child: Consumer<T>(builder: builder, child: child));
  }
}
