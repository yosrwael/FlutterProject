import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _startQuiz() async {
    final name = _nameController.text.trim();

    if (name.isEmpty) {
      _showErrorDialog('Please enter your name');
      return;
    }

    final isValidName = RegExp(r'^[a-zA-Z\s]+$').hasMatch(name);

    if (!isValidName) {
      _showErrorDialog('Name should contain letters only');
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', name);
    // ignore: use_build_context_synchronously
    Navigator.pushNamed(context, '/countdown'); 
  }

  void _showErrorDialog(String message) {
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: theme.scaffoldBackgroundColor,
        title: Text(
          'Invalid Name',
          style: TextStyle(color: theme.colorScheme.primary),
        ),
        content: Text(
          message,
          style: theme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'OK',
              style: TextStyle(color: theme.colorScheme.primary),
            ),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Time'),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: toggleTheme,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Enter your name to start',
                  style: theme.textTheme.bodyLarge!.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Your Name',
                    filled: true,
                    fillColor: isDark ? Colors.white12 : Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _startQuiz,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Start Quiz',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}