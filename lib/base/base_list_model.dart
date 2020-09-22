import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'base_model.dart';

abstract class BaseListModel<T> extends BaseModel {
  int pageNumber = 1;
  int _pageSize = 10;

  void setPageSize(int pageSize) {
    this._pageSize = pageSize;
    notifyListeners();
  }

  List<T> list = [];

  EasyRefreshController _easyRefreshController = EasyRefreshController();

  EasyRefreshController get easyRefreshController => _easyRefreshController;

  initData() async {
    setBusy();
    await refresh(init: true);
  }

  Future<List<T>> reLoadData() async {
    try {
      var data = await loadData();
      if (data.isEmpty) {
        list.clear();
        setEmpty();
      } else {
        list.clear();
        list.addAll(data);
        onCompleted(data);
        setIdle();
      }
      return data;
    } catch (e, s) {
      setError(e, s);
      onError();
      return null;
    }
  }

  /// 下拉刷新
  /// [init] 是否是第一次加载
  /// true:  Error时,需要跳转页面
  /// false: Error时,不需要跳转页面,直接给出提示
  Future<List<T>> refresh({bool init = false}) async {
    try {
      pageNumber = 1;
      var data = await loadData();
      if (data.isEmpty) {
        /// 重置加载状态
        easyRefreshController.resetLoadState();

        /// 完成刷新
        easyRefreshController.finishRefresh();
        list.clear();
        setEmpty();
      } else {
        list.clear();
        list.addAll(data);
        // 小于分页的数量,禁止上拉加载更多
        if (data.length < _pageSize) {
          /// 完成加载、没有数据了
          easyRefreshController.finishLoad(noMore: true);
        } else {
          /// 防止上次上拉加载更多失败,需要重置状态
          easyRefreshController.finishRefresh();
        }
        easyRefreshController.finishRefresh();
        onCompleted(data);
        setIdle();
      }
      notifyListeners();
      return data;
    } catch (e, s) {
      /// 页面已经加载了数据,如果刷新报错,不应该直接跳转错误页面
      /// 而是显示之前的页面数据.给出错误提示
      if (init) list.clear();
      easyRefreshController.finishRefresh(success: false);
      setError(e, s);
      onError();
      return null;
    }
  }

  /// 上拉加载更多
  Future<List<T>> loadMore() async {
    try {
      pageNumber++;
      if (list.length < _pageSize) {
        easyRefreshController.finishLoad(noMore: true);

        return [];
      }
      var data = await loadData();
      if (data.isEmpty) {
        pageNumber = pageNumber - 1;
        easyRefreshController.finishLoad(noMore: true);
      } else {
        onCompleted(data);
        list.addAll(data);
        if (data.length < _pageSize) {
          easyRefreshController.finishLoad(noMore: true);
        } else {
          easyRefreshController.finishLoad();
        }
      }
      notifyListeners();
      return data;
    } catch (e, s) {
      pageNumber = pageNumber - 1;
      easyRefreshController.finishLoad(success: false);
      setError(e, s);
      onError();
      return [];
    }
  }

  // 加载数据
  Future<List<T>> loadData();

  onCompleted(List<T> data) {}

  onError() {}

  @override
  void dispose() {
    easyRefreshController?.dispose();
    super.dispose();
  }
}
