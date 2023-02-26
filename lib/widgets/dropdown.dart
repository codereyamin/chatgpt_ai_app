import 'package:chatgpt_ai_app/constants/colors.dart';
import 'package:flutter/material.dart';

import '../constants/test_chart.dart';

class ModelDropDownWidget extends StatefulWidget {
  const ModelDropDownWidget({super.key});

  @override
  State<ModelDropDownWidget> createState() => _ModelDropDownWidgetState();
}

class _ModelDropDownWidgetState extends State<ModelDropDownWidget> {
  String currentModel = "model 1";
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        dropdownColor: scaffoldBackgroundColor,
        iconEnabledColor: Colors.white,
        value: currentModel,
        items: getModelsItem,
        onChanged: (value) {
          setState(() {
            currentModel = value.toString();
          });
        });
  }
}
