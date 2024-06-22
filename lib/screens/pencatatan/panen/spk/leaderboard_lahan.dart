import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:login_signup/screens/pencatatan/panen/new/panen_new.dart';
import 'package:login_signup/theme/new_theme.dart';
import 'package:login_signup/widgets/gamification/avatar.dart';
import 'package:login_signup/widgets/gamification/card.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class LeaderboardLahanPage extends StatefulWidget {
  const LeaderboardLahanPage({super.key});

  @override
  State<LeaderboardLahanPage> createState() => _LeaderboardLahanPageState();
}

class _LeaderboardLahanPageState extends State<LeaderboardLahanPage> {
  List<String> kodeLahanList = PanenNewPage.daftarPerawatan
      .map((data) => data['kode_lahan'].toString())
      .toList();
  List<String> poinLahanList = [
    '0,776',
    '0,709',
    '0,694',
  ];
  bool isMingguan = true;

  void toggleCategorize() {
    setState(() {
      isMingguan = !isMingguan;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greenBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 88,
        centerTitle: true,
        bottomOpacity: 0,
        forceMaterialTransparency: true,
        title: Text(
          'Peringkat Lahan',
          style: WhiteInterTextStyle.copyWith(
            fontWeight: semiBold,
            fontSize: 20,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        color: greenBackgroundColor,
        child: buildSlidingUpPanel(),
      ),
    );
  }

  Widget buildSlidingUpPanel() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildParameter(),
              buildTime(),
            ],
          ),
          SizedBox(
            height: 23,
          ),
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: greenLightColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(
            height: 7,
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: kodeLahanList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return LahanRankCard(
                  index: index + 1,
                  namaLahan: kodeLahanList[index].toString(),
                  poinLahan: poinLahanList[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget buildTime() {
    return Container(
      decoration: BoxDecoration(
        color: darkBlueColor,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/images/gamification/ic_time.png',
            width: 13,
          ),
          SizedBox(
            width: 6,
          ),
          Text(
            'Diperbarui: 20 Mei',
            style: WhiteRubikTextStyle.copyWith(
              fontWeight: medium,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildParameter() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: orangeColor,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.info,
              size: 13,
              color: greenBackgroundColor,
            ),
            SizedBox(
              width: 6,
            ),
            GestureDetector(
              onTap: () {
                popupInfo(context);
              },
              child: Text(
                'Lihat Parameter',
                style: WhiteRubikTextStyle.copyWith(
                  fontWeight: medium,
                  fontSize: 11,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildRanks() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          buildRank(3, 2, 'Ipin', '1.252'),
          buildRank(1, 1, 'Upin', '1.321'),
          buildRank(6, 3, 'Mail', '1.076'),
        ],
      ),
    );
  }

  Widget buildRank(numberAvatar, numberRank, name, point) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AvatarProfile(numberAvatar: numberAvatar),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 8,
            ),
            Container(
              height: 24,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: greenLightenColor,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Center(
                child: Text(
                  name,
                  style: DarkBlueRubikTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              height: 18,
              padding: EdgeInsets.symmetric(
                horizontal: 14,
              ),
              decoration: BoxDecoration(
                color: greenLightColor,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Center(
                child: Text(
                  point,
                  style: WhiteRubikTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Image.asset(
              getImageRankPath(numberRank),
              width: (MediaQuery.of(context).size.width - 48) / 3,
            ),
            numberRank != 3
                ? SizedBox(
                    height: 20,
                  )
                : SizedBox(),
          ],
        )
      ],
    );
  }

  String getImageRankPath(numberPath) {
    switch (numberPath) {
      case 1:
        return 'assets/images/gamification/rank1nd.png';
      case 2:
        return 'assets/images/gamification/rank2nd.png';
      case 3:
        return 'assets/images/gamification/rank3nd.png';
      default:
        return '';
    }
  }

  Future<void> popupInfo(BuildContext context) async {
    final bool? shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Parameter Yang Digunakan'),
        content: Container(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Ketinggian (Mdpl). Bobot: 0,4'),
              Text('Curah Hujan (mm/tahun). Bobot: 0,3'),
              Text('Bulan Kering (mm/bulan). Bobot: 0,2'),
              Text('pH (asam/basa). Bobot: 0,1'),
            ],
          ),
        ),
      ),
    );
  }
}
