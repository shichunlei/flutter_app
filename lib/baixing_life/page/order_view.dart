import 'package:flutter/material.dart';
import 'package:flutter_app/baixing_life/ui/item_order.dart';
import 'package:flutter_app/bean/baixing.dart';
import 'package:flutter_app/page_index.dart';
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: LoaderContainer(
            contentView: EasyRefresh(
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
                    itemBuilder: (_, index) {
                      return ItemOrder(order: orders[index]);
                    },
                    itemCount: orders.length)),
            loaderState: _state));
  }

  @override
  bool get wantKeepAlive => true;

  void getOrderData(int state, int page, RefreshType type) async {
    List<OrderBean> list =
        await ApiService.getBaixingOrders(page: page, state: state);

    if (type == RefreshType.REFRESH || type == RefreshType.DEFAULT) {
      if (list.length == 0) {
        _state = LoaderState.NoData;
      } else {
        isLoadComplete = false;
        orders.clear();
      }
    }

    if (list.length > 0) {
      orders.addAll(list);
      _state = LoaderState.Succeed;
    }

    if (mounted) setState(() {});
  }
}
