import 'dart:convert';

class CityData {
  String cid;
  String location;
  String tz;
  String cnty;
  String type;
  String lon;
  String lat;
  String parent_city;
  String admin_area;

  CityData(
      {this.cid,
      this.location,
      this.tz,
      this.cnty,
      this.type,
      this.lon,
      this.lat,
      this.parent_city,
      this.admin_area});

  static List<CityData> decodeData(String jsonData) {
    List<CityData> citys = new List<CityData>();

    var data = json.decode(jsonData);

    print(data.toString());
    
    if(data['HeWeather6'][0]['status'] == 'ok'){
      var results = data['HeWeather6'][0]['basic'];
      for (int i = 0; i < results.length; i++) {
        citys.add(fromMap(results[i]));
      }
    }
    return citys;
  }

  static CityData fromMap(Map map) {
    return new CityData(
        cid: map['cid'],
        location: map['location'],
        tz: map['tz'],
        cnty: map['cnty'],
        type: map['type'],
        lon: map['lon'],
        lat: map['lat'],
        parent_city: map['parent_city'],
        admin_area: map['admin_area']);
  }
}
