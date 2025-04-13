import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final int totalQuestions;
  final int correctAnswers;

  const ResultScreen({
    super.key,
    required this.totalQuestions,
    required this.correctAnswers,
  });

  @override
  Widget build(BuildContext context) {
    final int wrongAnswers = totalQuestions - correctAnswers;
    final double score = (correctAnswers / totalQuestions) ;
    //final double scorePercentage = (correctAnswers / totalQuestions) * 100;

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
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Congratulations !',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold ,),
              ),
              const SizedBox(height: 30),
              Text(
                'Your Score: $correctAnswers / $totalQuestions',
                style: const TextStyle(fontSize: 22),
              ),
              const SizedBox(height: 20),
              Text('Correct Answers : $correctAnswers',
                  style: const TextStyle(fontSize: 20, color: Colors.green)),
              const SizedBox(height: 10),
              Text(' Wrong Answers: $wrongAnswers',
                  style: const TextStyle(fontSize: 20, color: Colors.red)),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  
                  Navigator.pop(context);
                },
                child: const Text('Try again'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
