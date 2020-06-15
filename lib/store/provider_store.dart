import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import 'index.dart';

class Store {
  //  初始化
  static init({Widget child}) {
    /// 返回多个状态
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AddressModel()),
        ChangeNotifierProvider(create: (_) => ConfigModel()..init()),
        ChangeNotifierProvider(create: (_) => UserModel()),
        ChangeNotifierProvider(create: (_) => ArticleModel()),
        ChangeNotifierProvider(create: (_) => ReaderSettingModel()),
        ChangeNotifierProvider(create: (_) => BookModel()),
        ChangeNotifierProvider(create: (_) => MusicModel()..init()),
        ChangeNotifierProvider(create: (_) => SongListModel()),
        ChangeNotifierProvider(
            create: (_) => ShoppingCartModel()..refreshCartProducts()),
        ChangeNotifierProvider(
            create: (BuildContext context) => WeatherModel()),
        ChangeNotifierProvider(create: (BuildContext context) => BaixingModel())
      ],
      child: child,
    );
  }

  //  通过Provider.value<T>(context)获取状态数据
  static T value<T>(BuildContext context, {bool listen: true}) {
    return Provider.of<T>(context, listen: listen);
  }

  //  通过Consumer获取状态数据
  static Consumer connect<T>(
      {Function(BuildContext context, T value, Widget child) builder,
      Widget child}) {
    return Consumer<T>(builder: builder, child: child);
  }

  //  通过Consumer获取状态数据
  static Consumer2 connect2<A, B>(
      {Function(BuildContext context, A value, B value2, Widget child) builder,
      Widget child}) {
    return Consumer2<A, B>(builder: builder, child: child);
  }
}
