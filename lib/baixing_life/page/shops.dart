import 'package:flutter/material.dart';
import 'package:flutter_app/page_index.dart';

import '../index.dart';

class ShopsPage extends StatefulWidget {
  const ShopsPage({Key key}) : super(key: key);

  @override
  createState() => _ShopsPageState();
}

class _ShopsPageState extends State<ShopsPage> {
  LoaderState state = LoaderState.Loading;

  List<ShopInfo> shops = [];

  @override
  void initState() {
    super.initState();

    getShopsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(title: Text('百姓生活+ 门店')),
        body: LoaderContainer(
            contentView: ListView.separated(
                itemBuilder: (_, index) => InkWell(
                    onTap: () => pushNewPage(
                        context,
                        ShopInfoPage(
                            name: shops[index].shopName,
                            id: shops[index].shopID)),
                    child: Container(
                        child: Image.network('${shops[index].shopImage}',
                            fit: BoxFit.fitWidth))),
                separatorBuilder: (_, index) => Gaps.vGap5,
                itemCount: shops.length),
            loaderState: state));
  }

  void getShopsData() async {
    shops = await ApiService.getBaixingShops();

    if (mounted) {
      setState(() {
        state = LoaderState.Succeed;
      });
    }
  }
}
