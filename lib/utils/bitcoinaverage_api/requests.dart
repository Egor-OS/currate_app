import 'package:http/http.dart' as http;

import 'config.dart';

class RequestsBitcoinaverage {
  static const String _prefixUrl =
      'https://apiv2.bitcoinaverage.com/indices/global';
  static const Map<String, String> _headerKey = {
    'x-ba-key': ConfigBitcoinaverageAPI.apiKey
  };

  static Future<http.Response> priceData({
    required List<String> currencyList,
    required String cryptocurrencyName,
  }) async {
    String url =
        "$_prefixUrl/ticker/short?crypto=$cryptocurrencyName&fiat=${currencyList.join(',')}";
    return await http.get(Uri.parse(url), headers: _headerKey);
  }

  static Future<http.Response> historicalData({
    required String currencyName,
    required String cryptocurrencyName,
  }) async {
    String url =
        "$_prefixUrl/history/$cryptocurrencyName$currencyName?period=hour";
    return await http.get(Uri.parse(url), headers: _headerKey);
  }
}
