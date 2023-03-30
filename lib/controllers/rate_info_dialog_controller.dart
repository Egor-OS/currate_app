import 'dart:convert';
import 'package:get/get.dart';

import 'package:currate_app/models/info_dialog_model.dart';
import 'package:currate_app/utils/bitcoinaverage_api/requests.dart';

class InfoDialogController extends GetxController {
  late List<InfoDialogModel> listInfo;

  Future<void> getInfo(cryptocurrencyName, currencyName) async {
    final response = await RequestsBitcoinaverage.historicalData(
      currencyName: currencyName,
      cryptocurrencyName: cryptocurrencyName,
    );

    listInfo =
        (response.statusCode == 200) ? _responseToListCurrencies(response) : [];
  }

  List<InfoDialogModel> _responseToListCurrencies(response) {
    List<dynamic> data = jsonDecode(response.body);
    return data.map((e) => InfoDialogModel.fromJson(e)).toList();
  }
}
