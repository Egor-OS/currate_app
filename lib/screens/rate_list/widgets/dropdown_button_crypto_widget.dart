import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:currate_app/constants/constants.dart';
import 'package:currate_app/controllers/rate_list_controller.dart';


class DropdownButtonCryptoWidget extends StatelessWidget {
  final RateListController rateListController;
  const DropdownButtonCryptoWidget(
      {super.key, required this.rateListController});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: AlignmentDirectional.centerEnd,
        child: Obx(
          () => DropdownButton<String>(
            value: rateListController.mainCryptocurrency,
            alignment: AlignmentDirectional.center,
            elevation: 50,
            style: const TextStyle(color: Colors.white, fontSize: 20),
            dropdownColor: Colors.blue,
            underline: Container(height: 0),
            onChanged: (String? value) {
              rateListController.mainCryptocurrency = value;
            },
            items: Constants.listCryptocurrencies
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ));
  }
}