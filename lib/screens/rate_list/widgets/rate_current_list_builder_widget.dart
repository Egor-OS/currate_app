import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:currate_app/controllers/rate_list_controller.dart';
import 'package:currate_app/models/list_currencies_model.dart';
import 'package:currate_app/screens/rate_list/widgets/rate_current_card_widget.dart';

class RateCurrentListBuilderWidget extends StatelessWidget {
  final List<Rx<ListCurrenciesModel>> listCurrencies;
  final RateListController rateListController;
  const RateCurrentListBuilderWidget(
      {required this.listCurrencies,
      super.key,
      required this.rateListController});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listCurrencies.length,
        itemBuilder: (BuildContext context, int index) {
          return Obx(() => RateCurrentCardWidget(
                rateListController: rateListController,
                currency: listCurrencies[index],
              ));
        });
  }
}