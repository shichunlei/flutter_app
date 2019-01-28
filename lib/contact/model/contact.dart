import 'package:azlistview/azlistview.dart';

class Contact extends ISuspensionBean {
  String name;
  String tagIndex;
  String namePinyin;
  String phone;
  String avatar;

  Contact({this.name, this.tagIndex, this.namePinyin, this.phone, this.avatar});

  Contact.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? "",
        phone = json['phone'] ?? "",
        avatar = json['avatar'] ?? "";

  Map<String, dynamic> toJson() => {
        'name': name,
        'tagIndex': tagIndex,
        'namePinyin': namePinyin,
        'phone': phone,
        'avatar': avatar,
        'isShowSuspension': isShowSuspension
      };

  @override
  String getSuspensionTag() => tagIndex;

  @override
  String toString() {
    return 'Contact{name: $name, tagIndex: $tagIndex, namePinyin: $namePinyin, avatar: $avatar, phone: $phone}';
  }
}
