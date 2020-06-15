import 'package:flutter/material.dart';
import 'package:flutter_app/store/index.dart';
import 'package:flutter_app/generated/i18n.dart';

import '../../../page_index.dart';
import '../../index.dart';

class AddressPage extends StatelessWidget {
  AddressPage({Key key}) : super(key: key);

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
                          title: '${S.of(context).create_address}')))
            ]),
        body: FutureBuilder(
          future: Store.value<AddressModel>(context).getAddresses(),
          builder: (_, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text('Press button to start.');
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Center(child: LoadingWidget());
              case ConnectionState.done:
                if (snapshot.hasError) {
                  debugPrint(snapshot.error);
                  return ErrorPage();
                }

                List<Address> items = snapshot.data;

                if (items == null || items.length == 0) {
                  return EmptyPage();
                }

                return ListView.separated(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    itemBuilder: (context, index) =>
                        ItemAddress(address: items[index]),
                    separatorBuilder: (_, int index) =>
                        Container(height: 5, color: Colors.grey[200]),
                    itemCount: items.length);
            }
            return null;
          },
        ));
  }
}
