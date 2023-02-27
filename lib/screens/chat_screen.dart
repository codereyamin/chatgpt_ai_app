import 'dart:developer';

import 'package:chatgpt_ai_app/constants/colors.dart';
import 'package:chatgpt_ai_app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../constants/test_chart.dart';
import '../models/chart_model.dart';
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
  @override
  void initState() {
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  List<ChatModel> chaetList = [];
  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context, listen: false);
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
            itemCount: chaetList.length,
            itemBuilder: (context, index) => ChartWidget(
                msg: chaetList[index].msg,
                chartIndex: chaetList[index].chartIndex),
          )),
          if (isTyping) ...[
            const SpinKitThreeInOut(
              color: Colors.white,
              size: 25,
            ),
            const SizedBox(
              height: 20,
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
                      await sendMessage(modelsProvider: modelsProvider);
                    },
                    decoration: const InputDecoration.collapsed(
                        hintText: "How can I help you",
                        hintStyle: TextStyle(color: Colors.white)),
                  )),
                  IconButton(
                      onPressed: () async {
                        // try {
                        //   setState(() {
                        //     isTyping = true;
                        //   });
                        //   final lst = await ApiService.sendMessage(
                        //       message: textEditingController.text,
                        //       model: modelsProvider.getCurrentModel);
                        //   textEditingController.text = '';
                        // } catch (err) {
                        //   log("err $err");
                        // } finally {
                        //   setState(() {
                        //     isTyping = false;
                        //   });
                        // }
                        await sendMessage(modelsProvider: modelsProvider);
                        log(chaetList.toString());
                        print("object");
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

  Future<void> sendMessage({required ModelsProvider modelsProvider}) async {
    try {
      setState(() {
        isTyping = true;
        chaetList
            .add(ChatModel(msg: textEditingController.text, chartIndex: 0));
        textEditingController.clear();
        focusNode.unfocus();
      });
      chaetList.addAll(await ApiService.sendMessage(
          message: textEditingController.text,
          model: modelsProvider.getCurrentModel));

      setState(() {});
    } catch (err) {
      log("err $err");
    } finally {
      setState(() {
        isTyping = false;
      });
    }
  }
}
