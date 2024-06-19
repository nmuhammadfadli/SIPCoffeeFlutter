import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_signup/theme/new_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailPage extends StatelessWidget {
  final Map<String, dynamic> product;

  ProductDetailPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Produk", style: TextStyle(color: greenLightColor, fontFamily: "Roboto", fontWeight: FontWeight.w800),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    product['gambar1'] ?? 'assets/images/kopi3.jpg',
                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      }
                    },
                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                      return Image.asset(
                        'assets/images/kopi3.jpg',
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kode Kopi: ${product['kode_kopi']}',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Roboto', color: Colors.white),
                    ),
                    _buildDetailItem(Icons.category, 'Varietas Kopi:', product['varietas_kopi']),
                    _buildDetailItem(Icons.settings, 'Metode Pengolahan:', product['metode_pengolahan']),
                    _buildDetailItem(Icons.date_range, 'Tanggal Roasting:', product['tgl_roasting']),
                    _buildDetailItem(Icons.date_range, 'Tanggal Panen:', product['tgl_panen']),
                    _buildDetailItem(Icons.date_range, 'Tanggal Exp:', product['tgl_exp']),
                    _buildDetailItem(Icons.line_weight, 'Berat:', product['berat'].toString()),
                    _buildDetailItem(Icons.description, 'Deskripsi:', product['deskripsi']),
                    _buildDetailItem(Icons.inventory, 'Stok:', product['stok'] != null ? product['stok'].toString() : 'Tidak ada data'),
                    SizedBox(height: 16.0),
                    Center(
                      child: ElevatedButton(
                         style: ElevatedButton.styleFrom(
                backgroundColor: greenLightColor,
              ),
                        onPressed: () async {
                          final url = product['link'];
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: Text('Buka Link Produk'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(fontFamily: 'Roboto', color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
