import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:currate_app/controllers/rate_list_controller.dart';
import 'package:currate_app/screens/rate_list/widgets/dropdown_button_crypto_widget.dart';
import 'package:currate_app/screens/rate_list/widgets/rate_current_list_builder_widget.dart';
import 'package:go_router/go_router.dart';

class RateListScreen extends StatelessWidget {
  RateListScreen({super.key});
  final RateListController rateListController = Get.put(RateListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 229, 235, 240),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () => GoRouter.of(context).pushNamed('settings'),
                icon: const Icon(Icons.settings)),
            DropdownButtonCryptoWidget(rateListController: rateListController),
          ],
        ),
      ),
      body: FutureBuilder(
        future: rateListController.getRates(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          return RateCurrentListBuilderWidget(
            listCurrencies: rateListController.ratesList,
            rateListController: rateListController,
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => rateListController.getRates(),
        icon: const Icon(Icons.replay_outlined),
        label: const Text('reload'),
      ),
    );
  }
}
