import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/main.dart';

class ResultsScreen extends StatelessWidget {
  final List<int?> userAnswers;

  const ResultsScreen({super.key, required this.userAnswers});

  void _tryAgain(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Text('Quiz Results'),
        actions: [
          IconButton(
            icon: Icon(theme.brightness == Brightness.dark ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: toggleTheme,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  final question = questions[index];
                  final userAnswerIndex = userAnswers[index];
                  final correctAnswerIndex = question.correctAnswerIndex;
                  final isCorrect = userAnswerIndex == correctAnswerIndex;

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    color: theme.brightness == Brightness.dark ? Colors.grey[850] : Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Question ${index + 1}: ${question.questionText}',
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: theme.primaryColor,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ...List.generate(question.options.length, (optionIndex) {
                            final isUserAnswer = userAnswerIndex == optionIndex;
                            final isCorrectAnswer = correctAnswerIndex == optionIndex;
                            Color textColor = theme.textTheme.bodyMedium!.color!;
                            if (isUserAnswer) {
                              textColor = isCorrect ? Colors.green : Colors.red;
                            } else if (isCorrectAnswer && userAnswerIndex != null) {
                              textColor = Colors.green;
                            }
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Text(
                                '${String.fromCharCode(65 + optionIndex)}. ${question.options[optionIndex]}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: textColor,
                                  fontWeight: isUserAnswer || isCorrectAnswer ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _tryAgain(context),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Try Again'),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}