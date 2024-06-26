import 'package:flutter/material.dart';
import 'package:login_signup/models/quiz.dart';
import 'result_page.dart';

class QuizPage extends StatefulWidget {
  final Quiz quiz;

  const QuizPage({required this.quiz, super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentQuestionIndex = 0;
  int _score = 0;

  void _nextQuestion(bool isCorrect) {
    if (isCorrect) {
      _score++;
    }

    if (_currentQuestionIndex < widget.quiz.questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      _showResult();
    }
  }

  void _showResult() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(
          score: _score,
          quizTitle: widget.quiz.title,
        ),
      ),
    ).then((_) {
      setState(() {
        _currentQuestionIndex = 0;
        _score = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.quiz.questions[_currentQuestionIndex];


  SizedBox(height: 20);
    return Scaffold(  
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 40),
            Text(
              question.content,
              style: const TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            ...question.options.map((option) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    onPressed: () => _nextQuestion(option.isCorrect),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.all(16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: Text(
                      option.content,
                      style: const TextStyle(color: Colors.white,fontSize: 18.0),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}