import 'package:flutter/material.dart';
import 'package:flutter_app/baixing_life/db/address_provider.dart';
import 'package:flutter_app/bean/address.dart';
import 'package:flutter_app/generated/i18n.dart';

import '../../../page_index.dart';
import 'create_edit_address_page.dart';
import 'item_address.dart';

class AddressPage extends StatefulWidget {
  AddressPage({Key key}) : super(key: key);

  @override
  createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  AddressProvider provider;

  @override
  void initState() {
    super.initState();

    provider = AddressProvider();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
            title: Text('${S.of(context).address}'),
            elevation: 0,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => pushNewPage(
                      context,
                      CreateEditAddressPage(
                          title: '${S.of(context).create_address}',
                          addressProvider: provider)))
            ]),
        body: FutureBuilder<List<Address>>(
            future: fetchAddress(),
            builder: (_, AsyncSnapshot<List<Address>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  debugPrint('none');
                  return Text('');
                case ConnectionState.waiting:
                  debugPrint('waiting');
                  return getLoadingWidget();
                case ConnectionState.done:
                  debugPrint('done');
                  if (snapshot.hasError) {
                    debugPrint(snapshot.error.toString());
                    return ErrorPage(text: '网络请求错误');
                  } else {
                    debugPrint('${snapshot.data.length}');
                    if (snapshot.data.length > 0) {
                      return ListView.separated(
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          itemBuilder: (context, index) => ItemAddress(
                              address: snapshot.data[index],
                              addressProvider: provider),
                          separatorBuilder: (BuildContext context, int index) =>
                              Container(height: 5, color: Colors.grey[200]),
                          itemCount: snapshot.data.length);
                    }
                    return EmptyPage(
                        text: '暂无收货地址', imageAsset: 'images/empty.jpeg');
                  }
                  break;
                default:
                  return EmptyPage(
                      text: '暂无收货地址', imageAsset: 'images/empty.jpeg');
              }
            }));
  }

  Future<List<Address>> fetchAddress() async {
    return await provider.getAddressList();
  }
}
