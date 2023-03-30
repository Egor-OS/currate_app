import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:currate_app/controllers/rate_info_dialog_controller.dart';
import 'package:currate_app/controllers/rate_list_controller.dart';
import 'package:currate_app/models/list_currencies_model.dart';
import 'package:currate_app/screens/info_dialog/info_dialog_screen.dart';

class RateCurrentCardWidget extends StatelessWidget {
  final Rx<ListCurrenciesModel> currency;
  final RateListController rateListController;
  const RateCurrentCardWidget({
    super.key,
    required this.currency,
    required this.rateListController,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                color: Colors.blue[300],
                width: 50,
                height: 50,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: Text(
                  currency.value.currencyName,
                  maxLines: 1,
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'now',
                      style: TextStyle(
                        color: Colors.blue[800],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Obx(
                      () => GestureDetector(
                        child: Text(
                          currency.value.lastCost.toStringAsFixed(3),
                          maxLines: 1,
                        ),
                        onTap: () => rateListController.updateCurLast(currency),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 50,
                child: IconButton(
                    onPressed: () {
                      showDialog(
                              context: context,
                              builder: (context) => InfoDialogScreen(
                                    cryptocurrencyName:
                                        rateListController.mainCryptocurrency,
                                    currencyName: currency.value.currencyName,
                                  ))
                          .then((value) => Get.delete<InfoDialogController>());
                    },
                    icon: const Icon(Icons.calendar_month_outlined)),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'average',
                      style: TextStyle(
                        color: Colors.blue[800],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Obx(
                      () => GestureDetector(
                        child: Text(
                          currency.value.avgDayCost.toStringAsFixed(3),
                          maxLines: 1,
                        ),
                        onTap: () => rateListController.updateCurAvg(currency),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                width: 50,
                height: 24,
                alignment: AlignmentDirectional.center,
                decoration: const BoxDecoration(
                  color: Colors.greenAccent,
                  border: Border(
                    top: BorderSide(
                      color: Color.fromRGBO(1, 1, 1, 1),
                      width: 1,
                    ),
                  ),
                ),
                child: const Text('Buy'),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: 24,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Color.fromRGBO(1, 1, 1, 1),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Text(
                    currency.value.buyCost.toStringAsFixed(3),
                    maxLines: 1,
                  ),
                ),
              ),
              Container(
                width: 50,
                height: 24,
                alignment: AlignmentDirectional.center,
                decoration: BoxDecoration(
                  color: Colors.red[200],
                  border: const Border(
                    top: BorderSide(
                      color: Color.fromRGBO(1, 1, 1, 1),
                      width: 1,
                    ),
                  ),
                ),
                child: const Text('Sell'),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  width: 50,
                  height: 24,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Color.fromRGBO(1, 1, 1, 1),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Text(
                    currency.value.sellCost.toStringAsFixed(3),
                    maxLines: 1,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
