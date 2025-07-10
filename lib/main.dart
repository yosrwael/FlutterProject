import 'package:flutter/material.dart';
import 'package:quiz_app/screens/home_screen.dart';
import 'package:quiz_app/screens/quiz_screen.dart';
import 'package:quiz_app/screens/score_screen.dart';
import 'package:quiz_app/screens/theme.dart';
import 'package:quiz_app/screens/countdown_screen.dart';
import 'package:quiz_app/screens/results_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: MyApp.themeNotifier,
      builder: (_, currentMode, __) {
        return MaterialApp(
          title: 'Quiz App',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: currentMode,
          initialRoute: '/',
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/':
                return MaterialPageRoute(builder: (_) => const HomeScreen());
              case '/quiz':
                return MaterialPageRoute(builder: (_) => const QuizScreen());
              case '/score':
                final args = settings.arguments as List<int?>?;
                return MaterialPageRoute(
                  builder: (_) => ScoreScreen(userAnswers: args),
                );
              case '/countdown':
                return MaterialPageRoute(builder: (_) => const CountdownScreen());
              case '/results':
                final args = settings.arguments as List<int?>?;
                return MaterialPageRoute(
                  builder: (_) => ResultsScreen(userAnswers: args ?? []),
                );
              default:
                return MaterialPageRoute(builder: (_) => const HomeScreen());
            }
          },
        );
      },
    );
  }
}

void toggleTheme() {
  MyApp.themeNotifier.value =
      MyApp.themeNotifier.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
}