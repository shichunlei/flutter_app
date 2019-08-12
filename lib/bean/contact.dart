import 'package:azlistview/azlistview.dart';
import 'package:lpinyin/lpinyin.dart';

class Contact extends ISuspensionBean {
  /**
   * gender : "female"
   * email : "hilla.neva@example.com"
   * phone : "05-622-536"
   * cell : "041-016-99-64"
   * nat : "FI"
   * dob : {"date":"1968-06-28T00:18:58Z","age":50}
   * id : {"name":"HETU","value":"NaNNA286undefined"}
   * location : {"street":"171 tahmelantie","city":"rusko","state":"northern ostrobothnia","postcode":89511,"coordinates":{"latitude":"-5.5011","longitude":"15.8111"},"timezone":{"offset":"-10:00","description":"Hawaii"}}
   * login : {"uuid":"59a10dc6-e3f4-44a7-992d-3b7e77a4486a","username":"ticklishelephant738","password":"broker","salt":"l8rqNCvI","md5":"5bf0605099eb21f962ec75157eb0d651","sha1":"746917365b2cb2237994f064026a3e4c057d84f5","sha256":"99f0af9c99050e489775b27c9b67e2a5f7efcbe90f297a3cf2896efbc2f804d6"}
   * name : {"title":"mrs","first":"hilla","last":"neva"}
   * picture : {"large":"https://randomuser.me/api/portraits/women/48.jpg","medium":"https://randomuser.me/api/portraits/med/women/48.jpg","thumbnail":"https://randomuser.me/api/portraits/thumb/women/48.jpg"}
   * registered : {"date":"2016-09-02T07:17:46Z","age":2}
   */

  String gender;
  String email;
  String phone;
  String cell;
  String nat;
  DobBean dob;
  IdBean id;
  LocationBean location;
  LoginBean login;
  NameBean name;
  PictureBean picture;
  RegisteredBean registered;

  String fullName;
  String firstLetter;

  static Contact fromMap(Map<String, dynamic> map) {
    Contact contact = new Contact();
    contact.gender = map['gender'];
    contact.email = map['email'];
    contact.phone = map['phone'];
    contact.cell = map['cell'];
    contact.nat = map['nat'];
    contact.dob = DobBean.fromMap(map['dob']);
    contact.id = IdBean.fromMap(map['id']);
    contact.location = LocationBean.fromMap(map['location']);
    contact.login = LoginBean.fromMap(map['login']);
    contact.name = NameBean.fromMap(map['name']);
    contact.picture = PictureBean.fromMap(map['picture']);
    contact.registered = RegisteredBean.fromMap(map['registered']);
    contact.fullName =
        '${NameBean.fromMap(map['name']).first} ${NameBean.fromMap(map['name']).last}';

    String tag = PinyinHelper.getPinyinE(NameBean.fromMap(map['name']).first)[0]
        .toUpperCase();
    if (RegExp("[A-Z]").hasMatch(tag)) {
      contact.firstLetter = tag;
    } else {
      contact.firstLetter = "#";
    }
    return contact;
  }

  static List<Contact> fromMapList(dynamic mapList) {
    List<Contact> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  @override
  String getSuspensionTag() => firstLetter;
}

class DobBean {
  /**
   * date : "1968-06-28T00:18:58Z"
   * age : 50
   */

  String date;
  int age;

  static DobBean fromMap(Map<String, dynamic> map) {
    DobBean dobBean = new DobBean();
    dobBean.date = map['date'];
    dobBean.age = map['age'];
    return dobBean;
  }

