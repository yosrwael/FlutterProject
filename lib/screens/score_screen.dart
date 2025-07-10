import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'results_screen.dart';

class ScoreScreen extends StatefulWidget {
  final List<int?>? userAnswers; // Added to receive user answers

  const ScoreScreen({super.key, this.userAnswers});

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  String _username = '';
  int _score = 0;

  @override
  void initState() {
    super.initState();
    _loadResult();
  }

  Future<void> _loadResult() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? 'Guest';
      _score = prefs.getInt('score') ?? 0;
    });
  }

  void _viewResults() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsScreen(userAnswers: widget.userAnswers ?? []),
      ),
    );
  }

  String _getFeedbackMessage() {
    if (_score <= 3) return 'Keep trying';
    if (_score <= 6) return 'Good effort';
    if (_score <= 9) return 'Great job';
    return 'Excellent!';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Container(),
        title: const Text('Your Result'),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: toggleTheme,
          ),
        ],
      ),
     

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${_getFeedbackMessage()}, $_username!',
                style: theme.textTheme.bodyLarge!.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Text(
                'You scored:',
                style: theme.textTheme.bodyLarge!.copyWith(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '$_score / 10',
                style: TextStyle(
                  fontSize: 36,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _viewResults,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('View Result'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}