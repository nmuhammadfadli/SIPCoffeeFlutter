import 'package:flutter/material.dart';
import 'package:login_signup/screens/pencatatan/panen/new/panen_add_new.dart';
import 'package:login_signup/screens/pencatatan/panen/spk/leaderboard_lahan.dart';
import 'package:login_signup/screens/pencatatan/perawatan/perawatan_add.dart';
import 'package:login_signup/services/perawatan_service.dart';
import 'package:login_signup/theme/new_theme.dart';

class PanenNewPage extends StatefulWidget {
  static List<Map<String, dynamic>> daftarPerawatan = [
    {
      'id_perawatan': 'PR003',
      'kode_lahan': 'KL004',
      'perlakuan': 'Pemupukan',
      'tanggal': '11 - 01 - 2023',
      'jumlah_tanam': 30,
      'nama_pupuk': 'NPK',
      'kebutuhan_pupuk': 'P30',
    },
    {
      'id_perawatan': 'PR004',
      'kode_lahan': 'KL002',
      'perlakuan': 'Pemupukan',
      'tanggal': '11 - 03 - 2024',
      'jumlah_tanam': 30,
      'nama_pupuk': 'NPK',
      'kebutuhan_pupuk': 'P30',
    }
  ];

  static List<Map<String, dynamic>> daftarHasilPanen = [
    {
      'id_hasil_panen': 'HP002',
      'nama_lahan': 'PR003',
      'jumlah_hasil_panen': '100',
      'created_at': '08 - 03 - 2024',
    },
    {
      'id_hasil_panen': 'HP003',
      'id_perawatan': 'PR004',
      'jumlah_hasil_panen': '100',
      'created_at': '12 - 04 - 2024',
    }
  ];

  static List<Map<String, dynamic>> daftarHasilRoasting = [
    {
      'id_roasting': 'RS008',
      'id_hasil_panen': 'HP002',
      'metode_roasting': 'Cek metode roasting',
      'jumlah_hasil_roasting': '100',
      'created_at': '09 - 03 - 2024',
    },
    {
      'id_roasting': 'RS009',
      'id_hasil_panen': 'HP003',
      'metode_roasting': 'Cek metode roasting',
      'jumlah_hasil_panen': '80',
      'created_at': '12 - 05 - 2024',
    }
  ];

  static List<Map<String, dynamic>> daftarHasilProduk = [
    {
      'id_hasil_produk': 'HK021',
      'id_roasting': 'RS008',
      'varietas_kopi': 'Kopi Robusta',
      'tanggal_expired': '01 - 01 - 2025',
      'jumlah': 220,
      'stok': 12,
      'harga': 15000,
      'deskripsi': 'cek deskripsi',
      'created_at': '09 - 03 - 2024',
    },
    {
      'id_hasil_produk': 'HK022',
      'id_roasting': 'RS009',
      'tanggal_expired': '01 - 01 - 2025',
      'jumlah': 220,
      'stok': 12,
      'harga': 15000,
      'deskripsi': 'cek deskripsi',
      'created_at': '09 - 03 - 2024',
    },
  ];

  static List<Map<String, dynamic>> daftarLahan = [
    {
      'kode_perawatan': 'PR003',
      'id_hasil_panen': 'HP003',
      'varietas_kopi': 'Kopi Robusta',
      'tanggal_panen': '11 - 08 - 2023',
      'jumlah_panen': 100,
      'jumlah_hasil_roasting': 80,
    },
    {
      'kode_perawatan': 'PR004',
      'id_hasil_panen': 'HP004',
      'varietas_kopi': 'Kopi Luwak',
      'tanggal_panen': '11 - 02 - 2024',
      'jumlah_panen': 120,
      'jumlah_hasil_roasting': 110,
    },
    {
      'kode_perawatan': 'PR005',
      'id_hasil_panen': 'HP003',
      'varietas_kopi': 'Kopi torabika',
      'tanggal_panen': '22 - 05 - 2024',
      'jumlah_panen': 85,
      'jumlah_hasil_roasting': 60,
    },
  ];

  @override
  _PanenNewPageState createState() => _PanenNewPageState();
}

class _PanenNewPageState extends State<PanenNewPage> {
  List<Map<String, dynamic>> data = [];
  bool isLoading = true;
  String errorMessage = '';
  final PerawatanService perawatanService = PerawatanService();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      // final fetchedData = await perawatanService.fetchData();
      final fetchedData = PanenNewPage.daftarHasilPanen;
      setState(() {
        data = fetchedData;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double fabWidth = screenWidth / 2;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenBackgroundColor,
        title: Text(
          "Data Hasil Panen",
          style: TextStyle(
            color: whiteBackgroundColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: whiteBackgroundColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : data.isEmpty
              ? Center(
                  child: Text(
                    'Tidak ada Data',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: greyBackgroundColor,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final item = data[index];
                    final kodeHasilPanen =
                        item['id_hasil_panen'] ?? 'Tidak ada data';
                    final jumlahHasilPanen = item['jumlah_hasil_panen'] ?? 'Tidak ada data';
                    final namaLahan = item['nama_lahan'] ?? 'Tidak ada data';
                    final tanggal = item['created_at'] ?? 'Tidak ada data';

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: Card(
                        elevation: 4.0,
                        child: ListTile(
                          leading: Icon(
                            Icons.local_florist, // Icon untuk kode lahan
                            color: whiteBackgroundColor, // Warna ikon
                          ),
                          title: Text(
                            'Kode Hasil Panen: ' + kodeHasilPanen,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto', // Gunakan font Roboto
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nama Lahan: $namaLahan',
                                style:
                                    BlackRubikTextStyle.copyWith(fontSize: 11),
                              ),
                              Text(
                                'Jumlah Hasil Panen: $jumlahHasilPanen',
                                style:
                                    BlackRubikTextStyle.copyWith(fontSize: 11),
                              ),
                              Text(
                                'Tanggal Panen: $tanggal',
                                style:
                                    BlackRubikTextStyle.copyWith(fontSize: 11),
                              ),
                            ],
                          ),
                          onTap: () {
                            // Tambahkan logika navigasi jika diperlukan
                          },
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(left: 25),
            width: fabWidth,
            child: FloatingActionButton(
              backgroundColor: orangeColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LeaderboardLahanPage()),
                );
              },
              child: Text(
                'Produktivitas Lahan',
                style: WhiteRubikTextStyle.copyWith(
                  fontSize: 12,
                ),
              ),
            ),
          ),
          FloatingActionButton(
            backgroundColor: greenLightColor,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PanenAddNew()),
              );
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
