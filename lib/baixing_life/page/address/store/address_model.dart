import 'package:flutter/material.dart';

import '../../../../generated/i18n.dart';
import '../../../../page_index.dart';
import '../../../index.dart';

class AddressModel extends ChangeNotifier {
  List<Address> _addresses = [];

  LoaderState _status = LoaderState.Loading;

  AddressProvider provider;

  AddressModel() {
    provider = AddressProvider();

    getAddresses();
  }

  get status => _status;

  List<Address> get addresses => _addresses;

  getAddresses() async {
    _addresses = await provider.getAddressList();
    if (_addresses.length > 0) {
      _status = LoaderState.Succeed;
    } else {
      _status = LoaderState.NoData;
    }
    debugPrint('===========================getAddresses');
    notifyListeners();
  }

  /// 新建或修改地址
  ///
  insertOrReplaceAddress(
      BuildContext context, Address address, String title) async {
    int success = await provider.insertOrReplaceToDB(address);

    if (success > 0) {
      Toast.show(context, '$title${S.of(context).success}！');

      getAddresses();
      Navigator.of(context).pop();
    } else {
      Toast.show(context, '$title${S.of(context).fail}！');
    }
  }

  /// 设置默认地址
  ///
  updateAddressDefault(BuildContext context, int id, bool isDefault) async {
    bool success = await provider.updateAddressDefault(id, isDefault);

    if (success) {
      Toast.show(context, '设置成功');
      getAddresses();
    } else {
      Toast.show(context, '设置失败');
    }
  }

  /// 删除地址
  ///
  deleteAddress(BuildContext context, int id) async {
    int success = await provider.deleteAddress(id);

    if (success == 1) {
      Toast.show(context, '删除成功');

      getAddresses();
    } else {
      Toast.show(context, '删除失败');
    }

    Navigator.of(context).pop();
  }
}
