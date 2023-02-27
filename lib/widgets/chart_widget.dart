import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chatgpt_ai_app/constants/colors.dart';
import 'package:chatgpt_ai_app/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../services/assets_manager.dart';

class ChartWidget extends StatelessWidget {
  const ChartWidget(
      {super.key, required this.msg, required this.chartIndex, this.onTap});

  final String msg;
  final int chartIndex;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: chartIndex == 0 ? scaffoldBackgroundColor : cardColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  chartIndex == 0
                      ? AssetsManager.userImage
                      : AssetsManager.botImage,
                  height: 30,
                  width: 30,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: chartIndex == 0
                      ? TextWidget(
                          label: msg,
                        )
                      : DefaultTextStyle(
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                          child: AnimatedTextKit(
                              isRepeatingAnimation: false,
                              repeatForever: false,
                              displayFullTextOnTap: true,
                              totalRepeatCount: 1,
                              onFinished: onTap,
                              animatedTexts: [TyperAnimatedText(msg.trim())]),
                        ),
                ),
                chartIndex == 0
                    ? const SizedBox.shrink()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.thumb_up_alt_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.thumb_down_alt_outlined,
                            color: Colors.white,
                          )
                        ],
                      )
              ],
            ),
          ),
        )
      ],
    );
  }
}
