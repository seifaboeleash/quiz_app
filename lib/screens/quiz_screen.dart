import 'package:flutter/material.dart';
import '../models/question_model.dart';
import '../services/api_service.dart';
import 'result_screen.dart';
import 'package:html_unescape/html_unescape.dart';

class QuizScreen extends StatefulWidget {
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Question> _questions = [];
  int _currentIndex = 0;
  int _score = 0;
  bool _isLoading = true;
  final unescape = HtmlUnescape();

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    final apiService = ApiService();
    final questions = await apiService.fetchQuestions();
    setState(() {
      _questions = questions;
      _isLoading = false;
    });
  }

  void _answerQuestion(String selectedAnswer) {
    final currentQuestion = _questions[_currentIndex];
    if (selectedAnswer == currentQuestion.correctAnswer) {
      _score++;
    }

    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            totalQuestions: _questions.length,
            correctAnswers: _score,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final question = _questions[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text('Quiz App' ,
         style: TextStyle(
          fontWeight: FontWeight.bold
         )
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Question ${_currentIndex + 1} of ${_questions.length}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              unescape.convert(question.question),
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 20),
            ...question.answers.map((answer) {
              return Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton(
                  onPressed: () => _answerQuestion(answer),
                  child: Text(unescape.convert(answer)),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
