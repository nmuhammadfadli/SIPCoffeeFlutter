import 'package:flutter/material.dart';
import 'package:login_signup/screens/pencatatan/panen/new/panen_new.dart';
import 'package:login_signup/screens/pencatatan/roasting/new/roasting_new.dart';
import 'package:login_signup/theme/new_theme.dart';
import 'package:login_signup/widgets/card_widget.dart';
import 'package:login_signup/screens/pencatatan/pembibitan/pembibitan.dart';
import 'package:login_signup/screens/pencatatan/perawatan/perawatan.dart';
import 'package:login_signup/screens/pencatatan/panen/panen.dart';
import 'package:login_signup/screens/product/product.dart';

class PencatatanPage extends StatefulWidget {
  @override
  _PencatatanPageState createState() => _PencatatanPageState();
}

class _PencatatanPageState extends State<PencatatanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: greenBackgroundColor,
          automaticallyImplyLeading: false,
          title: Text(
            "Halaman Pencatatan",
            style: TextStyle(
              color: whiteBackgroundColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PembibitanPage()),
                        );
                      },
                      child: SizedBox(
                        width: 350,
                        height: 130,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              30), // Set the border radius here
                          child: CardWidget(
                            image: AssetImage('assets/images/pembibitan.png'),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PerawatanPage()),
                        );
                      },
                      child: SizedBox(
                        width: 350,
                        height: 130,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: CardWidget(
                            image: AssetImage('assets/images/perawatan.png'),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PanenNewPage()),
                        );
                      },
                      child: SizedBox(
                        width: 350,
                        height: 130,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: CardWidget(
                            image: AssetImage('assets/images/panen_1.png'),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RoastingNewPage()),
                        );
                      },
                      child: SizedBox(
                        width: 350,
                        height: 130,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: CardWidget(
                            image:
                                AssetImage('assets/images/data_roasting.png'),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductPage()),
                        );
                      },
                      child: SizedBox(
                        width: 350,
                        height: 130,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: CardWidget(
                            image: AssetImage('assets/images/data_produk.png'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
