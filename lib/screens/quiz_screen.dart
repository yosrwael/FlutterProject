import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  final List<int?> _selectedAnswers = List.filled(questions.length, null);
  List<bool> _isHovering = List.filled(4, false);

  void _selectAnswer(int index) {
    setState(() {
      _selectedAnswers[_currentQuestionIndex] = index;
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _isHovering = List.filled(4, false);
      });
      _showSnackBar('Question ${_currentQuestionIndex + 1} of ${questions.length}');
    } else {
      _goToScoreScreen();
    }
  }

  void _prevQuestion() {
    if (_currentQuestionIndex == 0) {
      _showSnackBar('This is the first question.');
    } else {
      setState(() {
        _currentQuestionIndex--;
        _isHovering = List.filled(4, false);
      });
      _showSnackBar('Question ${_currentQuestionIndex + 1} of ${questions.length}');
    }
  }

  Future<void> _goToScoreScreen() async {
    int score = 0;
    for (int i = 0; i < questions.length; i++) {
      if (_selectedAnswers[i] == questions[i].correctAnswerIndex) {
        score++;
      }
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('score', score);

    // Pass user answers to ScoreScreen
    Navigator.pushNamed(
      // ignore: use_build_context_synchronously
      context,
      '/score',
      arguments: _selectedAnswers,
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showSnackBar('Question 1 of ${questions.length}');
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[_currentQuestionIndex];
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Text('Quiz Time'),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: toggleTheme,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Center(
              child: Text(
                'Question ${_currentQuestionIndex + 1} of ${questions.length}',
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              question.questionText,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 15),
            ...List.generate(question.options.length, (index) {
              final isSelected = _selectedAnswers[_currentQuestionIndex] == index;
              final isHovering = _isHovering[index];

              return MouseRegion(
                onEnter: (_) {
                  setState(() {
                    _isHovering[index] = true;
                  });
                },
                onExit: (_) {
                  setState(() {
                    _isHovering[index] = false;
                  });
                },
                child: GestureDetector(
                  onTap: () => _selectAnswer(index),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? colorScheme.primary
                          : (isHovering
                              ? (isDark ? Colors.white24 : Colors.grey[200])
                              : (isDark ? Colors.white12 : Colors.grey[100])),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? colorScheme.primary
                            : (isDark ? Colors.white30 : Colors.grey[300]!),
                        width: 2,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        question.options[index],
                        style: TextStyle(
                          fontSize: 16,
                          color: isSelected
                              ? colorScheme.onPrimary
                              : (isDark ? Colors.white : Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _prevQuestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Previous'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_selectedAnswers[_currentQuestionIndex] == null) {
                      _showSnackBar('You have to answer the question first.');
                    } else {
                      _nextQuestion();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    _currentQuestionIndex == questions.length - 1 ? 'Finish' : 'Next',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}