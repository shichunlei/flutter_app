class Cryptocurrency {
  /**
   * key : {"urls":{"website":[],"twitter":[],"reddit":[],"message_board":[],"announcement":[],"chat":[],"explorer":[],"source_code":[]},"logo":"https: //s2.coinmarketcap.com/static/img/coins/64x64/10.png","id":10,"name":"Freicoin","symbol":"FRC","slug":"freicoin","description":null,"date_added":"2013 - 05 - 03 T00: 00: 00.000 Z","tags":["mineable"],"platform":null,"category":"coin"}
   */

  KeyBean key;

  static Cryptocurrency fromMap(Map<String, dynamic> map,
      {String id, String convert}) {
    Cryptocurrency cryptocurrency_info = new Cryptocurrency();
    cryptocurrency_info.key = map['$id'] == null
        ? null
        : KeyBean.fromMap(map['$id'], convert: convert);
    return cryptocurrency_info;
  }

  static List<Cryptocurrency> fromMapList(dynamic mapList) {
    List<Cryptocurrency> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  @override
  String toString() {
    return "{key: $key}";
  }
}

class KeyBean {
  /**
   * logo : "https: //s2.coinmarketcap.com/static/img/coins/64x64/10.png"
   * name : "Freicoin"
   * symbol : "FRC"
   * slug : "freicoin"
   * date_added : "2013 - 05 - 03 T00: 00: 00.000 Z"
   * category : "coin"
   * description : null
   * platform : null
   * id : 10
   * urls : {"website":[],"twitter":[],"reddit":[],"message_board":[],"announcement":[],"chat":[],"explorer":[],"source_code":[]}
   * tags : ["mineable"]
   */

  // Link to a CoinMarketCap hosted logo png for this cryptocurrency. 64px is default size returned. Replace "64x64" in the image path with these alternative sizes: 16, 32, 64, 128, 200
  String logo;

  // The name of this cryptocurrency.
  String name;

  // The ticker symbol for this cryptocurrency.
  String symbol;

  // The web URL friendly shorthand version of this cryptocurrency name.
  String slug;

  // Timestamp (ISO 8601) of when this cryptocurrency was added to CoinMarketCap.
  String date_added;

  // The category for this cryptocurrency.
  String category;

  // A CoinMarketCap supplied brief description of this cryptocurrency. This field will return null if a description is not available.
  String description;

  // Metadata about the parent cryptocurrency platform this cryptocurrency belongs to if it is a token, otherwise null.
  Platform platform;

  // The unique CoinMarketCap ID for this cryptocurrency.
  int id;

  // An object containing various resource URLs for this cryptocurrency.
  UrlsBean urls;

  // Tags associated with this cryptocurrency.
  List<String> tags;

  Quote quote;
  String last_updated;
  num max_supply;
  num total_supply;
  num circulating_supply;
  int num_market_pairs;
  int cmc_rank;

  // Timestamp (ISO 8601) of the last time this cryptocurrency's market data was updated.
  String last_historical_data;

  // Timestamp (ISO 8601) of the date this cryptocurrency was first available on the platform.
  String first_historical_data;

  // 1 if this cryptocurrency is still being actively tracked and updated, otherwise 0.
  int is_active;

  num btc_dominance;
  num eth_dominance;
  num active_cryptocurrencies;
  num active_market_pairs;
  num active_exchanges;

  List<MarketPair> market_pairs;

  static KeyBean fromMap(Map<String, dynamic> map, {String convert}) {
    KeyBean keyBean = new KeyBean();
    keyBean.market_pairs = map['market_pairs'] == null
        ? []
        : MarketPair.fromMapList(map['market_pairs'], convert: convert);

    keyBean.btc_dominance = map['btc_dominance'];
    keyBean.active_cryptocurrencies = map['active_cryptocurrencies'];
    keyBean.eth_dominance = map['eth_dominance'];
    keyBean.active_market_pairs = map['active_market_pairs'];
    keyBean.active_exchanges = map['active_exchanges'];

    keyBean.logo = map['logo'];
    keyBean.name = map['name'];
    keyBean.symbol = map['symbol'];
    keyBean.slug = map['slug'];
    keyBean.date_added = map['date_added'];
    keyBean.category = map['category'];
    keyBean.description = map['description'];

    keyBean.last_historical_data = map['last_historical_data'];
    keyBean.first_historical_data = map['first_historical_data'];
    keyBean.is_active = map['is_active'];

    keyBean.platform =
        map['platform'] == null ? null : Platform.fromMap(map['platform']);
    keyBean.id = map['id'];
    keyBean.urls = map['urls'] == null ? null : UrlsBean.fromMap(map['urls']);

    List<dynamic> tags = map['tags'] == null ? [] : map['tags'];
    keyBean.tags = new List();
    keyBean.tags.addAll(tags.map((o) => o.toString()));

    keyBean.quote = map['quote'] == null
        ? null
        : Quote.fromMap(map['quote'], convert: convert);

    keyBean.last_updated = map['last_updated'];
    keyBean.max_supply = map['max_supply'];
    keyBean.total_supply = map['total_supply'];
    keyBean.circulating_supply = map['circulating_supply'];
    keyBean.num_market_pairs = map['num_market_pairs'];
    keyBean.cmc_rank = map['cmc_rank'];

    return keyBean;
  }

  static List<KeyBean> fromMapList(dynamic mapList, {String convert}) {
    List<KeyBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i], convert: convert);
    }
    return list;
  }

  @override
  String toString() {
    return 'KeyBean{logo: $logo, name: $name, symbol: $symbol, slug: $slug, date_added: $date_added, category: $category, description: $description, platform: $platform, id: $id, urls: $urls, tags: $tags, quote: $quote, last_updated: $last_updated, max_supply: $max_supply, total_supply: $total_supply, circulating_supply: $circulating_supply, num_market_pairs: $num_market_pairs, cmc_rank: $cmc_rank, last_historical_data: $last_historical_data, first_historical_data: $first_historical_data, is_active: $is_active, btc_dominance: $btc_dominance, eth_dominance: $eth_dominance, active_cryptocurrencies: $active_cryptocurrencies, active_market_pairs: $active_market_pairs, active_exchanges: $active_exchanges}';
  }
}

