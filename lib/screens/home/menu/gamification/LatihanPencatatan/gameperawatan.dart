import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_signup/widgets/custom_textfield.dart';
import 'package:login_signup/widgets/custom_datepicker.dart';
import 'package:login_signup/screens/home/menu/game.dart';
import 'package:login_signup/services/database_game.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GamePerawatan extends StatefulWidget {
  @override
  _GamePerawatanState createState() => _GamePerawatanState();
}

class _GamePerawatanState extends State<GamePerawatan> {
  final TextEditingController luasLahanController = TextEditingController();
  final TextEditingController namaPupukController = TextEditingController();
  final TextEditingController jumlahTanamController = TextEditingController();
  final TextEditingController tanggalController = TextEditingController();
  final TextEditingController kebutuhanPupukController = TextEditingController();

  String? selectedKodeLahan;
  List<String> kodeLahanList = ['KL001', 'KL002'];  // Default values

  String? selectedPerlakuan;
  List<String> perlakuanList = ['Pemupukan', 'Penyiraman'];

  @override
  void initState() {
    super.initState();
  }

  Future<String?> _loadUserName() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userName = prefs.getString('userNickName');
      print('User Name from SharedPreferences: $userName');
      return userName;
    } catch (e) {
      print('Error loading username: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Tambah Perawatan",
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 40),
              DropdownButtonFormField<String>(
                value: selectedKodeLahan,
                onChanged: (newValue) {
                  setState(() {
                    selectedKodeLahan = newValue;
                  });
                },
                items: kodeLahanList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Kode Lahan',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              DropdownButtonFormField<String>(
                value: selectedPerlakuan,
                onChanged: (newValue) {
                  setState(() {
                    selectedPerlakuan = newValue;
                  });
                },
                items: perlakuanList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Perlakuan',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),
              CustomDatePickerField(
                labelText: 'Tanggal',
                controller: tanggalController,
              ),
              SizedBox(height: 15),
              CustomTextField(
                labelText: 'Jumlah Tanam',
                controller: jumlahTanamController,
                isTextInput: false,
              ),
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomTextField(
                      labelText: 'Nama Pupuk',
                      controller: namaPupukController,
                      readOnly: selectedPerlakuan == 'Penyiraman',
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: CustomTextField(
                      labelText: 'Kebutuhan Pupuk',
                      controller: kebutuhanPupukController,
                      isTextInput: false,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                  if (_validateInputs()) {
                    // _saveData(); // Uncomment this line to save data
                        _incrementScore();
                     Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GamePage()),
                        );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Semua input harus diisi.'),
                      ),
                    );
                  }
                },
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
    Future<void> _incrementScore() async {
    final dbHelper = DatabaseGame();
    int currentScore = await dbHelper.getScore();
    int newScore = currentScore + 10;
    await dbHelper.updateScore(newScore);
  }

  bool _validateInputs() {
    return selectedKodeLahan != null &&
        selectedPerlakuan != null &&
        tanggalController.text.isNotEmpty &&
        jumlahTanamController.text.isNotEmpty &&
        (selectedPerlakuan == 'Pemupukan' ? namaPupukController.text.isNotEmpty : true) &&
        kebutuhanPupukController.text.isNotEmpty;
  }
}
