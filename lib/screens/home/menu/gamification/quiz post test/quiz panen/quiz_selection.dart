import 'package:flutter/material.dart';
import 'package:login_signup/models/dataquiz3.dart';
import 'quiz_panen.dart';

class QuizPanenSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Kuis', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: quizzes3.length,
        itemBuilder: (context, index) {
          final quiz = quizzes3[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: Icon(Icons.quiz, color: Colors.green),
              title: Text(
                quiz.title,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              trailing: Icon(Icons.arrow_forward, color: Colors.green),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizPanen(
                      quiz: quiz,
                       // Kosongkan username jika tidak diperlukan
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
