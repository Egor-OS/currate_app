import 'package:flutter/material.dart';

import 'package:currate_app/models/info_dialog_model.dart';


class OneRowInfoWidget extends StatelessWidget {
  final InfoDialogModel rowInfo;
  const OneRowInfoWidget({super.key, required this.rowInfo});
  
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