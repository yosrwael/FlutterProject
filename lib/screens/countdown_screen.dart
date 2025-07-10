import 'dart:async';
import 'package:flutter/material.dart';
import '../main.dart'; 

class CountdownScreen extends StatefulWidget {
  const CountdownScreen({super.key});

  @override
  State<CountdownScreen> createState() => _CountdownScreenState();
}

class _CountdownScreenState extends State<CountdownScreen> {
  int _countdown = 3; 
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          _timer.cancel();
          Navigator.pushReplacementNamed(context, '/quiz');
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); 
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Get Ready!'),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: () {
              MyApp.themeNotifier.value = isDark ? ThemeMode.light : ThemeMode.dark; 
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Quiz Starts In',
              style: theme.textTheme.bodyLarge?.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '$_countdown',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: colorScheme.primary, 
              ),
            ),
          ],
        ),
      ),
    );
  }
}