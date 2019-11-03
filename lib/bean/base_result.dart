class BaseResult<T> {
  String code;
  bool status;
  String message;
  T data;

  static BaseResult fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    BaseResult result = BaseResult();
    result.code = '${map['code']}';
    result.status = map['status'];
    result.message = map['message'];
    result.data = map['data'];
    return result;
  }

  Map toJson() => {
        "code": code,
        "message": message,
        "data": data,
        "status": status,
      };
}
