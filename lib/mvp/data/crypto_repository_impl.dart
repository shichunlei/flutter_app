import 'dart:convert';

import 'package:dio/dio.dart';

import '../../page_index.dart';
import 'crypto.dart';

class ProdCryptoRepository implements CryptoRepository {
  @override
  Future<List<Crypto>> fetchCurrencies() async {
    Response response =
        await HttpUtils(baseUrl: 'https://api.coinmarketcap.com')
            .request('/v1/ticker', data: {"limit": 50});

    final List responseBody = json.decode(response.data);
    final statusCode = response.statusCode;
    if (statusCode != 200 || responseBody == null) {
      throw FetchDataException(
          "An error ocurred : [Status Code : $statusCode]");
    }

    return responseBody.map((c) => Crypto.fromMap(c)).toList();
  }
}
