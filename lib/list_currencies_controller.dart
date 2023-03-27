import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'list_currencies_model.dart';

class ListCurrenciesController extends GetxController {
  List<String> listCryptocurrencies = ['BTC', 'XRP', 'LTC', 'XMR', 'BCH'];
  RxList<ListCurrenciesModel> ratesList = <ListCurrenciesModel>[].obs;
  final RxString _mainCurrency = 'BTC'.obs;

  Future<void> getRates() async {
    final response = await _sendRequest();

    if (response.statusCode == 200) {
      ratesList.value = _responseToListCurrencies(response);
    }
  }

  Future<void> updateCurAvg(ListCurrenciesModel cur) async {
    final response = await _sendRequest(cur: cur.currency);

    if (response.statusCode == 200) {
      final updateData = _responseToListCurrencies(response);

      cur.avgDay.update((_) {
        cur.avgDay.value = updateData[0].avgDay.value;
      });
    }
  }

  Future<void> updateCurLast(ListCurrenciesModel cur) async {
    final response = await _sendRequest(cur: cur.currency);

    if (response.statusCode == 200) {
      final updateData = _responseToListCurrencies(response);

      cur.last.update((_) {
        cur.last.value = updateData[0].last.value;
      });
    }
  }

  get getMainCurrency => _mainCurrency.value;

  void setMainCurrency(value) => _mainCurrency.update((_) {
        _mainCurrency.value = value;
      });

  Future<http.Response> _sendRequest(
      {String cur = 'USD,EUR,GBP,AUD,RUB,JPY,CNY'}) async {
    String url =
        "https://apiv2.bitcoinaverage.com/indices/global/ticker/short?crypto=${_mainCurrency.value}&fiat=$cur";
    final response = await http.get(Uri.parse(url),
        headers: {"x-ba-key": 'ZTFiMDE5MWUyODVhNDJkYTg4YTZiYzhkNGYzMDBkNGY'});

    return response;
  }

  List<ListCurrenciesModel> _responseToListCurrencies(response) {
    final data = jsonDecode(response.body) as Map<String, dynamic>;

    return data.entries
        .map((e) => ListCurrenciesModel.fromJson(
            currency: e.key.substring(_mainCurrency.value.length),
            json: e.value))
        .toList();
  }
}
