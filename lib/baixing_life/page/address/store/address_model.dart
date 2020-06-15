import 'package:flutter/material.dart';

import '../../../../generated/i18n.dart';
import '../../../../page_index.dart';
import '../../../index.dart';

class AddressModel extends ChangeNotifier {
  List<Address> _addresses = [];

  AddressProvider addressProvider;

  AddressModel() {
    addressProvider = AddressProvider();
  }

  /// 获取地址
  Future<List<Address>> getAddresses() async {
    _addresses = await addressProvider.getAddressList();
    debugPrint('===========================getAddresses');
    return _addresses;
  }

  /// 新建或修改地址
  ///
  Future<void> insertOrReplaceAddress(
      BuildContext context, Address address, String title) async {
    int success = await addressProvider.insertOrReplaceToDB(address);

    if (success > 0) {
      Toast.show(context, '$title${S.of(context).success}！');

      getAddresses();
      refresh();
      Navigator.of(context).pop();
    } else {
      Toast.show(context, '$title${S.of(context).fail}！');
    }
  }

  /// 设置默认地址
  ///
  Future<void> updateAddressDefault(
      BuildContext context, int id, bool isDefault) async {
    bool success = await addressProvider.updateAddressDefault(id, isDefault);

    if (success) {
      Toast.show(context, '设置成功');
      getAddresses();
      refresh();
    } else {
      Toast.show(context, '设置失败');
    }
  }

  /// 删除地址
  ///
  Future<void> deleteAddress(BuildContext context, int id) async {
    int success = await addressProvider.deleteAddress(id);

    if (success == 1) {
      Toast.show(context, '删除成功');

      getAddresses();
      refresh();
    } else {
      Toast.show(context, '删除失败');
    }

    Navigator.of(context).pop();
  }

  Address _address;

  get address => _address;

  /// 根据ID得到地址
  ///
  Future<Address> getAddress(int id) async {
    if (id == -1) {
      _address = Address(
          name: "",
          phone: "",
          isDefault: false,
          zipCode: "",
          tag: "",
          address: "",
          province: "",
          city: "",
          county: "");
    } else {
      _address = await addressProvider.getAddress(id);
    }

    return _address;
  }

  void refresh() {
    notifyListeners();
  }
}
