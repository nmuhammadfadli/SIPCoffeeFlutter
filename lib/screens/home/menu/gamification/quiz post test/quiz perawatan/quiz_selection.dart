import 'package:flutter/material.dart';
import 'package:login_signup/models/dataquiz2.dart';
import 'quiz_perawatan.dart';

class QuizPerawatanSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Kuis', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: quizzes2.length,
        itemBuilder: (context, index) {
          final quiz = quizzes2[index];
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
                    builder: (context) => QuizPerawatan(
                      quiz: quiz,
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
