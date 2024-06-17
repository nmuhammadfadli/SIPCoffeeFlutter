import 'package:flutter/material.dart';
import 'package:login_signup/screens/home/menu/gamification/list_quiz_page.dart';
import 'package:login_signup/theme/new_theme.dart';
import 'package:login_signup/screens/home/menu/gamification/quiz_selection.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:login_signup/screens/pencatatan/pembibitan/pembibitan_add.dart';
import 'package:login_signup/screens/pencatatan/perawatan/perawatan_add.dart';
import 'package:login_signup/screens/pencatatan/panen/panen_add.dart';

class StepStatus {
  bool isCompleted;
  StepStatus({required this.isCompleted});
}

class StepperListView extends StatefulWidget {
  const StepperListView({Key? key}) : super(key: key);

  @override
  State<StepperListView> createState() => _StepperListViewState();
}

class _StepperListViewState extends State<StepperListView> {
  Map<String, Map<String, StepStatus>> substepStatus = {
    'Pembibitan': {
      'Panduan YouTube': StepStatus(isCompleted: false),
      'Halaman Pembibitan': StepStatus(isCompleted: false),
      'Halaman Quiz Post Test': StepStatus(isCompleted: false),
    },
    'Perawatan': {
      'Panduan YouTube': StepStatus(isCompleted: false),
      'Halaman Perawatan': StepStatus(isCompleted: false),
      'Halaman Quiz Post Test': StepStatus(isCompleted: false),
    },
    'Panen': {
      'Panduan YouTube': StepStatus(isCompleted: false),
      'Halaman Panen': StepStatus(isCompleted: false),
      'Halaman Quiz Post Test': StepStatus(isCompleted: false),
    },
  };

  Future<void> _launchYouTube() async {
    const url = 'https://youtu.be/NI0ppqgeXVY?si=TYJY6e0guqkxzK56';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _navigateToPage(String title, String action) {
    Widget page;
    switch (title) {
      case 'Pembibitan':
        if (action == 'Halaman Pembibitan') {
          page = PembibitanAdd(); 
        } else if (action == 'Halaman Quiz Post Test') {
          page = ListQuizPage(); 
        } else {
          return;
        }
        break;
      case 'Perawatan':
        if (action == 'Halaman Perawatan') {
          page = PerawatanAdd(); 
        } else if (action == 'Halaman Quiz Post Test') {
          page = ListQuizPage(); 
        } else {
          return;
        }
        break;
      case 'Panen':
        if (action == 'Halaman Panen') {
          page = PanenAdd(); 
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (action == 'Panduan YouTube') {
                  _launchYouTube();
                } else {
                  _navigateToPage(title, action);
                }
              },
              child: Text(action),
            ),
          ),
          ElevatedButton(
            onPressed: isCompleted
                ? null
                : () {
                    setState(() {
                      statusMap[action]!.isCompleted = true;
                    });
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
