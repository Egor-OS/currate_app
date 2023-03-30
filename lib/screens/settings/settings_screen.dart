import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:currate_app/constants/constants.dart';
import 'package:currate_app/controllers/rate_list_controller.dart';
import 'package:currate_app/screens/settings/widgets/row_currency_checkbox_widget.dart';


class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  final RateListController rateListController = Get.find<RateListController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
        ),
        body: ListView.builder(
            itemCount: Constants.listCurrencies.length,
            itemBuilder: (BuildContext contex, int index) {
              return RowCurrencyCheckboxWidget(
                rateListController: rateListController,
                currencyName: Constants.listCurrencies[index],
              );
            }));
  }
}

