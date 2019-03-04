const List<String> ID_CARD_PROVINCE_DICT = const [
  '11=北京',
  '12=天津',
  '13=河北',
  '14=山西',
  '15=内蒙古',
  '21=辽宁',
  '22=吉林',
  '23=黑龙江',
  '31=上海',
  '32=江苏',
  '33=浙江',
  '34=安徽',
  '35=福建',
  '36=江西',
  '37=山东',
  '41=河南',
  '42=湖北',
  '43=湖南',
  '44=广东',
  '45=广西',
  '46=海南',
  '50=重庆',
  '51=四川',
  '52=贵州',
  '53=云南',
  '54=西藏',
  '61=陕西',
  '62=甘肃',
  '63=青海',
  '64=宁夏',
  '65=新疆',
  '71=台湾',
  '81=香港',
  '82=澳门',
  '91=国外',
];

///
class RegexUtil {
  /// Regex of simple mobile.
  static final String regexMobileSimple = "^[1]\\d{10}\$";

  /// Regex of exact mobile.
  /// <p>china mobile: 134(0-8), 135, 136, 137, 138, 139, 147, 150, 151, 152, 157, 158, 159, 178, 182, 183, 184, 187, 188, 198</p>
  /// <p>china unicom: 130, 131, 132, 145, 155, 156, 166, 171, 175, 176, 185, 186</p>
  /// <p>china telecom: 133, 153, 173, 177, 180, 181, 189, 199</p>
  /// <p>global star: 1349</p>
  /// <p>virtual operator: 170</p>
  static final String regexMobileExact =
      "^((13[0-9])|(14[5,7])|(15[0-3,5-9])|(16[6])|(17[0,1,3,5-8])|(18[0-9])|(19[8,9]))\\d{8}\$";

  /// Regex of telephone number.
  static final String regexTel = "^0\\d{2,3}[- ]?\\d{7,8}";

  /// Regex of id card number which length is 15.
  static final String regexIdCard15 =
      "^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}\$";

  /// Regex of id card number which length is 18.
  static final String regexIdCard18 =
      "^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9Xx])\$";

  /// Regex of email.
  static final String regexEmail =
      "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$";

  /// Regex of url.
  static final String regexUrl = "[a-zA-z]+://[^\\s]*";

  /// Regex of Chinese character.
  static final String regexZh = "[\\u4e00-\\u9fa5]";

  /// Regex of date which pattern is "yyyy-MM-dd".
  static final String regexDate =
      "^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29)\$";

  /// Regex of ip address.
  static final String regexIp =
      "((2[0-4]\\d|25[0-5]|[01]?\\d\\d?)\\.){3}(2[0-4]\\d|25[0-5]|[01]?\\d\\d?)";

  static final Map<String, String> cityMap = new Map();

  ///Return whether input matches regex of simple mobile.
  static bool isMobileSimple(String input) {
    return matches(regexMobileSimple, input);
  }

  ///Return whether input matches regex of exact mobile.
  static bool isMobileExact(String input) {
    return matches(regexMobileExact, input);
  }

  /// Return whether input matches regex of telephone number.
  static bool isTel(String input) {
    return matches(regexTel, input);
  }

  /// Return whether input matches regex of id card number.
  static bool isIDCard(String input) {
    if (input != null && input.length == 15) {
      return isIDCard15(input);
    }
    if (input != null && input.length == 18) {
      return isIDCard18Exact(input);
    }
    return false;
  }

  /// Return whether input matches regex of id card number which length is 15.
  static bool isIDCard15(String input) {
    return matches(regexIdCard15, input);
  }

  /// Return whether input matches regex of id card number which length is 18.
  static bool isIDCard18(String input) {
    return matches(regexIdCard18, input);
  }

  ///Return whether input matches regex of exact id card number which length is 18.
  static bool isIDCard18Exact(String input) {
    if (isIDCard18(input)) {
      List<int> factor = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2];
      List<String> suffix = [
        '1',
        '0',
        'X',
        '9',
        '8',
        '7',
        '6',
        '5',
        '4',
        '3',
        '2'
      ];
      if (cityMap.isEmpty) {
        List<String> list = ID_CARD_PROVINCE_DICT;
        List<MapEntry<String, String>> mapEntryList = new List();
        for (int i = 0, length = list.length; i < length; i++) {
          List<String> tokens = list[i].trim().split("=");
          MapEntry<String, String> mapEntry =
              new MapEntry(tokens[0], tokens[1]);
          mapEntryList.add(mapEntry);
        }
        cityMap.addEntries(mapEntryList);
      }
      if (cityMap[input.substring(0, 2)] != null) {
        int weightSum = 0;
        for (int i = 0; i < 17; ++i) {
          weightSum += (input.codeUnitAt(i) - '0'.codeUnitAt(0)) * factor[i];
        }
        int idCardMod = weightSum % 11;
        String idCardLast = String.fromCharCode(input.codeUnitAt(17));
        return idCardLast == suffix[idCardMod];
      }
    }
    return false;
  }

  /// Return whether input matches regex of email.
  static bool isEmail(String input) {
    return matches(regexEmail, input);
  }

  /// Return whether input matches regex of url.
  static bool isURL(String input) {
    return matches(regexUrl, input);
  }

  /// Return whether input matches regex of Chinese character.
  static bool isZh(String input) {
    return '〇' == input || matches(regexZh, input);
  }

  /// Return whether input matches regex of date which pattern is "yyyy-MM-dd".
  static bool isDate(String input) {
    return matches(regexDate, input);
  }

  /// Return whether input matches regex of ip address.
  static bool isIP(String input) {
    return matches(regexIp, input);
  }

  static bool matches(String regex, String input) {
    if (input == null || input.isEmpty) return false;
    return new RegExp(regex).hasMatch(input);
  }
}
