import 'package:flutter/material.dart';

import '../widgets/text_widget.dart';

List<String> model = [
  "model1",
  "model2",
  "model3",
  "model4",
  "model5",
  "model6",
];
List<DropdownMenuItem<String>>? get getModelsItem {
  List<DropdownMenuItem<String>>? modelsitem =
      List<DropdownMenuItem<String>>.generate(
    model.length,
    (index) => DropdownMenuItem(
      child: TextWidget(
        label: model[index],
        fontSize: 15,
      ),
      value: model[index],
    ),
  );
  return modelsitem;
}

final chartMessages = [
  {
    "msg": "hello who are you?",
    "chartIndex": 0,
  },
  {
    "msg":
        "hello who are you? hello who are you? hello who are you? hello who are you? hello who are you? hello who are you? hello who are you? hello who are you? hello who are you? hello who are you? hello who are you? hello who are you? hello who are you? hello who are you? hello who are you? hello who are you? hello who are you? hello who are you? hello who are you?hello who are you? hello who are you? hello who are you? hello who are you? hello who are you? hello who are you? hello who are you? hello who are you? hello who are you? hello who are you? hello who are you? hello who are you? hello who are you? hello who are you? hello who are you? hello who are you? hello who are you? hello who are you? hello who are you? hello who are you? hello who are you? hello who are you? hello who are you? hello who are you? hello who are you? hello who are you? hello who are you? hello who are you? hello who are you? hello who are you?",
    "chartIndex": 1
  },
  {"msg": "hello who are you?", "chartIndex": 0},
  {
    "msg":
        "hello who are you ?hello who are you? hello who are you? hello who are you?",
    "chartIndex": 1
  },
  {
    "msg": "hello who are you?",
    "chartIndex": 0,
  },
  {
    "msg":
        "hello who are you?hello who are you? hello who are you? hello who are you? hello who are you?",
    "chartIndex": 1
  },
  {"msg": "hello who are you?", "chartIndex": 0},
  {
    "msg":
        "hello who are you? hello who are you? hello who are you? hello who are you? hello who are you?",
    "chartIndex": 1
  },
  {
    "msg": "hello who are you?",
    "chartIndex": 0,
  },
  {"msg": "hello who are you?", "chartIndex": 1},
  {"msg": "hello who are you?", "chartIndex": 0},
  {"msg": "hello who are you?", "chartIndex": 1},
  {
    "msg": "hello who are you?",
    "chartIndex": 0,
  },
  {"msg": "hello who are you?", "chartIndex": 1},
  {"msg": "hello who are you?", "chartIndex": 0},
  {"msg": "hello who are you?", "chartIndex": 1}
];
