import 'package:chatgpt_ai_app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constants/test_chart.dart';
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
  bool isTyping = true;
  late TextEditingController textEditingController;
  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            itemCount: chartMessages.length,
            itemBuilder: (context, index) => ChartWidget(
                msg: chartMessages[index]["msg"].toString(),
                chartIndex:
                    int.parse(chartMessages[index]["chartIndex"].toString())),
          )),
          if (isTyping) ...[
            const SpinKitThreeInOut(
              color: Colors.white,
              size: 25,
            ),
            const SizedBox(
              height: 20,
            ),
            Material(
              color: cardColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: textEditingController,
                      style: const TextStyle(color: Colors.white),
                      onSubmitted: (value) {},
                      decoration: const InputDecoration.collapsed(
                          hintText: "How can I help you",
                          hintStyle: TextStyle(color: Colors.white)),
                    )),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
            )
          ],
        ],
      )),
    );
  }
}
