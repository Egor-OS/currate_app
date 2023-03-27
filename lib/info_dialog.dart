import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'info_dialog_controller.dart';
import 'info_dialog_model.dart';

class InfoDialog extends StatelessWidget {
  InfoDialog({super.key});

  final InfoDialogController infoDialogController =
      Get.put(InfoDialogController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: infoDialogController.getInfo(),
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
                        "${infoDialogController.chosenCrypto}/${infoDialogController.chosenCurrency}",
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    InfoListBuilderWidget(),
                  ],
                ),
              ),
            );
          }
        });
  }
}

class InfoListBuilderWidget extends StatelessWidget {
  InfoListBuilderWidget({super.key});
  final InfoDialogController infoDialogController =
      Get.find<InfoDialogController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RawScrollbar(
        interactive: true,
        thickness: 7,
        thumbColor: Colors.blue,
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: infoDialogController.listInfo.length,
            itemBuilder: (BuildContext context, int index) {
              return OneRowInfoWidget(
                rowInfo: infoDialogController.listInfo[index],
              );
            }),
      ),
    );
  }
}

class OneRowInfoWidget extends StatelessWidget {
  final InfoDialogModel rowInfo;
  OneRowInfoWidget({super.key, required this.rowInfo});

  final InfoDialogController infoDialogController =
      Get.find<InfoDialogController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.watch_later_outlined,
              size: 17,
            ),
            Text(
              rowInfo.time,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ],
        ),
        Card(
          color: Colors.white,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                      width: 100,
                      alignment: AlignmentDirectional.center,
                      child: Text(rowInfo.low.toStringAsFixed(2))),
                  Expanded(
                      child: Center(
                    child: Text(rowInfo.average.toStringAsFixed(2)),
                  )),
                  Container(
                      width: 100,
                      alignment: AlignmentDirectional.center,
                      child: Text(rowInfo.high.toStringAsFixed(2))),
                ],
              ),
              const Divider(
                height: 2,
                thickness: 2,
                color: Colors.black,
              ),
              Row(
                children: [
                  Container(
                      color: Colors.greenAccent,
                      alignment: AlignmentDirectional.center,
                      width: 100,
                      child: const Text('MIN')),
                  Expanded(
                      child: Container(
                    color: Colors.amber[200],
                    alignment: AlignmentDirectional.center,
                    child: const Text('AVG'),
                  )),
                  Container(
                      color: Colors.red[200],
                      alignment: AlignmentDirectional.center,
                      width: 100,
                      child: const Text('MAX')),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
