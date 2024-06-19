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
  Map<String, Map<String, StepStatus>>? substepStatus;

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
    substepStatus = await GameHelper.instance.fetchStepStatuses();
    if (substepStatus == null) {
      substepStatus = {
        'Pembibitan': {
          'Panduan YouTube Pembibitan': StepStatus(isCompleted: false, isLocked: false),
          'Halaman Pembibitan': StepStatus(isCompleted: false, isLocked: true),
          'Quiz Post Test Pembibitan': StepStatus(isCompleted: false, isLocked: true),
        },
        'Perawatan': {
          'Panduan YouTube Perawatan': StepStatus(isCompleted: false, isLocked: true),
          'Halaman Perawatan': StepStatus(isCompleted: false, isLocked: true),
          'Quiz Post Test Perawatan': StepStatus(isCompleted: false, isLocked: true),
        },
        'Panen': {
          'Panduan YouTube Panen': StepStatus(isCompleted: false, isLocked: true),
          'Halaman Panen': StepStatus(isCompleted: false, isLocked: true),
          'Quiz Post Test Panen': StepStatus(isCompleted: false, isLocked: true),
        },
      };
    }
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
      final statusMap = substepStatus![title];
      if (statusMap != null) {
        final status = statusMap[action];
        if (status != null) {
          status.isCompleted = true;
          _updateStepStatus(title, action, status);

          if (action == 'Panduan YouTube Pembibitan') {
            final nextStatus = statusMap['Halaman Pembibitan'];
            if (nextStatus != null) {
              nextStatus.isLocked = false;
              _updateStepStatus(title, 'Halaman Pembibitan', nextStatus);
            }
          } else if (action == 'Halaman Pembibitan') {
            final nextStatus = statusMap['Quiz Post Test Pembibitan'];
            if (nextStatus != null) {
              nextStatus.isLocked = false;
              _updateStepStatus(title, 'Quiz Post Test Pembibitan', nextStatus);
            }
          }

          if (title == 'Pembibitan' && statusMap.values.every((status) => status.isCompleted)) {
            final nextTitleStatus = substepStatus!['Perawatan'];
            if (nextTitleStatus != null) {
              final nextActionStatus = nextTitleStatus['Panduan YouTube Perawatan'];
              if (nextActionStatus != null) {
                nextActionStatus.isLocked = false;
                _updateStepStatus('Perawatan', 'Panduan YouTube Perawatan', nextActionStatus);
              }
            }
          } else if (title == 'Perawatan' && statusMap.values.every((status) => status.isCompleted)) {
            final nextTitleStatus = substepStatus!['Panen'];
            if (nextTitleStatus != null) {
              final nextActionStatus = nextTitleStatus['Panduan YouTube Panen'];
              if (nextActionStatus != null) {
                nextActionStatus.isLocked = false;
                _updateStepStatus('Panen', 'Panduan YouTube Panen', nextActionStatus);
              }
            }
          }
        }
      }
    });
  }

  void _navigateToPage(String title, String action) {
    final statusMap = substepStatus?[title];
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
        } else if (action == 'Quiz Post Test Pembibitan') {
          page = QuizSelectionPage();
        } else {
          return;
        }
        break;
      case 'Perawatan':
        if (action == 'Halaman Perawatan') {
          page = GamePerawatan();
        } else if (action == 'Quiz Post Test Perawatan') {
          page = QuizSelectionPage();
        } else {
          return;
        }
        break;
      case 'Panen':
        if (action == 'Halaman Panen') {
          page = GamePanen();
        } else if (action == 'Quiz Post Test Panen') {
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
    if (substepStatus == null) {
      return Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: substepStatus!.length,
      itemBuilder: (context, index) {
        String title = substepStatus!.keys.elementAt(index);
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
                        _buildActionRow('Panduan YouTube $title', title, substepStatus![title]!),
                        _buildActionRow('Halaman $title', title, substepStatus![title]!),
                        _buildActionRow('Quiz Post Test $title', title, substepStatus![title]!),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (index != substepStatus!.length - 1)
              Column(
                children: [
                  SizedBox(height: 8),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            SizedBox(height: 8),
                            for (int i = 0; i < 24; i++) // Adjust the number of dots here
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Container(
                                  width: 4,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        SizedBox(width: 28),
                        Column(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.brown,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        );
      },
    );
  }

  Widget _buildStepItem(String title, IconData iconData) {
    return Row(
      children: [
        Icon(iconData, color: Colors.brown, size: 40),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildActionRow(String action, String title, Map<String, StepStatus> statusMap) {
    final status = statusMap[action];
    if (status == null) {
      return SizedBox();
    }

    IconData actionIcon;
    if (action.startsWith('Panduan YouTube')) {
      actionIcon = Icons.play_circle_outline;
    } else if (action.startsWith('Halaman')) {
      actionIcon = Icons.book_outlined;
    } else {
      actionIcon = Icons.quiz_outlined;
    }

    return GestureDetector(
      onTap: () {
        if (action.startsWith('Panduan YouTube')) {
          _launchYouTube(title).then((_) {
            _updateTaskCompletion(title, action);
          });
        } else {
          _navigateToPage(title, action);
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(actionIcon, color: status.isLocked ? Colors.grey : Colors.brown),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                action,
                style: TextStyle(
                  fontSize: 16,
                  color: status.isLocked ? Colors.grey : Colors.black,
                  fontWeight: status.isCompleted ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            Icon(
              status.isCompleted ? Icons.check_circle_outline : Icons.radio_button_unchecked,
              color: status.isCompleted ? Colors.green : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
