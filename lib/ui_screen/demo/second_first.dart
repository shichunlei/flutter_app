import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/enum/enum.dart';
import 'package:flutter_app/ui/dialog.dart';
import 'package:flutter_app/ui/loader.dart';
import 'package:flutter_app/ui/state_view/loading.dart';
import 'package:flutter_app/utils/toast.dart';

import 'item_first.dart';
import 'item_list.dart';

class SecondFirstPage extends StatefulWidget {
  SecondFirstPage({Key key}) : super(key: key);

  @override
  createState() => _SecondFirstPageState();
}

class _SecondFirstPageState extends State<SecondFirstPage>
    with AutomaticKeepAliveClientMixin {
  bool showInfo = false;
  bool showLoading = false;

  LoaderState state = LoaderState.Loading;

  @override
  void initState() {
    super.initState();

    getData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  width: 100,
                  child: RaisedButton(
                    onPressed: () {},
                    child: Text('批量'),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: TextField(),
                  ),
                ),
              ],
            ),
          ),
          showInfo
              ? ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (BuildContext context, int index) {
                    return ItemFirst();
                  },
                  itemCount: 10,
                )
              : LoaderContainer(
                  contentView: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      primary: false,
                      padding: EdgeInsets.zero,
                      itemBuilder: (_, index) {
                        return ItemList(
                          onTap: () {
                            getServiceData();
                          },
                        );
                      },
                      itemCount: 10),
                  loaderState: state,
                  loadingView: Container(
                    height: 400,
                    child: LoadingView(),
                  ),
                ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  // 网络请求点击人名的数据
  void getServiceData() async {
    setState(() {
      // 显示loading
      showLoading = true;
    });
    showLoadingDialog(context, '加载中...');
    // 此处模拟网络请求
    Timer(
      const Duration(milliseconds: 3000),
      () {
        // 模拟请求成功
        Toast.show(context, '网络请求成功');
        setState(() {
          // 显示详情列表
          showInfo = true;
          // 隐藏loading
          if (showLoading) {
            showLoading = false;
            Navigator.pop(context);
          }
        });
      },
    );
  }

  void getData() async {
    Timer(const Duration(milliseconds: 3000), () {
      setState(() {
        state = LoaderState.Succeed;
      });
    });
  }
}
