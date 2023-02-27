import 'dart:developer';

import 'package:chatgpt_ai_app/constants/colors.dart';
import 'package:chatgpt_ai_app/providers/chats_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../providers/model_provider.dart';
import '../services/assets_manager.dart';
import '../services/services.dart';
import '../widgets/chart_widget.dart';
import '../widgets/text_widget.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  bool isTyping = false;
  late TextEditingController textEditingController;
  late FocusNode focusNode;
  late ScrollController listscrollController;
  @override
  void initState() {
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    listscrollController = ScrollController();

    super.initState();
  }

  @override
  void dispose() {
    listscrollController.dispose();
    textEditingController.dispose();
    focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context);
    final chatProvider = Provider.of<ChatProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: Image.asset(AssetsManager.openAiImage),
        ),
        title: const Text("ChatGPT"),
        actions: [
          IconButton(
              onPressed: () async {
                await Services.showBottomSheet(context);
              },
              icon: const Icon(Icons.more_vert_rounded))
        ],
      ),
      body: SafeArea(
          child: Column(
        children: [
          Flexible(
              child: ListView.builder(
            controller: listscrollController,
            itemCount: chatProvider.chatList.length, //chaetList.length,
            itemBuilder: (context, index) => ChartWidget(
                onTap: scrollListToEnd,
                msg: chatProvider.chatList[index].msg,
                chartIndex: chatProvider.chatList[index].chartIndex),
          )),
          if (isTyping) ...[
            const SpinKitThreeInOut(
              color: Colors.white,
              size: 30,
            ),
            const SizedBox(
              height: 15,
            ),
          ],
          Material(
            color: cardColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    focusNode: focusNode,
                    controller: textEditingController,
                    style: const TextStyle(color: Colors.white),
                    onSubmitted: (value) async {
                      await sendMessage(
                        modelsProvider: modelsProvider,
                        chatProvider: chatProvider,
                      );
                    },
                    decoration: const InputDecoration.collapsed(
                        hintText: "How can I help you",
                        hintStyle: TextStyle(color: Colors.white)),
                  )),
                  IconButton(
                      onPressed: () async {
                        await sendMessage(
                          modelsProvider: modelsProvider,
                          chatProvider: chatProvider,
                        );
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
          )
        ],
      )),
    );
  }

  void scrollListToEnd() {
    listscrollController.animateTo(
      listscrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
    );
  }

  Future<void> sendMessage({
    required ModelsProvider modelsProvider,
    required ChatProvider chatProvider,
  }) async {
    if (isTyping) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: TextWidget(
            label: "You can't not send multitiple messages at a time"),
        backgroundColor: Colors.red,
      ));
      return;
    }
    if (textEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: TextWidget(label: "Please Type a message"),
        backgroundColor: Colors.red,
      ));
      return;
    }
    try {
      String msg = textEditingController.text;
      setState(() {
        isTyping = true;
        scrollListToEnd();
        chatProvider.addUserMessage(msg: msg);
        textEditingController.clear();
        focusNode.unfocus();
      });
      await chatProvider.sendMessageAndGetAnswers(
          msg: msg, chosenModelId: modelsProvider.getCurrentModel);

      setState(() {});
    } catch (err) {
      log("err $err");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: TextWidget(label: err.toString()),
        backgroundColor: Colors.red,
      ));
    } finally {
      setState(() {
        scrollListToEnd();
        isTyping = false;
      });
    }
  }
}
