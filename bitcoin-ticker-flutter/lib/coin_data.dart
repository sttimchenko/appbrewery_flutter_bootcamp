import 'dart:convert';

import 'package:http/http.dart' as http;

const apiUrl = 'https://min-api.cryptocompare.com/data/pricemulti';
const apiKey = '3687dde6c5e0c3f2380292aa1a8f719e16a2aaff07d0afcc9a19689698002d90';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future<Map<String, double>> getPrices(String currency) async {
    final response = await http.get('$apiUrl?fsyms=${cryptoList.join(',')}&tsyms=$currency&api_key=$apiKey');

    if (response.statusCode == 200) {
      final decodedJson = jsonDecode(response.body);

      return Map.fromIterable(
        cryptoList,
        key: (e) => e,
        value: (e) => decodedJson[e][currency],
      );
    } else {
      print(response.statusCode);
      throw Exception();
    }
  }
}
