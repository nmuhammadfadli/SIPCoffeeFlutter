import 'package:flutter/material.dart';
import 'package:login_signup/models/data.dart';
import 'quiz_page.dart';

class QuizSelectionPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();

  void _showUsernameDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        title: const Text('Masukkan Username',
            style: TextStyle(fontWeight: FontWeight.bold)),
        content: TextField(
          controller: _usernameController,
          decoration: InputDecoration(
            hintText: 'Username',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              final username = _usernameController.text;
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      QuizSelectionListPage(username: username),
                ),
              );
            },
            child: const Text('OK',
                style: TextStyle(color: Colors.green, fontSize: 16.0)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Kuis', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showUsernameDialog(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding:
                const EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
          ),
          child: const Text('Mulai',
              style: TextStyle(color: Colors.white, fontSize: 18.0)),
        ),
      ),
    );
  }
}

class QuizSelectionListPage extends StatelessWidget {
  final String username;

  const QuizSelectionListPage({required this.username, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Kuis', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: quizzes.length,
        itemBuilder: (context, index) {
          final quiz = quizzes[index];
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
                    builder: (context) => QuizPage(
                      quiz: quiz,
                      username: username,
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
