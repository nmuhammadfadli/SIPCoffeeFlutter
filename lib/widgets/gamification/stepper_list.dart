import 'package:flutter/material.dart';
import 'package:login_signup/screens/home/menu/gamification/LatihanPencatatan/gamepanen.dart';
import 'package:login_signup/screens/home/menu/gamification/LatihanPencatatan/gamepembibitan.dart';
import 'package:login_signup/screens/home/menu/gamification/LatihanPencatatan/gameperawatan.dart';
import 'package:login_signup/screens/home/menu/gamification/list_quiz_page.dart';
import 'package:login_signup/screens/home/menu/gamification/quiz_selection.dart';
import 'package:login_signup/services/database_game.dart';
import 'package:login_signup/theme/new_theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:login_signup/services/game_helper.dart';

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

  Map<String, String> youtubeUrls = {
    'Pembibitan': 'https://youtu.be/NI0ppqgeXVY?si=yIpzeRxQl67oGgIk',
    'Perawatan': 'https://youtu.be/L_0FiJoTQiM?si=CjTU854YIamNkVv5',
    'Panen': 'https://youtu.be/nUfDpZqF5kA?si=MsPlLxYSjTj92t5n',
  };

  @override
  void initState() {
    super.initState();
    _loadStepStatuses();
  }

  Future<void> _loadStepStatuses() async {
    substepStatus = await GameHelper.instance.fetchStepStatuses() ?? substepStatus;
    setState(() {});
  }

  Future<void> _updateStepStatus(String title, String action, StepStatus status) async {
    await GameHelper.instance.insertStepStatus(title, action, status);
  }

  Future<void> _launchYouTube(String title) async {
    final url = youtubeUrls[title];
    if (url != null && await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
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
      final statusMap = substepStatus[title];
      if (statusMap != null) {
        final status = statusMap[action];
        if (status != null) {
          status.isCompleted = true;
          _updateStepStatus(title, action, status);

          if (action == 'Panduan YouTube') {
            final nextStatus = statusMap['Halaman Pembibitan'];
            if (nextStatus != null) {
              nextStatus.isLocked = false;
              _updateStepStatus(title, 'Halaman Pembibitan', nextStatus);
            }
          } else if (action == 'Halaman Pembibitan') {
            final nextStatus = statusMap['Halaman Quiz Post Test'];
            if (nextStatus != null) {
              nextStatus.isLocked = false;
              _updateStepStatus(title, 'Halaman Quiz Post Test', nextStatus);
            }
          }

          if (title == 'Pembibitan' && statusMap.values.every((status) => status.isCompleted)) {
            final nextTitleStatus = substepStatus['Perawatan'];
            if (nextTitleStatus != null) {
              final nextActionStatus = nextTitleStatus['Panduan YouTube'];
              if (nextActionStatus != null) {
                nextActionStatus.isLocked = false;
                _updateStepStatus('Perawatan', 'Panduan YouTube', nextActionStatus);
              }
            }
          } else if (title == 'Perawatan' && statusMap.values.every((status) => status.isCompleted)) {
            final nextTitleStatus = substepStatus['Panen'];
            if (nextTitleStatus != null) {
              final nextActionStatus = nextTitleStatus['Panduan YouTube'];
              if (nextActionStatus != null) {
                nextActionStatus.isLocked = false;
                _updateStepStatus('Panen', 'Panduan YouTube', nextActionStatus);
              }
            }
          }
        }
      }
    });
  }

  void _navigateToPage(String title, String action) {
    final statusMap = substepStatus[title];
    if (statusMap == null || statusMap[action] == null) return;

    if (statusMap[action]!.isLocked) {
      _showAlert('Tugas Terkunci', 'Harap selesaikan tugas sebelumnya terlebih dahulu.');
      return;
    }

    if (statusMap[action]!.isCompleted) {
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
          page = QuizSelectionPage();
        } else {
          return;
        }
        break;
      case 'Panen':
        if (action == 'Halaman Panen') {
          page = GamePanen();
        } else if (action == 'Halaman Quiz Post Test') {
          page = QuizSelectionPage();
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
    ).then((_) {
      _updateTaskCompletion(title, action);
    });
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
                        _buildActionRow('Panduan YouTube', title, substepStatus[title]!),
                        _buildActionRow('Halaman $title', title, substepStatus[title]!),
                        _buildActionRow('Halaman Quiz Post Test', title, substepStatus[title]!),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (index != substepStatus.length - 1)
              CustomPaint(
                painter: _LinePainter(),
                child: SizedBox(height: 24),
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
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: greenLightColor,
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

  Widget _buildActionRow(String action, String title, Map<String, StepStatus> statusMap) {
    bool isCompleted = statusMap[action]?.isCompleted ?? false;
    bool isLocked = statusMap[action]?.isLocked ?? true;

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
                    _launchYouTube(title);
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
