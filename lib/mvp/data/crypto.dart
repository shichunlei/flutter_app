/// id : "bitcoin"
/// name : "Bitcoin"
/// symbol : "BTC"
/// rank : "1"
/// price_usd : "8326.7798966"
/// price_btc : "1.0"
/// 24h_volume_usd : "18080189334.9"
/// market_cap_usd : "149713420846"
/// available_supply : "17979750.0"
/// total_supply : "17979750.0"
/// max_supply : "21000000.0"
/// percent_change_1h : "0.72"
/// percent_change_24h : "4.9"
/// percent_change_7d : "-0.26"
/// last_updated : "1570501056"

class Crypto {
  String id;
  String name;
  String symbol;
  String rank;
  String priceUsd;
  String priceBtc;
  String hVolumeUsd;
  String marketCapUsd;
  String availableSupply;
  String totalSupply;
  String maxSupply;
  String percentChange1h;
  String percentChange24h;
  String percentChange7d;
  String lastUpdated;

  static Crypto fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Crypto cryptoBean = Crypto();
    cryptoBean.id = map['id'];
    cryptoBean.name = map['name'];
    cryptoBean.symbol = map['symbol'];
    cryptoBean.rank = map['rank'];
    cryptoBean.priceUsd = map['price_usd'];
    cryptoBean.priceBtc = map['price_btc'];
    cryptoBean.hVolumeUsd = map['24h_volume_usd'];
    cryptoBean.marketCapUsd = map['market_cap_usd'];
    cryptoBean.availableSupply = map['available_supply'];
    cryptoBean.totalSupply = map['total_supply'];
    cryptoBean.maxSupply = map['max_supply'];
    cryptoBean.percentChange1h = map['percent_change_1h'];
    cryptoBean.percentChange24h = map['percent_change_24h'];
    cryptoBean.percentChange7d = map['percent_change_7d'];
    cryptoBean.lastUpdated = map['last_updated'];
    return cryptoBean;
  }

  Map toJson() => {
        "id": id,
        "name": name,
        "symbol": symbol,
        "rank": rank,
        "price_usd": priceUsd,
        "price_btc": priceBtc,
        "24h_volume_usd": hVolumeUsd,
        "market_cap_usd": marketCapUsd,
        "available_supply": availableSupply,
        "total_supply": totalSupply,
        "max_supply": maxSupply,
        "percent_change_1h": percentChange1h,
        "percent_change_24h": percentChange24h,
        "percent_change_7d": percentChange7d,
        "last_updated": lastUpdated,
      };
}

abstract class CryptoRepository {
  Future<List<Crypto>> fetchCurrencies();
}

class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}
