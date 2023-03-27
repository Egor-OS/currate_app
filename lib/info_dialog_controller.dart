import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'info_dialog_model.dart';

class InfoDialogController extends GetxController {
  late List<InfoDialogModel> listInfo;
  String chosenCrypto = '';
  String chosenCurrency = '';
  
  Future<void> getInfo() async {
    final response = await _sendRequest();

    if (response.statusCode == 200) {
      listInfo = _responseToListCurrencies(response);
    }
  }

  Future<http.Response> _sendRequest() async {
    String url =
        "https://apiv2.bitcoinaverage.com/indices/global/history/$chosenCrypto$chosenCurrency?period=hour";
    final response = await http.get(Uri.parse(url),
        headers: {"x-ba-key": 'ZTFiMDE5MWUyODVhNDJkYTg4YTZiYzhkNGYzMDBkNGY'});

    return response;
  }

  List<InfoDialogModel> _responseToListCurrencies(response) {
    List<dynamic> data = jsonDecode(response.body);
    return data.map((e) => InfoDialogModel.fromJson(e)).toList();
  }
}