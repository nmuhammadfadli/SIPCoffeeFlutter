import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:login_signup/screens/home/dashboard.dart';
import 'package:login_signup/screens/pencatatan/pencatatan.dart';
import 'package:login_signup/screens/profile/profile.dart';
import 'package:login_signup/screens/qrcode/qrcode.dart';
import 'package:login_signup/screens/qrcode/scan.dart';
import 'package:login_signup/screens/product/product.dart';
import 'package:login_signup/theme/new_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _pages = [
    DashboardPage(),
    ProductPage(),
    PencatatanPage(),
    QrcodePage(),
    ProfilePage(),
  ];
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: whiteBackgroundColor,
        color: whiteBackgroundColor,
        animationDuration: const Duration(milliseconds: 200),
        items: <Widget>[
          Icon(Icons.home, size: 26, color: greenBackgroundColor),
          Icon(Icons.local_florist, size: 26, color: greenBackgroundColor),
          Icon(Icons.note_alt, size: 26, color: greenBackgroundColor),
          Icon(Icons.qr_code, size: 26, color: greenBackgroundColor),
      
          Icon(Icons.person, size: 26, color: greenBackgroundColor),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: _pages[_page],
    );
  }
}
