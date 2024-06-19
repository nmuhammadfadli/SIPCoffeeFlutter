import 'package:flutter/material.dart';
import 'package:login_signup/screens/home/menu/game.dart';
import 'package:login_signup/services/database_game.dart';
import 'package:login_signup/theme/new_theme.dart';

class ResultPage extends StatelessWidget {
  final int score;
  final String quizTitle;

  const ResultPage({
    required this.score,
    required this.quizTitle,
    super.key,
  });

  Future<void> _incrementScore(int score) async {
    final dbHelper = DatabaseGame();
    int currentScore = await dbHelper.getScore();
    int newScore = currentScore + (score * 10);
    await dbHelper.updateScore(newScore);
  }

  @override
  Widget build(BuildContext context) {
    int multipliedScore = score * 10; 

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
              'Skor Anda: $multipliedScore', 
              style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
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
              onPressed: () async {
                await _incrementScore(score); 
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => GamePage()), 
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: greenLightColor,
                padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
              ),
              child: const Text('Selesai', style: TextStyle(color: Colors.white, fontSize: 16.0)),
            ),
          ],
        ),
      ),
    );
  }
}
