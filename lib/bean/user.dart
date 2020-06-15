/// id : 6
/// email : "1558053958@qq.com"
/// name : ""
/// mobile : ""
/// avatar_url : "http://101.200.174.126:10000/data_cloud_system/users/avatars/6/medium/RackMultipart20191223-28128-1vv84sr.jpg?1577080231"

class User {
  int id;
  String email;
  String name;
  String mobile;
  String avatarUrl;

  User({this.id, this.email, this.name, this.mobile, this.avatarUrl});

  static User fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    User userBean = User();
    userBean.id = map['id'];
    userBean.email = map['email'];
    userBean.name = map['name'];
    userBean.mobile = map['mobile'];
    userBean.avatarUrl = map['avatar_url'];
    return userBean;
  }

  Map toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "mobile": mobile,
        "avatar_url": avatarUrl,
      };
}
