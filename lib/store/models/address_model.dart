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

  Future<void> $fetchData() async {
    this._addresses = await provider.getAddressList();

    notifyListeners();
  }

  List<Address> get addresses => _addresses;

  Future<void> $changeAddresses() async {
    $fetchData();
  }

  /// 新建或修改地址
  ///
  Future<void> $insertOrReplaceAddress(
      BuildContext context, Address address, String title) async {
    int success = await provider.insertOrReplaceToDB(address);

    if (success > 0) {
      Toast.show(context, '$title${S.of(context).success}！');

      Navigator.of(context).pop();
    } else {
      Toast.show(context, '$title${S.of(context).fail}！');
    }
  }

  /// 设置默认地址
  ///
  Future<void> $updateAddressDefault(
      BuildContext context, int id, bool isDefault) async {
    bool success = await provider.updateAddressDefault(id, isDefault);

    if (success) {
      Toast.show(context, '设置成功');
      $changeAddresses();
    } else {
      Toast.show(context, '设置失败');
    }
  }

  /// 删除地址
  ///
  Future<void> $deleteAddress(BuildContext context, int id) async {
    int success = await provider.deleteAddress(id);

    if (success == 1) {
      Toast.show(context, '删除成功');

      $changeAddresses();
    } else {
      Toast.show(context, '删除失败');
    }

    Navigator.of(context).pop();
  }
}
