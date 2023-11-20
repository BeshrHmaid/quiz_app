import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/quiz_model';
import 'package:flutter_application_1/screen/quiz_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}
List<QuestionModel> questions = [
  QuestionModel(question: 'hi ?', availableTime: 20, answers: [
    AnswerModel(answer: 'how you doin ', isCorrect: true),
    AnswerModel(answer: 'hi', isCorrect: false),
    AnswerModel(answer: 'hey', isCorrect: false),
    AnswerModel(answer: 'hello', isCorrect: false),
  ]),
  QuestionModel(question: 'who\'s the goat ?', availableTime: 20, answers: [
    AnswerModel(answer: 'messi', isCorrect: true),
    AnswerModel(answer: 'lionel messi', isCorrect: true),
  ]),
  QuestionModel(question: 'say my name', availableTime: 20, answers: [
    AnswerModel(answer: 'heisenberg', isCorrect: true),
    AnswerModel(answer: 'my name', isCorrect: false),
  ])
];

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      home: QuizApp(),
    );
  }
}