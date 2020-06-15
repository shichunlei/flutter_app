import 'package:azlistview/azlistview.dart';
import 'package:lpinyin/lpinyin.dart';

/// gender : "male"
/// name : {"title":"Mr","first":"Edwin","last":"Scott"}
/// location : {"street":{"number":9301,"name":"Stevens Creek Blvd"},"city":"Albany","state":"Florida","country":"United States","postcode":40616,"coordinates":{"latitude":"82.5484","longitude":"-37.4545"},"timezone":{"offset":"-1:00","description":"Azores, Cape Verde Islands"}}
/// email : "Edwin.Scott@example.com"
/// login : {"uuid":"4d6ec025-cfa9-4344-9c45-53b5544cdb52","username":"browngoose418","password":"sandman","salt":"W8PKopq1","md5":"2fd9d288ac85305de4ad9f4b8f9d6f26","sha1":"5f167aa3e1ce93344eb74cc6c5ef02324d258349","sha256":"ebee0d0a142b2f3f47f16ea734a07d110fb1b17f57da7f9fdb6e63d6ab1513ce"}
/// dob : {"date":"1957-05-18T19:11:18.246Z","age":62}
/// registered : {"date":"2014-09-14T04:05:45.332Z","age":5}
/// phone : "(323)-787-3148"
/// cell : "(886)-854-5497"
/// id : {"name":"SSN","value":"347-03-9383"}
/// picture : {"large":"https://randomuser.me/api/portraits/men/36.jpg","medium":"https://randomuser.me/api/portraits/med/men/36.jpg","thumbnail":"https://randomuser.me/api/portraits/thumb/men/36.jpg"}
/// nat : "US"

class ContactBean extends ISuspensionBean {
  String gender;
  NameBean name;
  LocationBean location;
  String email;
  LoginBean login;
  DobBean dob;
  RegisteredBean registered;
  String phone;
  String cell;
  IdBean id;
  PictureBean picture;
  String nat;

  String fullName;
  String firstLetter;

  static ContactBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ContactBean contact = ContactBean();
    contact.gender = map['gender'];
    contact.name = NameBean.fromMap(map['name']);
    contact.location = LocationBean.fromMap(map['location']);
    contact.email = map['email'];
    contact.login = LoginBean.fromMap(map['login']);
    contact.dob = DobBean.fromMap(map['dob']);
    contact.registered = RegisteredBean.fromMap(map['registered']);
    contact.phone = map['phone'];
    contact.cell = map['cell'];
    contact.id = IdBean.fromMap(map['id']);
    contact.picture = PictureBean.fromMap(map['picture']);
    contact.nat = map['nat'];

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

  Map toJson() => {
        "gender": gender,
        "name": name,
        "location": location,
        "email": email,
        "login": login,
        "dob": dob,
        "registered": registered,
        "phone": phone,
        "cell": cell,
        "id": id,
        "picture": picture,
        "nat": nat,
      };

  @override
  String getSuspensionTag() => firstLetter;
}

/// large : "https://randomuser.me/api/portraits/men/36.jpg"
/// medium : "https://randomuser.me/api/portraits/med/men/36.jpg"
/// thumbnail : "https://randomuser.me/api/portraits/thumb/men/36.jpg"

class PictureBean {
  String large;
  String medium;
  String thumbnail;

  static PictureBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    PictureBean pictureBean = PictureBean();
    pictureBean.large = map['large'];
    pictureBean.medium = map['medium'];
    pictureBean.thumbnail = map['thumbnail'];
    return pictureBean;
  }

  Map toJson() => {
        "large": large,
        "medium": medium,
        "thumbnail": thumbnail,
      };
}

/// name : "SSN"
/// value : "347-03-9383"

class IdBean {
  String name;
  String value;

  static IdBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    IdBean idBean = IdBean();
    idBean.name = map['name'];
    idBean.value = map['value'];
    return idBean;
  }

  Map toJson() => {
        "name": name,
        "value": value,
      };
}

/// date : "2014-09-14T04:05:45.332Z"
/// age : 5

class RegisteredBean {
  String date;
  int age;

  static RegisteredBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    RegisteredBean registeredBean = RegisteredBean();
    registeredBean.date = map['date'];
    registeredBean.age = map['age'];
    return registeredBean;
  }

  Map toJson() => {
        "date": date,
        "age": age,
      };
}

