import 'package:flutter/material.dart';
import 'package:flutter_app/baixing_life/db/address_provider.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:flutter_app/store/models/address_model.dart';
import 'package:provide/provide.dart';

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
        body: FutureBuilder<String>(
            future: _fetchAddress(),
            builder: (_, AsyncSnapshot<String> snapshot) {
              if (ConnectionState.waiting == snapshot.connectionState) {
                return getLoadingWidget();
              } else if (ConnectionState.done == snapshot.connectionState) {
                return Provide<AddressModel>(builder: (context, child, value) {
                  if (value.addresses.length > 0) {
                    return ListView.separated(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.only(top: 8, bottom: 8),
                        itemBuilder: (context, index) => ItemAddress(
                            address: value.addresses[index],
                            addressProvider: provider),
                        separatorBuilder: (_, int index) =>
                            Container(height: 5, color: Colors.grey[200]),
                        itemCount: value.addresses.length);
                  } else {
                    return EmptyPage(
                        text: '暂无收货地址', imageAsset: 'images/empty.jpeg');
                  }
                });
              } else {
                return null;
              }
            }));
  }

  Future<String> _fetchAddress() async {
    await Store.value<AddressModel>(context).$fetchData();

    return '${S.of(context).success}';
  }
}
