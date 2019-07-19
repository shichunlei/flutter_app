import 'package:flutter/material.dart';
import 'package:flutter_app/generated/i18n.dart';
import '../../baixing_life/db/address_provider.dart';
import '../../bean/address.dart';
import '../../page_index.dart';

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

  Future<void> $changeAddresses() async {
    $getAddresses();
  }

  /// 新建或修改地址
  ///
  Future<void> $insertOrReplaceAddress(
      BuildContext context, Address address, String title) async {
    int success = await provider.insertOrReplaceToDB(address);

    if (success > 0) {
      Toast.show('$title${S.of(context).success}！', context);

      $changeAddresses();
      Navigator.of(context).pop();
    } else {
      Toast.show('$title${S.of(context).fail}！', context);
    }
  }

  /// 设置默认地址
  ///
  Future<void> $updateAddressDefault(
      BuildContext context, int id, bool isDefault) async {
    bool success = await provider.updateAddressDefault(id, isDefault);

    if (success) {
      Toast.show('设置成功', context);
      $changeAddresses();
    } else {
      Toast.show('设置失败', context);
    }
  }

  /// 删除地址
  ///
  Future<void> $deleteAddress(BuildContext context, int id) async {
    int success = await provider.deleteAddress(id);

    if (success == 1) {
      Toast.show('删除成功', context);

      $changeAddresses();
    } else {
      Toast.show('删除失败', context);
    }

    Navigator.of(context).pop();
  }
}
