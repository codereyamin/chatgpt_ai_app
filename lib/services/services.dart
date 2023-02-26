import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../widgets/dropdown.dart';
import '../widgets/text_widget.dart';

class Services {
  static Future<void> showBottomSheet(context) async {
    await showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      backgroundColor: scaffoldBackgroundColor,
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Flexible(
                  child: TextWidget(
                label: "chosen Model",
                fontSize: 16,
              )),
              Flexible(flex: 2, child: ModelDropDownWidget())
            ]),
      ),
    );
  }
}
