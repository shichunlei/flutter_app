class NowBean {
  String cloud; // 云量
  String cond_code; // 实况天气状况代码
  String cond_txt; // 实况天气状况描述
  String fl; // 体感温度，默认单位：摄氏度
  String hum; // 相对湿度
  String pcpn; // 降水量
  String pres; // 大气压强
  String tmp; // 温度，默认单位：摄氏度
  String vis; // 能见度，默认单位：公里
  String wind_deg; // 风向360角度
  String wind_dir; // 风向
  String wind_sc; // 风力
  String wind_spd; // 风速，公里/小时

  static NowBean fromMap(Map<String, dynamic> map) {
    NowBean nowBean = NowBean();
    nowBean.cloud = map['cloud'];
    nowBean.cond_code =
        "https://cdn.heweather.com/cond_icon/${map['cond_code']}.png";
    nowBean.cond_txt = map['cond_txt'];
    nowBean.fl = map['fl'];
    nowBean.hum = "湿度 ${map['hum']}%";
    nowBean.pcpn = map['pcpn'];
    nowBean.pres = map['pres'];
    nowBean.tmp = "${map['tmp']}°";
    nowBean.vis = map['vis'];
    nowBean.wind_deg = map['wind_deg'];
    nowBean.wind_dir = map['wind_dir'];
    nowBean.wind_sc = map['wind_sc'];
    nowBean.wind_spd = map['wind_spd'];
    return nowBean;
  }

  static List<NowBean> fromMapList(dynamic mapList) {
    List<NowBean> list = List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
