class ListCurrenciesModel {
  final String currencyName;
  final double buyCost;
  final double sellCost;
  double avgDayCost;
  double lastCost;

  ListCurrenciesModel({
    required this.currencyName,
    required this.buyCost,
    required this.sellCost,
    required this.avgDayCost,
    required this.lastCost,
  }){}

  factory ListCurrenciesModel.fromJson({
    required String currencyName,
    required json,
  }) {
    return ListCurrenciesModel(
      currencyName: currencyName,
      buyCost: json['ask'],
      sellCost: json['bid'],
      avgDayCost: json['averages']['day'],
      lastCost: json['last'],
    );
  }
}
