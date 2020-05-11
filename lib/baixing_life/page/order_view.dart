import 'package:flutter/material.dart';
import 'package:flutter_app/baixing_life/ui/item_order.dart';

import 'package:flutter_app/page_index.dart';
import 'package:flutter_app/store/index.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';

class OrderPage extends StatefulWidget {
  final int state;

  const OrderPage({Key key, @required this.state}) : super(key: key);

  @override
  createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage>
    with AutomaticKeepAliveClientMixin {
  LoaderState _state = LoaderState.Loading;

  List<OrderBean> orders = [];

  int page = 1;

  bool isLoadComplete = false;

  @override
  void initState() {
    super.initState();

    getOrderData(widget.state, page, RefreshType.DEFAULT);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: LoaderContainer(
            contentView: EasyRefresh(
                emptyWidget: orders.length > 0
                    ? null
                    : EmptyPage(
                        onPresses: () {
                          Store.value<BaixingModel>(context, listen: false)
                              .setPageIndex(0);
                          Navigator.maybePop(context);
                        },
                        pressText: '随便逛逛'),
                header: MaterialHeader(),
                footer: BallPulseFooter(),
                onRefresh: () async {
                  page = 1;
                  getOrderData(widget.state, page, RefreshType.REFRESH);
                },
                onLoad: isLoadComplete
                    ? null
                    : () async {
                        page++;
                        getOrderData(widget.state, page, RefreshType.LOAD_MORE);
                      },
                child: ListView.builder(
                    itemBuilder: (_, index) => ItemOrder(order: orders[index]),
                    itemCount: orders.length)),
            loaderState: _state));
  }

  @override
  bool get wantKeepAlive => true;

  void getOrderData(int state, int page, RefreshType type) async {
    List<OrderBean> list =
        await ApiService.getBaixingOrders(page: page, state: state);

    if (type == RefreshType.REFRESH || type == RefreshType.DEFAULT) {
      isLoadComplete = false;
      orders.clear();
    }

    if (list.length > 0) {
      orders.addAll(list);
    }

    if (mounted)
      setState(() {
        _state = LoaderState.Succeed;
      });
  }
}
