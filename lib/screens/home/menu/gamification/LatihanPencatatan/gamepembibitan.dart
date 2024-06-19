import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:login_signup/services/database_game.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:login_signup/widgets/custom_textfield.dart';
import 'package:login_signup/widgets/custom_datepicker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:login_signup/screens/home/menu/game.dart';
import 'package:url_launcher/url_launcher.dart';

class GamePembibitan extends StatefulWidget {
  @override
  _GamePembibitanState createState() => _GamePembibitanState();
}

class _GamePembibitanState extends State<GamePembibitan> {
  final TextEditingController lokasiController = TextEditingController();
  final TextEditingController pemilikController = TextEditingController();
  final TextEditingController varietasController = TextEditingController();
  final TextEditingController ketinggianController = TextEditingController();
  final TextEditingController jumlahBibitController = TextEditingController();
  final TextEditingController tanggalController = TextEditingController();
  final TextEditingController luasLahanController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    // Pastikan untuk membersihkan controller saat dispose
    lokasiController.dispose();
    pemilikController.dispose();
    varietasController.dispose();
    ketinggianController.dispose();
    jumlahBibitController.dispose();
    tanggalController.dispose();
    luasLahanController.dispose();
    longitudeController.dispose();
    latitudeController.dispose();
    super.dispose();
  }

  Future<void> _loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userName = prefs.getString('userNickName') ?? 'User';
    if (mounted) {
      setState(() {
        pemilikController.text = userName;
      });
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Location services are disabled.'),
        ),
      );
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Location permissions are denied'),
          ),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.'),
        ),
      );
      return;
    }

    Position position = await Geolocator.getCurrentPosition();

    if (mounted) {
      setState(() {
        longitudeController.text = position.longitude.toString();
        latitudeController.text = position.latitude.toString();
        ketinggianController.text = position.altitude.round().toString();
      });
    }
  }

  void _launchMaps() async {
    final String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=${latitudeController.text},${longitudeController.text}';
    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }

  Future<void> _incrementScore() async {
    final dbHelper = DatabaseGame();
    int currentScore = await dbHelper.getScore();
    int newScore = currentScore + 10;
    await dbHelper.updateScore(newScore);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Tambah Pembibitan",
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
              CustomTextField(
                labelText: 'Lokasi Lahan',
                controller: lokasiController,
              ),
              SizedBox(height: 15),
              CustomTextField(
                labelText: 'Pemilik Lahan',
                controller: pemilikController,
                readOnly: true,
              ),
              SizedBox(height: 15),
              CustomTextField(
                labelText: 'Jenis Varietas',
                controller: varietasController,
              ),
              SizedBox(height: 15),
              CustomTextField(
                labelText: 'Ketinggian Tanam',
                controller: ketinggianController,
                isTextInput: false,
              ),
              SizedBox(height: 15),
              CustomTextField(
                labelText: 'Jumlah Bibit',
                controller: jumlahBibitController,
                isTextInput: false,
              ),
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomDatePickerField(
                      labelText: 'Tanggal',
                      controller: tanggalController,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: CustomTextField(
                      labelText: 'Luas Lahan',
                      controller: luasLahanController,
                      isTextInput: false,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomTextField(
                      labelText: 'Longitude',
                      controller: longitudeController,
                      readOnly: true,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: CustomTextField(
                      labelText: 'Latitude',
                      controller: latitudeController,
                      readOnly: true,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _launchMaps,
                child: Text('Tampilkan Lokasi'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                  if (_validateInputs()) {
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

  bool _validateInputs() {
    return lokasiController.text.isNotEmpty &&
        pemilikController.text.isNotEmpty &&
        varietasController.text.isNotEmpty &&
        ketinggianController.text.isNotEmpty &&
        jumlahBibitController.text.isNotEmpty &&
        tanggalController.text.isNotEmpty &&
        luasLahanController.text.isNotEmpty &&
        longitudeController.text.isNotEmpty &&
        latitudeController.text.isNotEmpty;
  }
}
