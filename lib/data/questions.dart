import '../models/question_model.dart';

final List<Question> questions = [
 
  Question(
    questionText: 'What is the main building block of a Flutter UI?',
    options: ['Component', 'Widget', 'Module', 'Element'],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Which widget is used to create a scrollable list in Flutter?',
    options: ['ListView', 'Column', 'Row', 'Container'],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the purpose of the `setState` method in Flutter?',
    options: [
      'To navigate between screens',
      'To rebuild the widget tree',
      'To fetch data from an API',
      'To define app routes'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Which programming language is primarily used for Flutter development?',
    options: ['Java', 'Kotlin', 'Dart', 'Swift'],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What is the default layout orientation of a `Column` widget?',
    options: ['Horizontal', 'Vertical', 'Diagonal', 'Circular'],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Which widget is used to handle user input in a text field?',
    options: ['Text', 'TextField', 'TextInput', 'InputField'],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What does the `Scaffold` widget provide in Flutter?',
    options: [
      'A basic app structure with UI elements',
      'A state management solution',
      'A networking utility',
      'A database connection'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'Which property is used to add padding around a widget?',
    options: ['Margin', 'Padding', 'Spacing', 'Inset'],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is the purpose of the `pubspec.yaml` file in a Flutter project?',
    options: [
      'To define app routes',
      'To manage dependencies and configurations',
      'To store widget definitions',
      'To handle API requests'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Which widget is used to display an image in Flutter?',
    options: ['ImageView', 'Image', 'Picture', 'Photo'],
    correctAnswerIndex: 1,
  ),
];