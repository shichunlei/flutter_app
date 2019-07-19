import 'package:flutter/material.dart';
import '../../baixing_life/db/address_provider.dart';
import '../../bean/address.dart';

class AddressModel with ChangeNotifier {
  List<Address> _addresses = [];

  AddressProvider provider;

  AddressModel() {
    provider = AddressProvider();
  }

  Future<void> $getAddresses() async {
    this._addresses = await provider.getAddressList();

    notifyListeners();
  }

  List<Address> get addresses => _addresses;

  Future $changeAddresses() async {
    $getAddresses();
  }
}
