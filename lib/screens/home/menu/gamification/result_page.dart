import 'package:flutter/material.dart';
import 'package:login_signup/screens/home/menu/game.dart';

class ResultPage extends StatelessWidget {
  final int score;
  final String username;
  final String quizTitle;

  const ResultPage({
    required this.score,
    required this.username,
    required this.quizTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Kuis', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Skor Anda: $score',
              style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.green),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            Text(
              'Username: $username',
              style: const TextStyle(fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            Text(
              'Kuis: $quizTitle',
              style: const TextStyle(fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: () {
               Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => GamePage()), 
      );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
              ),
              child: const Text('Kembali ke Daftar Kuis', style: TextStyle(color: Colors.white,fontSize: 16.0)),
            ),
          ],
        ),
      ),
    );
  }
}