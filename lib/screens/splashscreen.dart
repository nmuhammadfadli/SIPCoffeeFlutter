import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Navigasi ke layar utama setelah 3 detik
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('/home');
    });

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splashscreen2.png'),
            fit: BoxFit.cover, // Memastikan gambar memenuhi seluruh area Container
          ),
        ),
        child: Center(
          child: CircularProgressIndicator(), // Opsional: Tambahkan indikator loading
        ),
      ),
    );
  }
}
