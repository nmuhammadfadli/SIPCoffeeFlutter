import 'package:flutter/material.dart';
import 'package:login_signup/screens/home/menu/gamification/list_quiz_page.dart';
import 'package:login_signup/services/database_game.dart';
import 'package:login_signup/theme/new_theme.dart';
import 'package:login_signup/widgets/gamification/stepper_list.dart';
import 'package:login_signup/services/database_helper.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  String currentCategory = 'Tren';
  int score = 0;

  @override
  void initState() {
    super.initState();
    _loadScore();
  }

  Future<void> _loadScore() async {
    int savedScore = await DatabaseGame().getScore();
    setState(() {
      score = savedScore;
    });
  }

  Future<void> _incrementScore() async {
    setState(() {
      score += 10; // Misalnya, tambahkan 10 poin setiap kali.
    });
    await DatabaseGame().updateScore(score);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greenBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 88,
        centerTitle: true,
        bottomOpacity: 0,
        forceMaterialTransparency: true,
        title: Text(
          'Panduan Game',
          style: WhiteInterTextStyle.copyWith(
            fontWeight: semiBold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: whiteBackgroundColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                'Skor: $score',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 1.5,
              child: StepperListView(),
            ),
            SizedBox(height: 60),
            GestureDetector(
              onTap: () async {
                await _incrementScore(); // Increment score when this button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListQuizPage()),
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: greenLightColor,
                ),
                child: Center(
                  child: Text(
                    'Lewati Panduan',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
