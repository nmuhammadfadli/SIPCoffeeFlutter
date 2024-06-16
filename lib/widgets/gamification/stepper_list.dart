import 'package:flutter/material.dart';
import 'package:login_signup/theme/new_theme.dart';

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
  // Menambahkan Map untuk menyimpan status subjudul
  Map<String, Map<String, StepStatus>> substepStatus = {
    'Pembibitan': {
      'Panduan YouTube': StepStatus(isCompleted: false),
      'Halaman Pencatatan': StepStatus(isCompleted: false),
      'Halaman Quiz Post Test': StepStatus(isCompleted: false),
    },
    'Perawatan': {
      'Panduan YouTube': StepStatus(isCompleted: false),
      'Halaman Pencatatan': StepStatus(isCompleted: false),
      'Halaman Quiz Post Test': StepStatus(isCompleted: false),
    },
    'Panen': {
      'Panduan YouTube': StepStatus(isCompleted: false),
      'Halaman Pencatatan': StepStatus(isCompleted: false),
      'Halaman Quiz Post Test': StepStatus(isCompleted: false),
    },
  };

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
                            'Halaman Pencatatan', title, substepStatus[title]!),
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
            child: Text(action),
          ),
          ElevatedButton(
            onPressed: isCompleted
                ? null
                : () {
                    setState(() {
                      // Mengubah status menjadi selesai dilakukan
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
