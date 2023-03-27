import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'info_dialog.dart';
import 'info_dialog_controller.dart';
import 'list_currencies_controller.dart';
import 'list_currencies_model.dart';

class ListCurrencies extends StatelessWidget {
  ListCurrencies({super.key});
  final ListCurrenciesController listCurrenciesController =
      Get.put(ListCurrenciesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 229, 235, 240),
      appBar: AppBar(
        title: DropdownButtonCryptoWidget(
            listCurrenciesController: listCurrenciesController),
      ),
      body: FutureBuilder(
        future: listCurrenciesController.getRates(),
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
            return RateCurrentListWidget(
              listCurrencies: listCurrenciesController.ratesList,
              listCurrenciesController: listCurrenciesController,
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => listCurrenciesController.getRates(),
        icon: const Icon(Icons.replay_outlined),
        label: const Text('reload'),
      ),
    );
  }
}

class RateCurrentListWidget extends StatelessWidget {
  final List<ListCurrenciesModel> listCurrencies;
  final ListCurrenciesController listCurrenciesController;
  const RateCurrentListWidget(
      {required this.listCurrencies,
      super.key,
      required this.listCurrenciesController});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listCurrencies.length,
        itemBuilder: (BuildContext context, int index) {
          return Obx(() => RateCurrentWidget(
                listCurrenciesController: listCurrenciesController,
                currency: listCurrencies[index],
              ));
        });
  }
}

class RateCurrentWidget extends StatelessWidget {
  final InfoDialogController infoDialogController =
      Get.put(InfoDialogController());
  final ListCurrenciesModel currency;
  final ListCurrenciesController listCurrenciesController;
  RateCurrentWidget({
    super.key,
    required this.currency,
    required this.listCurrenciesController,
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
                  currency.currency,
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
                          currency.last.toStringAsFixed(3),
                          maxLines: 1,
                        ),
                        onTap: () =>
                            listCurrenciesController.updateCurLast(currency),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 50,
                child: IconButton(
                    onPressed: () {
                      infoDialogController.chosenCurrency = currency.currency;
                      infoDialogController.chosenCrypto =
                          listCurrenciesController.getMainCurrency;
                      showDialog(
                          context: context, builder: (context) => InfoDialog());
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
                          currency.avgDay.toStringAsFixed(3),
                          maxLines: 1,
                        ),
                        onTap: () =>
                            listCurrenciesController.updateCurAvg(currency),
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
                    currency.buy.toStringAsFixed(3),
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
                    currency.sell.toStringAsFixed(3),
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

class DropdownButtonCryptoWidget extends StatelessWidget {
  final ListCurrenciesController listCurrenciesController;
  const DropdownButtonCryptoWidget(
      {super.key, required this.listCurrenciesController});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: AlignmentDirectional.centerEnd,
        child: Obx(
          () => DropdownButton<String>(
            value: listCurrenciesController.getMainCurrency,
            alignment: AlignmentDirectional.center,
            elevation: 50,
            style: const TextStyle(color: Colors.white, fontSize: 20),
            dropdownColor: Colors.blue,
            underline: Container(height: 0),
            onChanged: (String? value) {
              listCurrenciesController.setMainCurrency(value);
              listCurrenciesController.getRates();
            },
            items: listCurrenciesController.listCryptocurrencies
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
