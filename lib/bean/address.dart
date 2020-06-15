import 'package:flutter_app/baixing_life/db/address_provider.dart';

/// name : "234234"
/// phone : "23424234"
/// is_default : true
/// zipcode : "eewewew"
/// tag : "tag"
/// address : "address"
/// province : "province"
/// city : "city"
/// county : "county"

class Address {
  int id;
  String name;
  String phone;
  bool isDefault;
  String zipCode;
  String tag;
  String address;
  String province;
  String city;
  String county;

  Address(
      {this.id,
      this.name,
      this.phone,
      this.isDefault,
      this.zipCode,
      this.tag,
      this.address,
      this.province,
      this.city,
      this.county});

  static Address fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Address addressBean = Address();
    addressBean.id = map[AddressProvider.COLUMN_ID];
    addressBean.name = map[AddressProvider.COLUMN_NAME];
    addressBean.phone = map[AddressProvider.COLUMN_PHONE];
    addressBean.isDefault = map[AddressProvider.COLUMN_IS_DEFAULT] == 1;
    addressBean.zipCode = map[AddressProvider.COLUMN_ZIPCODE];
    addressBean.tag = map[AddressProvider.COLUMN_TAG];
    addressBean.address = map[AddressProvider.COLUMN_ADDRESS];
    addressBean.province = map[AddressProvider.COLUMN_PROVINCE];
    addressBean.city = map[AddressProvider.COLUMN_CITY];
    addressBean.county = map[AddressProvider.COLUMN_COUNTY];
    return addressBean;
  }

  Map<String, dynamic> toMap() => {
        '${AddressProvider.COLUMN_NAME}': name,
        '${AddressProvider.COLUMN_PHONE}': phone,
        '${AddressProvider.COLUMN_CITY}': city,
        '${AddressProvider.COLUMN_PROVINCE}': province,
        '${AddressProvider.COLUMN_TAG}': tag,
        '${AddressProvider.COLUMN_ADDRESS}': address,
        '${AddressProvider.COLUMN_COUNTY}': county,
        '${AddressProvider.COLUMN_IS_DEFAULT}': isDefault ? 1 : 0,
        '${AddressProvider.COLUMN_ZIPCODE}': zipCode,
      };

  @override
  String toString() {
    return '{id: $id, name: $name, phone: $phone, isDefault: $isDefault, zipcode: $zipCode, tag: $tag, address: $address, province: $province, city: $city, county: $county}';
  }
}
