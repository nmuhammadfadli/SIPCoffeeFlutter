import 'package:flutter/material.dart';
import 'package:login_signup/screens/home/menu/gamification/LatihanPencatatan/gamepanen.dart';
import 'package:login_signup/screens/home/menu/gamification/LatihanPencatatan/gamepembibitan.dart';
import 'package:login_signup/screens/home/menu/gamification/LatihanPencatatan/gameperawatan.dart';
import 'package:login_signup/screens/home/menu/gamification/list_quiz_page.dart';
import 'package:login_signup/screens/home/menu/gamification/quiz_selection.dart';
import 'package:login_signup/services/database_game.dart';
import 'package:login_signup/theme/new_theme.dart';
import 'package:login_signup/screens/home/menu/gamification/quiz_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:login_signup/services/database_helper.dart';

class StepStatus {
  bool isCompleted;
  bool isLocked; // Tambahan untuk melacak apakah langkah terkunci

  StepStatus({required this.isCompleted, required this.isLocked});
}

class StepperListView extends StatefulWidget {
  const StepperListView({Key? key}) : super(key: key);

  @override
  State<StepperListView> createState() => _StepperListViewState();
}

class _StepperListViewState extends State<StepperListView> {
  Map<String, Map<String, StepStatus>> substepStatus = {
    'Pembibitan': {
      'Panduan YouTube': StepStatus(isCompleted: false, isLocked: false),
      'Halaman Pembibitan': StepStatus(isCompleted: false, isLocked: true),
      'Halaman Quiz Post Test': StepStatus(isCompleted: false, isLocked: true),
    },
    'Perawatan': {
      'Panduan YouTube': StepStatus(isCompleted: false, isLocked: true),
      'Halaman Perawatan': StepStatus(isCompleted: false, isLocked: true),
      'Halaman Quiz Post Test': StepStatus(isCompleted: false, isLocked: true),
    },
    'Panen': {
      'Panduan YouTube': StepStatus(isCompleted: false, isLocked: true),
      'Halaman Panen': StepStatus(isCompleted: false, isLocked: true),
      'Halaman Quiz Post Test': StepStatus(isCompleted: false, isLocked: true),
    },
  };

  Future<void> _launchYouTube() async {
    const url = 'https://youtu.be/NI0ppqgeXVY?si=TYJY6e0guqkxzK56';
    if (await canLaunch(url)) {
      await launch(url);
      await _incrementScore();
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _incrementScore() async {
    final dbHelper = DatabaseGame();
    int currentScore = await dbHelper.getScore();
    int newScore = currentScore + 10;
    await dbHelper.updateScore(newScore);
  }

  void _updateTaskCompletion(String title, String action) {
    setState(() {
      substepStatus[title]![action]!.isCompleted = true;

      // Membuka tugas berikutnya dalam urutan
      if (action == 'Panduan YouTube') {
        substepStatus[title]!['Halaman Pembibitan']!.isLocked = false;
      } else if (action == 'Halaman Pembibitan') {
        substepStatus[title]!['Halaman Quiz Post Test']!.isLocked = false;
      }

      // Membuka langkah utama berikutnya jika semua sublangkah selesai
      if (title == 'Pembibitan' &&
          substepStatus[title]!.values.every((status) => status.isCompleted)) {
        substepStatus['Perawatan']!['Panduan YouTube']!.isLocked = false;
      } else if (title == 'Perawatan' &&
          substepStatus[title]!.values.every((status) => status.isCompleted)) {
        substepStatus['Panen']!['Panduan YouTube']!.isLocked = false;
      }
    });
  }

  void _navigateToPage(String title, String action) {
    if (substepStatus[title]![action]!.isLocked) {
      _showAlert('Tugas Terkunci', 'Harap selesaikan tugas sebelumnya terlebih dahulu.');
      return;
    }

    if (substepStatus[title]![action]!.isCompleted) {
      _showAlert('Tugas Selesai', 'Tugas ini sudah selesai.');
      return;
    }

    Widget page;
    switch (title) {
      case 'Pembibitan':
        if (action == 'Halaman Pembibitan') {
          page = GamePembibitan();
        } else if (action == 'Halaman Quiz Post Test') {
          page = QuizSelectionPage();
        } else {
          return;
        }
        break;
      case 'Perawatan':
        if (action == 'Halaman Perawatan') {
          page = GamePerawatan();
        } else if (action == 'Halaman Quiz Post Test') {
          page = ListQuizPage();
        } else {
          return;
        }
        break;
      case 'Panen':
        if (action == 'Halaman Panen') {
          page = GamePanen();
        } else if (action == 'Halaman Quiz Post Test') {
          page = ListQuizPage();
        } else {
          return;
        }
        break;
      default:
        return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  void _showAlert(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: substepStatus.length,
      itemBuilder: (context, index) {
        String title = substepStatus.keys.elementAt(index);
        return Column(
          children: [
            Card(
              margin: EdgeInsets.all(8),
              child: ExpansionTile(
                tilePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                title: _buildStepItem(title, Icons.star_outline),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 56.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildActionRow(
                            'Panduan YouTube', title, substepStatus[title]!),
                        _buildActionRow(
                            'Halaman ${title}', title, substepStatus[title]!),
                        _buildActionRow('Halaman Quiz Post Test', title,
                            substepStatus[title]!),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (index < substepStatus.length - 1)
              Container(
                width: 40,
                height: 40,
                child: CustomPaint(
                  painter: _LinePainter(),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildStepItem(String title, IconData iconData) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(color: greenLightColor, width: 2),
          ),
          child: Icon(iconData, color: greenLightColor),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildActionRow(
      String action, String title, Map<String, StepStatus> statusMap) {
    bool isCompleted = statusMap[action]!.isCompleted;
    bool isLocked = statusMap[action]!.isLocked;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (isLocked) {
                  _showAlert('Tugas Terkunci', 'Harap selesaikan tugas sebelumnya terlebih dahulu.');
                } else if (isCompleted) {
                  _showAlert('Tugas Selesai', 'Tugas ini sudah selesai.');
                } else {
                  if (action == 'Panduan YouTube') {
                    _launchYouTube();
                  } else {
                    _navigateToPage(title, action);
                  }
                }
              },
              child: Text(
                action,
                style: TextStyle(
                  color: isLocked ? Colors.grey : Colors.black,
                  decoration: isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: isCompleted || isLocked
                ? null
                : () {
                    _updateTaskCompletion(title, action);
                  },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                isCompleted ? greenLightColor : Colors.blue,
              ),
            ),
            child: Text(
              isCompleted ? 'Selesai Dilakukan' : 'Lakukan +10 Poin',
              style: TextStyle(fontSize: 12.0),
            ),
          ),
        ],
      ),
    );
  }
}

class _LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
