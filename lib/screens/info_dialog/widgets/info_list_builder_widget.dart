import 'package:flutter/material.dart';

import 'package:currate_app/controllers/rate_info_dialog_controller.dart';
import 'package:currate_app/screens/info_dialog/widgets/one_row_info_widget.dart';

class InfoListBuilderWidget extends StatelessWidget {
  final InfoDialogController infoDialogController;
  const InfoListBuilderWidget({super.key, required this.infoDialogController});

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