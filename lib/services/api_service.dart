import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:chatgpt_ai_app/models/chart_model.dart';
import 'package:chatgpt_ai_app/models/models_models.dart';
import 'package:http/http.dart' as http;

import '../constants/api_consts.dart';

class ApiService {
  // get ai model list
  static Future<List<ModelsModel>> getModel() async {
    try {
      var resposn = await http.get(Uri.parse("$baseUrl/models"),
          headers: {"Authorization": "Bearer $apiKey"});

      Map jsonResponse = jsonDecode(resposn.body);
      if (jsonResponse["error"] != null) {
        throw HttpException(jsonResponse["error"]["message"]);
      }
      List tem = [];
      for (var i in jsonResponse["data"]) {
        tem.add(i);
      }
      return ModelsModel.modelsFromSnapshot(tem);
    } catch (error) {
      log(error.toString());
      rethrow;
    }
  }

  // send Message ai
  static Future<List<ChatModel>> sendMessage(
      {required String message, required String model}) async {
    try {
      var resposn = await http.post(Uri.parse("$baseUrl/completions"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $apiKey",
          },
          body: jsonEncode(
              {"model": model, "prompt": message, "max_tokens": 500}));

      Map jsonResponse = jsonDecode(resposn.body);
      if (jsonResponse["error"] != null) {
        throw HttpException(jsonResponse["error"]["message"]);
      }
      List<ChatModel> chartList = [];
      if (jsonResponse["choices"].length > 0) {
        // log(jsonResponse["choices"][0]["text"].toString());
        chartList = List.generate(
            jsonResponse["choices"].length,
            (index) => ChatModel(
                  msg: jsonResponse["choices"][index]["text"],
                  chartIndex: 1,
                ));
      }
      return chartList;
    } catch (error) {
      log(error.toString());
      rethrow;
    }
  }
}
