import 'package:chatgpt_ai_app/providers/chats_provider.dart';
import 'package:chatgpt_ai_app/providers/model_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants/colors.dart';
import 'screens/chat_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ModelsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: scaffoldBackgroundColor,
            appBarTheme: AppBarTheme(color: cardColor)),
        home: const ChartScreen(),
      ),
    );
  }
}
