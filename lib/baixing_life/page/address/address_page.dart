import 'package:flutter/material.dart';
import 'package:flutter_app/baixing_life/db/address_provider.dart';
import 'package:flutter_app/bean/address.dart';

import '../../../page_index.dart';
import 'create_edit_address_page.dart';
import 'item_address.dart';

class AddressPage extends StatefulWidget {
  AddressPage({Key key}) : super(key: key);

  @override
  createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  AddressProvider addressProvider;

  List<Address> addresses = [];

  bool isEmpty = false;

  @override
  void initState() {
    super.initState();

    addressProvider = AddressProvider();

    getAddresses();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(title: Text('收货地址'), elevation: 0, actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () => pushNewPage(
                  context,
                  CreateEditAddressPage(
                      title: '新增地址', addressProvider: addressProvider)))
        ]),
        body: _builderBodyView());
  }

  void getAddresses() async {
    addresses = await addressProvider.getAddressList();

    setState(() {
      if (addresses.length > 0) {
        isEmpty = false;
      } else {
        isEmpty = true;
      }
    });
  }

  Widget _builderBodyView() {
    return addresses.length > 0
        ? ListView.separated(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(top: 8, bottom: 8),
            itemBuilder: (context, index) => ItemAddress(
                address: addresses[index], addressProvider: addressProvider),
            separatorBuilder: (BuildContext context, int index) =>
                Container(height: 5, color: Colors.grey[200]),
            itemCount: addresses.length)
        : isEmpty
            ? EmptyPage(text: '暂无收货地址', imageAsset: 'images/empty.jpeg')
            : getLoadingWidget();
  }
}
