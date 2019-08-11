import 'package:flutter/material.dart';
import 'package:provide/provide.dart'
    show
        Provider,
        Provide,
        ProviderNode,
        Providers,
        ProvideMulti,
        ProviderScope;

import 'models/address_model.dart';
import 'models/config_state_model.dart';

class Store {
  static dynamic storeCtx;
  static dynamic widgetCtx;

  static init({model, child, dispose = true}) {
    final providers = Providers()
      ..provide(Provider.value(ConfigModel()))
      ..provide(Provider.value(AddressModel()));

    return ProviderNode(child: child, providers: providers, dispose: dispose);
  }

  /// 设置数据层上下文
  static setStoreCtx(context) {
    storeCtx = context;
  }

  /// 设置Widget上下文
  static setWidgetCtx(context) {
    widgetCtx = context;
  }

  /// 获取
  static T valueNotCtx<T>() {
    return Provide.value<T>(storeCtx);
  }

  /// 根据 Context 获取
  static T value<T>(context, {scope}) {
    return Provide.value<T>(context, scope: scope);
  }

  /// 监听
  static connect<T>({builder, child, scope}) {
    return Provide<T>(
      builder: builder,
      child: child,
      scope: scope,
    );
  }

  /// 通过流的方式 监听
  static stream<T>({builder, model, context}) {
    return StreamBuilder<T>(
        initialData: model,
        stream: Provide.stream<T>(context),
        builder: builder);
  }

  /// 链接多个类型
  static multi(
      {builder,
      child,
      List<Type> requestedValues,
      Map<ProviderScope, List<Type>> requestedScopedValues}) {
    return ProvideMulti(
        builder: builder,
        child: child,
        requestedValues: requestedValues,
        requestedScopedValues: requestedScopedValues);
  }
}
