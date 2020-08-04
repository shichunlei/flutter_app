/// py_full : "gelunbiya"
/// zone_phone : "57"
/// py_index : "G"
/// zone_time : 0
/// py_short : "glby"
/// name_en : "Colombia"
/// name : "哥伦比亚"

class Country {
  String pyFull;
  String zonePhone;
  String pyIndex;
  int zoneTime;
  String pyShort;
  String nameEn;
  String name;

  static Country fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Country countryBean = Country();
    countryBean.pyFull = map['py_full'];
    countryBean.zonePhone = map['zone_phone'];
    countryBean.pyIndex = map['py_index'];
    countryBean.zoneTime = map['zone_time'];
    countryBean.pyShort = map['py_short'];
    countryBean.nameEn = map['name_en'];
    countryBean.name = map['name'];
    return countryBean;
  }

  Map toJson() => {
        "py_full": pyFull,
        "zone_phone": zonePhone,
        "py_index": pyIndex,
        "zone_time": zoneTime,
        "py_short": pyShort,
        "name_en": nameEn,
        "name": name,
      };
}