/// date : "1957-05-18T19:11:18.246Z"
/// age : 62

class DobBean {
  String date;
  int age;

  static DobBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DobBean dobBean = DobBean();
    dobBean.date = map['date'];
    dobBean.age = map['age'];
    return dobBean;
  }

  Map toJson() => {
        "date": date,
        "age": age,
      };
}

/// uuid : "4d6ec025-cfa9-4344-9c45-53b5544cdb52"
/// username : "browngoose418"
/// password : "sandman"
/// salt : "W8PKopq1"
/// md5 : "2fd9d288ac85305de4ad9f4b8f9d6f26"
/// sha1 : "5f167aa3e1ce93344eb74cc6c5ef02324d258349"
/// sha256 : "ebee0d0a142b2f3f47f16ea734a07d110fb1b17f57da7f9fdb6e63d6ab1513ce"

class LoginBean {
  String uuid;
  String username;
  String password;
  String salt;
  String md5;
  String sha1;
  String sha256;

  static LoginBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    LoginBean loginBean = LoginBean();
    loginBean.uuid = map['uuid'];
    loginBean.username = map['username'];
    loginBean.password = map['password'];
    loginBean.salt = map['salt'];
    loginBean.md5 = map['md5'];
    loginBean.sha1 = map['sha1'];
    loginBean.sha256 = map['sha256'];
    return loginBean;
  }

  Map toJson() => {
        "uuid": uuid,
        "username": username,
        "password": password,
        "salt": salt,
        "md5": md5,
        "sha1": sha1,
        "sha256": sha256,
      };
}

/// street : {"number":9301,"name":"Stevens Creek Blvd"}
/// city : "Albany"
/// state : "Florida"
/// country : "United States"
/// postcode : 40616
/// coordinates : {"latitude":"82.5484","longitude":"-37.4545"}
/// timezone : {"offset":"-1:00","description":"Azores, Cape Verde Islands"}

class LocationBean {
  StreetBean street;
  String city;
  String state;
  String country;
  String postcode;
  CoordinatesBean coordinates;
  TimezoneBean timezone;

  static LocationBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    LocationBean locationBean = LocationBean();
    locationBean.street = StreetBean.fromMap(map['street']);
    locationBean.city = map['city'];
    locationBean.state = map['state'];
    locationBean.country = map['country'];
    locationBean.postcode = "${map['postcode']}";
    locationBean.coordinates = CoordinatesBean.fromMap(map['coordinates']);
    locationBean.timezone = TimezoneBean.fromMap(map['timezone']);
    return locationBean;
  }

  Map toJson() => {
        "street": street,
        "city": city,
        "state": state,
        "country": country,
        "postcode": postcode,
        "coordinates": coordinates,
        "timezone": timezone,
      };
}

/// offset : "-1:00"
/// description : "Azores, Cape Verde Islands"

class TimezoneBean {
  String offset;
  String description;

  static TimezoneBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    TimezoneBean timezoneBean = TimezoneBean();
    timezoneBean.offset = map['offset'];
    timezoneBean.description = map['description'];
    return timezoneBean;
  }

  Map toJson() => {
        "offset": offset,
        "description": description,
      };
}

/// latitude : "82.5484"
/// longitude : "-37.4545"

class CoordinatesBean {
  String latitude;
  String longitude;

  static CoordinatesBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CoordinatesBean coordinatesBean = CoordinatesBean();
    coordinatesBean.latitude = map['latitude'];
    coordinatesBean.longitude = map['longitude'];
    return coordinatesBean;
  }

  Map toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

/// number : 9301
/// name : "Stevens Creek Blvd"

class StreetBean {
  String number;
  String name;

  static StreetBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    StreetBean streetBean = StreetBean();
    streetBean.number = "${map['number']}";
    streetBean.name = map['name'];
    return streetBean;
  }

  Map toJson() => {
        "number": number,
        "name": name,
      };
}

/// title : "Mr"
/// first : "Edwin"
/// last : "Scott"

class NameBean {
  String title;
  String first;
  String last;

  static NameBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    NameBean nameBean = NameBean();
    nameBean.title = map['title'];
    nameBean.first = map['first'];
    nameBean.last = map['last'];
    return nameBean;
  }

  Map toJson() => {
        "title": title,
        "first": first,
        "last": last,
      };
}
