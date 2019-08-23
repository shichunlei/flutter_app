import 'package:flutter/material.dart';
import 'package:flutter_app/store/index.dart';
import 'package:flutter_app/generated/i18n.dart';

import '../../../page_index.dart';
import '../../index.dart';

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
        body: Store.connect<AddressModel>(builder:
            (BuildContext context, AddressModel snapshot, Widget child) {
          return LoaderContainer(
              loaderState: snapshot.status,
              contentView: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.only(top: 8, bottom: 8),
                  itemBuilder: (context, index) => ItemAddress(
                      address: snapshot.addresses[index],
                      addressProvider: provider),
                  separatorBuilder: (_, int index) =>
                      Container(height: 5, color: Colors.grey[200]),
                  itemCount: snapshot.addresses.length));
        }));
  }
}
