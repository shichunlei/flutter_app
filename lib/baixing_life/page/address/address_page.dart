import 'package:flutter/material.dart';
import 'package:flutter_app/baixing_life/db/address_provider.dart';
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
  AddressProvider addressProvider;

  bool isEmpty = false;

  @override
  void initState() {
    super.initState();

    addressProvider = AddressProvider();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
            title: Text('${AppLocalizations.$t('address')}'),
            elevation: 0,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => pushNewPage(
                      context,
                      CreateEditAddressPage(
                          title: '${AppLocalizations.$t('create_address')}',
                          addressProvider: addressProvider)))
            ]),
        body: _builderBodyView());
  }

  Future _getAddresses(BuildContext context) async {
    await Store.value<AddressModel>(context).$getAddresses(addressProvider);

    return '${AppLocalizations.$t('success')}';
  }

  Widget _builderBodyView() {
    return FutureBuilder(
        future: _getAddresses(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Provide<AddressModel>(builder: (context, child, value) {
              List addresses = Store.value<AddressModel>(context).addresses;

              if (addresses.length > 0) {
                isEmpty = false;
              } else {
                isEmpty = true;
              }

              return addresses.length > 0
                  ? ListView.separated(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.only(top: 8, bottom: 8),
                      itemBuilder: (context, index) => ItemAddress(
                          address: addresses[index],
                          addressProvider: addressProvider),
                      separatorBuilder: (BuildContext context, int index) =>
                          Container(height: 5, color: Colors.grey[200]),
                      itemCount: addresses.length)
                  : isEmpty
                      ? EmptyPage(
                          text: '暂无收货地址', imageAsset: 'images/empty.jpeg')
                      : getLoadingWidget();
            });
          } else {
            return EmptyPage(text: '暂无收货地址', imageAsset: 'images/empty.jpeg');
          }
        });
  }
}
