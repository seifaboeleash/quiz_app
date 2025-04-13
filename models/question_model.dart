class Question {
  final String question;
  final List<String> answers;
  final String correctAnswer;

  Question({required this.question, required this.answers, required this.correctAnswer});

   factory Question.fromMap(Map<String, dynamic> map) {
    final List<String> allAnswers = List<String>.from(map['incorrect_answers']);
    allAnswers.add(map['correct_answer']);
    allAnswers.shuffle();

    return Question(
      question: map['question'],
      answers: allAnswers,
      correctAnswer: map['correct_answer'],
    );
  }

}