import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:currate_app/controllers/rate_info_dialog_controller.dart';
import 'package:currate_app/screens/info_dialog/widgets/info_list_builder_widget.dart';

class InfoDialogScreen extends StatelessWidget {
  final String cryptocurrencyName;
  final String currencyName;

  InfoDialogScreen({
    super.key,
    required this.cryptocurrencyName,
    required this.currencyName,
  });

  final InfoDialogController infoDialogController =
      Get.put(InfoDialogController());


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: infoDialogController.getInfo(cryptocurrencyName, currencyName),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return Dialog(
              backgroundColor: const Color.fromARGB(255, 229, 235, 240),
              clipBehavior: Clip.hardEdge,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                Radius.circular(10),
              )),
              child: SizedBox(
                height: 500,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.blue,
                      height: 40,
                      alignment: AlignmentDirectional.center,
                      child: Text(
                        "$cryptocurrencyName/$currencyName",
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    InfoListBuilderWidget(
                      infoDialogController: infoDialogController,
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}