  static List<DobBean> fromMapList(dynamic mapList) {
    List<DobBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class IdBean {
  /**
   * name : "HETU"
   * value : "NaNNA286undefined"
   */

  String name;
  String value;

  static IdBean fromMap(Map<String, dynamic> map) {
    IdBean idBean = new IdBean();
    idBean.name = map['name'];
    idBean.value = map['value'];
    return idBean;
  }

  static List<IdBean> fromMapList(dynamic mapList) {
    List<IdBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class LocationBean {
  /**
   * street : "171 tahmelantie"
   * city : "rusko"
   * state : "northern ostrobothnia"
   * postcode : 89511
   * coordinates : {"latitude":"-5.5011","longitude":"15.8111"}
   * timezone : {"offset":"-10:00","description":"Hawaii"}
   */

  String street;
  String city;
  String state;
  var postcode;
  CoordinatesBean coordinates;
  TimezoneBean timezone;

  static LocationBean fromMap(Map<String, dynamic> map) {
    LocationBean locationBean = new LocationBean();
    locationBean.street = map['street'];
    locationBean.city = map['city'];
    locationBean.state = map['state'];
    locationBean.postcode = map['postcode'];
    locationBean.coordinates = CoordinatesBean.fromMap(map['coordinates']);
    locationBean.timezone = TimezoneBean.fromMap(map['timezone']);
    return locationBean;
  }

  static List<LocationBean> fromMapList(dynamic mapList) {
    List<LocationBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class LoginBean {
  /**
   * uuid : "59a10dc6-e3f4-44a7-992d-3b7e77a4486a"
   * username : "ticklishelephant738"
   * password : "broker"
   * salt : "l8rqNCvI"
   * md5 : "5bf0605099eb21f962ec75157eb0d651"
   * sha1 : "746917365b2cb2237994f064026a3e4c057d84f5"
   * sha256 : "99f0af9c99050e489775b27c9b67e2a5f7efcbe90f297a3cf2896efbc2f804d6"
   */

  String uuid;
  String username;
  String password;
  String salt;
  String md5;
  String sha1;
  String sha256;

  static LoginBean fromMap(Map<String, dynamic> map) {
    LoginBean loginBean = new LoginBean();
    loginBean.uuid = map['uuid'];
    loginBean.username = map['username'];
    loginBean.password = map['password'];
    loginBean.salt = map['salt'];
    loginBean.md5 = map['md5'];
    loginBean.sha1 = map['sha1'];
    loginBean.sha256 = map['sha256'];
    return loginBean;
  }

  static List<LoginBean> fromMapList(dynamic mapList) {
    List<LoginBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class NameBean {
  /**
   * title : "mrs"
   * first : "hilla"
   * last : "neva"
   */

  String title;
  String first;
  String last;

  static NameBean fromMap(Map<String, dynamic> map) {
    NameBean nameBean = new NameBean();
    nameBean.title = map['title'];
    nameBean.first = map['first'];
    nameBean.last = map['last'];
    return nameBean;
  }

  static List<NameBean> fromMapList(dynamic mapList) {
    List<NameBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class PictureBean {
  /**
   * large : "https://randomuser.me/api/portraits/women/48.jpg"
   * medium : "https://randomuser.me/api/portraits/med/women/48.jpg"
   * thumbnail : "https://randomuser.me/api/portraits/thumb/women/48.jpg"
   */

  String large;
  String medium;
  String thumbnail;

  static PictureBean fromMap(Map<String, dynamic> map) {
    PictureBean pictureBean = new PictureBean();
    pictureBean.large = map['large'];
    pictureBean.medium = map['medium'];
    pictureBean.thumbnail = map['thumbnail'];
    return pictureBean;
  }

  static List<PictureBean> fromMapList(dynamic mapList) {
    List<PictureBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class RegisteredBean {
  /**
   * date : "2016-09-02T07:17:46Z"
   * age : 2
   */

  String date;
  int age;

  static RegisteredBean fromMap(Map<String, dynamic> map) {
    RegisteredBean registeredBean = new RegisteredBean();
    registeredBean.date = map['date'];
    registeredBean.age = map['age'];
    return registeredBean;
  }

  static List<RegisteredBean> fromMapList(dynamic mapList) {
    List<RegisteredBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class CoordinatesBean {
  /**
   * latitude : "-5.5011"
   * longitude : "15.8111"
   */

  String latitude;
  String longitude;

  static CoordinatesBean fromMap(Map<String, dynamic> map) {
    CoordinatesBean coordinatesBean = new CoordinatesBean();
    coordinatesBean.latitude = map['latitude'];
    coordinatesBean.longitude = map['longitude'];
    return coordinatesBean;
  }

  static List<CoordinatesBean> fromMapList(dynamic mapList) {
    List<CoordinatesBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class TimezoneBean {
  /**
   * offset : "-10:00"
   * description : "Hawaii"
   */

  String offset;
  String description;

  static TimezoneBean fromMap(Map<String, dynamic> map) {
    TimezoneBean timezoneBean = new TimezoneBean();
    timezoneBean.offset = map['offset'];
    timezoneBean.description = map['description'];
    return timezoneBean;
  }

  static List<TimezoneBean> fromMapList(dynamic mapList) {
    List<TimezoneBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
