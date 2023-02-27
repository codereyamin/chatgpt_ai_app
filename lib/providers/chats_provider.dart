import 'package:chatgpt_ai_app/models/chart_model.dart';
import 'package:chatgpt_ai_app/services/api_service.dart';
import 'package:flutter/material.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> chatList = [];
  List<ChatModel> get getChatList {
    return chatList;
  }

  void addUserMessage({required String msg}) {
    chatList.add(ChatModel(msg: msg, chartIndex: 0));
    notifyListeners();
  }

  Future<void> sendMessageAndGetAnswers(
      {required String msg, required String chosenModelId}) async {
    chatList.addAll(
        await ApiService.sendMessage(message: msg, model: chosenModelId));
    notifyListeners();
  }
}
