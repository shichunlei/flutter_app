import 'package:flutter/material.dart';
import '../../baixing_life/db/address_provider.dart';
import '../../bean/address.dart';

import '../../page_index.dart';

class AddressModel with ChangeNotifier {
  List<Address> addresses = [];

  Future $getAddresses(AddressProvider provider) async {
    addresses = await provider.getAddressList();

    LogUtil.v('$addresses');
    $setAddress(addresses);
  }

  Future $changeAddresses(AddressProvider provider) async {
    $getAddresses(provider);
  }

  Future $setAddress(List<Address> addresses) async {
    this.addresses = addresses;
    notifyListeners();
  }
}
