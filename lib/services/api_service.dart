import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:chatgpt_ai_app/models/models_models.dart';
import 'package:http/http.dart' as http;

import '../constants/api_consts.dart';

class ApiService {
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
}
