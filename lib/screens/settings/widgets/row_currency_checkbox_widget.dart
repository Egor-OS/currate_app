import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:currate_app/controllers/rate_list_controller.dart';

class RowCurrencyCheckboxWidget extends StatelessWidget {
  final RateListController rateListController;
  final String currencyName;

  const RowCurrencyCheckboxWidget(
      {super.key,
      required this.rateListController,
      required this.currencyName});

  @override
  Widget build(BuildContext context) {
    return Obx (()=> CheckboxListTile(
      title: Text(currencyName),
      value: rateListController.availableCurrencies[currencyName].value,
      onChanged: (value) {
        rateListController.switchAvailableCurrencies(currencyName, value!);
      },
      secondary: const Icon(Icons.hourglass_empty),
    ));
  }
}
