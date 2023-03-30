import 'dart:convert';
import 'package:get/get.dart';

import 'package:currate_app/constants/constants.dart';
import 'package:currate_app/models/list_currencies_model.dart';
import 'package:currate_app/utils/bitcoinaverage_api/requests.dart';

class RateListController extends GetxController {
  RxList<Rx<ListCurrenciesModel>> ratesList = <Rx<ListCurrenciesModel>>[].obs;
  late RxString _mainCryptocurrency;
  late Map<String, RxBool> _availableCurrencies;

  RateListController() {
    _availableCurrencies = {
      for (var i in Constants.listCurrencies) i: true.obs
    };
    _mainCryptocurrency = Constants.listCryptocurrencies[0].obs;
  }

  Future<void> getRates() async {
    final response = await RequestsBitcoinaverage.priceData(
      currencyList: _availableCurrencies.keys
          .where((e) => _availableCurrencies[e]!.value)
          .toList(),
      cryptocurrencyName: _mainCryptocurrency.value,
    );

    if (response.statusCode == 200) {
      ratesList.value = _responseToListCurrencies(response);
    }
  }

  Future<void> updateCurAvg(Rx<ListCurrenciesModel> cur) async {
    final response = await RequestsBitcoinaverage.priceData(
      currencyList: [cur.value.currencyName],
      cryptocurrencyName: _mainCryptocurrency.value,
    );

    if (response.statusCode == 200) {
      final updateData = _responseToListCurrencies(response);

      cur.update((cur) {
        cur?.avgDayCost = updateData[0].value.avgDayCost;
      });
    }
  }

  Future<void> updateCurLast(Rx<ListCurrenciesModel> cur) async {
    final response = await RequestsBitcoinaverage.priceData(
      currencyList: [cur.value.currencyName],
      cryptocurrencyName: _mainCryptocurrency.value,
    );

    if (response.statusCode == 200) {
      final updateData = _responseToListCurrencies(response);

      cur.update((cur) {
        cur?.lastCost = updateData[0].value.lastCost;
      });
    }
  }

  List<Rx<ListCurrenciesModel>> _responseToListCurrencies(response) {
    final data = jsonDecode(response.body) as Map<String, dynamic>;

    return data.entries
        .map((e) => ListCurrenciesModel.fromJson(
                currencyName: e.key.substring(_mainCryptocurrency.value.length),
                json: e.value)
            .obs)
        .toList();
  }

  void switchAvailableCurrencies(String cyrrencyName, bool state) {
    _availableCurrencies[cyrrencyName]!.value = state;
  }

  get mainCryptocurrency => _mainCryptocurrency.value;
  get availableCurrencies => _availableCurrencies;

  set mainCryptocurrency(value) {
    _mainCryptocurrency.value = value;
    getRates();
  }

  
}
