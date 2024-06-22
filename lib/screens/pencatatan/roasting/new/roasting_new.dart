import 'package:flutter/material.dart';
import 'package:login_signup/screens/pencatatan/perawatan/perawatan_add.dart';
import 'package:login_signup/screens/pencatatan/panen/new/panen_new.dart';
import 'package:login_signup/screens/pencatatan/roasting/new/roasting_add_new.dart';
import 'package:login_signup/services/perawatan_service.dart';
import 'package:login_signup/theme/new_theme.dart';

class RoastingNewPage extends StatefulWidget {
  @override
  _RoastingNewPageState createState() => _RoastingNewPageState();
}

class _RoastingNewPageState extends State<RoastingNewPage> {
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
      final fetchedData = PanenNewPage.daftarHasilRoasting;
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
          "Data Hasil Roasting",
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
                    final kodeHasilRoasting =
                        item['id_roasting'] ?? 'Tidak ada data';
                    final kodeHasilPanen =
                        item['id_hasil_panen'] ?? 'Tidak ada data';
                    final metodePengolahan =
                        item['metode_pengolahan'] ?? 'Tidak ada data';
                    final jumlahHasilRoasting =
                        item['jumlah_hasil_roasting'] ?? 'Tidak ada data';
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
                            'Kode Hasil Roasting: ' + kodeHasilRoasting,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto', // Gunakan font Roboto
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Kode Hasil Panen: $kodeHasilPanen',
                                style:
                                    BlackRubikTextStyle.copyWith(fontSize: 11),
                              ),
                              Text(
                                'JumlahHasilRoasting: $jumlahHasilRoasting',
                                style:
                                    BlackRubikTextStyle.copyWith(fontSize: 11),
                              ),
                              Text(
                                'Metode: $metodePengolahan',
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: greenLightColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RoastingAddNew()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
