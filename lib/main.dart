import "package:flutter/material.dart";
import "package:miabe_quiz/core/theme/app_theme.dart";

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const Scaffold(
        body: Center(
          child: Text("Hello World!"),
        ),
      ),
    );
  }
}