class UrlsBean {
  /**
   * announcement : []
   * chat : []
   * explorer : []
   * message_board : []
   * reddit : []
   * source_code : []
   * twitter : []
   * website : []
   */

  // Array of announcement URLs.
  List<dynamic> announcement;

  // Array of chat service URLs.
  List<dynamic> chat;

  //Array of block explorer URLs.
  List<dynamic> explorer;

  // Array of message board URLs.
  List<dynamic> message_board;

  // Array of Reddit community page URLs.
  List<dynamic> reddit;

  //Array of source code URLs.
  List<dynamic> source_code;

  // Array of official twitter profile URLs.
  List<dynamic> twitter;

  // Array of website URLs.
  List<dynamic> website;

  static UrlsBean fromMap(Map<String, dynamic> map) {
    UrlsBean urlsBean = new UrlsBean();
    urlsBean.announcement =
        map['announcement'] == null ? [] : map['announcement'];
    urlsBean.chat = map['chat'] == null ? [] : map['chat'];
    urlsBean.explorer = map['explorer'] == null ? [] : map['explorer'];
    urlsBean.message_board =
        map['message_board'] == null ? [] : map['message_board'];
    urlsBean.reddit = map['reddit'] == null ? [] : map['reddit'];
    urlsBean.source_code = map['source_code'] == null ? [] : map['source_code'];
    urlsBean.twitter = map['twitter'] == null ? [] : map['twitter'];
    urlsBean.website = map['website'] == null ? [] : map['website'];
    return urlsBean;
  }

  static List<UrlsBean> fromMapList(dynamic mapList) {
    List<UrlsBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  @override
  String toString() {
    return '{announcement: $announcement, chat: $chat, explorer: $explorer, message_board: $message_board, reddit: $reddit, source_code: $source_code, twitter: $twitter, website: $website}';
  }
}

class Platform {
  //The name of the parent platform cryptocurrency.
  String name;

  // The unique CoinMarketCap ID for the parent platform cryptocurrency.
  int id;

  // The ticker symbol for the parent platform cryptocurrency.
  String symbol;

  // The web URL friendly shorthand version of the parent platform cryptocurrency name.
  String slug;

  // The token address on the parent platform cryptocurrency.
  String token_address;

  static Platform fromMap(Map<String, dynamic> map) {
    Platform platform = new Platform();
    platform.id = map['id'];
    platform.name = map['name'];
    platform.symbol = map['symbol'];
    platform.slug = map['slug'];
    platform.token_address = map['token_address'];
    return platform;
  }

