import 'package:get/get.dart';

class ListCurrenciesModel {
  final String currency;
  final double buy;
  final double sell;
  RxDouble avgDay = 0.0.obs;
  RxDouble last = 0.0.obs;

  ListCurrenciesModel({
    required this.currency,
    required this.buy,
    required this.sell,
    avgDay,
    last,
  })
  {
    this.avgDay.value = avgDay;
    this.last.value = last;
  }

  factory ListCurrenciesModel.fromJson({
    required String currency,
    required json,
  }) {
    return ListCurrenciesModel(
      currency: currency,
      buy: json['ask'],
      sell: json['bid'],
      avgDay: json['averages']['day'],
      last: json['last'],
    );
  }
}