  static List<Platform> fromMapList(dynamic mapList) {
    List<Platform> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  @override
  String toString() {
    return '{name: $name, id: $id, symbol: $symbol, slug: $slug, token_address: $token_address}';
  }
}

class Quote {
  num percent_change_7d;
  num percent_change_24h;
  num total_market_cap;
  num price;
  num percent_change_1h;
  num volume_24h;
  num total_volume_24h;
  num market_cap;
  String last_updated;
  num volume_24h_base;
  num volume_24h_quote;

  Quote key;

  Quote exchange_reported;

  static Quote fromMap(Map<String, dynamic> map, {String convert}) {
    Quote keyBean = new Quote();
    keyBean.key = map['$convert'] == null
        ? null
        : Quote.fromMap(map['$convert'], convert: '$convert');

    keyBean.exchange_reported = map['exchange_reported'] == null
        ? null
        : Quote.fromMap(map['exchange_reported']);

    keyBean.last_updated = map['last_updated'];
    keyBean.percent_change_7d = map['percent_change_7d'];
    keyBean.percent_change_24h = map['percent_change_24h'];
    keyBean.market_cap = map['market_cap'];
    keyBean.volume_24h = map['volume_24h'];
    keyBean.total_volume_24h = map['total_volume_24h'];
    keyBean.percent_change_1h = map['percent_change_1h'];
    keyBean.price = map['price'];
    keyBean.total_market_cap = map['total_market_cap'];

    keyBean.volume_24h_quote = map['volume_24h_quote'];
    keyBean.volume_24h_base = map['volume_24h_base'];

    return keyBean;
  }

  static List<Quote> fromMapList(dynamic mapList, {String convert}) {
    List<Quote> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i], convert: '$convert');
    }
    return list;
  }

  @override
  String toString() {
    return '{percent_change_7d: $percent_change_7d, percent_change_24h: $percent_change_24h, total_market_cap: $total_market_cap, price: $price, percent_change_1h: $percent_change_1h, volume_24h: $volume_24h, total_volume_24h: $total_volume_24h, market_cap: $market_cap, last_updated: $last_updated, volume_24h_base: $volume_24h_base, volume_24h_quote: $volume_24h_quote, key: $key, exchange_reported: $exchange_reported}';
  }
}

class MarketPair {
  int market_id;
  String market_pair;
  Quote quote;

  SubMarketPair market_pair_quote;
  SubMarketPair market_pair_base;

  Exchange exchange;

  static List<MarketPair> fromMapList(dynamic mapList, {String convert}) {
    List<MarketPair> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i], convert: convert);
    }
    return list;
  }

  static MarketPair fromMap(Map<String, dynamic> map, {String convert}) {
    MarketPair bean = new MarketPair();
    bean.market_id = map['market_id'];
    bean.market_pair = map['market_pair'];

    bean.exchange =
        map['exchange'] == null ? null : Exchange.fromMap(map['exchange']);

    bean.quote = map['quote'] == null
        ? null
        : Quote.fromMap(map['quote'], convert: convert);

    bean.market_pair_base = map['market_pair_base'] == null
        ? null
        : SubMarketPair.fromMap(map['market_pair_base']);

    bean.market_pair_quote = map['market_pair_quote'] == null
        ? null
        : SubMarketPair.fromMap(map['market_pair_quote']);

    return bean;
  }

  @override
  String toString() {
    return 'MarketPair{market_id: $market_id, market_pair: $market_pair, quote: $quote, market_pair_quote: $market_pair_quote, market_pair_base: $market_pair_base, exchange: $exchange}';
  }
}

class SubMarketPair {
  int currency_id;
  String currency_symbol;
  String exchange_symbol;
  String currency_type;

  static List<SubMarketPair> fromMapList(dynamic mapList) {
    List<SubMarketPair> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  static SubMarketPair fromMap(Map<String, dynamic> map) {
    SubMarketPair bean = new SubMarketPair();
    bean.currency_id = map['currency_id'];
    bean.currency_symbol = map['currency_symbol'];
    bean.exchange_symbol = map['exchange_symbol'];
    bean.currency_type = map['currency_type'];

    return bean;
  }
}

class Exchange {
  int id;
  String name;
  String slug;

  static List<Exchange> fromMapList(dynamic mapList) {
    List<Exchange> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  static Exchange fromMap(Map<String, dynamic> map) {
    Exchange bean = new Exchange();
    bean.id = map['id'];
    bean.name = map['name'];
    bean.slug = map['slug'];

    return bean;
  }

  @override
  String toString() {
    return 'Exchange{id: $id, name: $name, slug: $slug}';
  }
}
