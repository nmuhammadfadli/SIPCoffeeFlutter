import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_signup/theme/new_theme.dart';
import 'package:login_signup/widgets/gamification/avatar.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:login_signup/widgets/gamification/card.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  bool isMingguan = true;
  List<dynamic> leaderboardData = [];

  @override
  void initState() {
    super.initState();
    fetchLeaderboardData();
  }

  Future<void> fetchLeaderboardData() async {
    final response = await http.get(Uri.parse('https://gamifytrace.my.id/api/result'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // Pastikan data yang diterima adalah Map dan memiliki kunci "Data Result"
      if (data is Map && data.containsKey("Data Result")) {
        final results = data["Data Result"];
        
        // Pastikan "Data Result" adalah List
        if (results is List) {
          setState(() {
            leaderboardData = results.take(3).toList(); // Ambil maksimal 3 data
          });
        } else {
          // Handle the case where "Data Result" is not a List
          throw Exception('Data Result format is not correct');
        }
      } else {
        // Handle the case where data is not a Map or doesn't contain "Data Result"
        throw Exception('Data format is not correct');
      }
    } else {
      // Handle error
      throw Exception('Failed to load leaderboard data');
    }
  }

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
          'Leaderboard',
          style: WhiteInterTextStyle.copyWith(
            fontWeight: semiBold,
            fontSize: 20,
          ),
        ),
      ),
      body: SlidingUpPanel(
        margin: EdgeInsets.symmetric(horizontal: 8),
        color: greyBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        minHeight: MediaQuery.of(context).size.height / 4,
        maxHeight: MediaQuery.of(context).size.height,
        panel: Container(
          child: buildSlidingUpPanel(),
        ),
        body: buildBodyPage(),
      ),
    );
  }

  Widget buildSlidingUpPanel() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        children: [
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
            itemCount: leaderboardData.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final user = leaderboardData[index];
              return AvatarCard(
                name: user['user'], // Sesuaikan dengan field dari API
                score: user['skor'].toString(), // Sesuaikan dengan field dari API
                rank: index + 1, // Rank berdasarkan urutan
                avatarNumber: index + 1, // Avatar number based on rank
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildBodyPage() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: greenBackgroundColor,
      ),
      child: Column(
        children: [
          buildTopNavigationToggle(),
          SizedBox(
            height: 20,
          ),
          buildTopStats(),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              buildTime(),
            ],
          ),
          buildRanks(),
        ],
      ),
    );
  }

  Widget buildTopNavigationToggle() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 7),
      height: 38,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: toggleCategorize,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: MediaQuery.of(context).size.width / 2 - 44,
              decoration: BoxDecoration(
                color: isMingguan ? greenLightColor : greenBackgroundColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  'Mingguan',
                  style: isMingguan
                      ? WhiteRubikTextStyle.copyWith(
                          fontSize: 16,
                        )
                      : GreenRubikTextStyle.copyWith(
                          fontSize: 16,
                        ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          InkWell(
            onTap: toggleCategorize,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: MediaQuery.of(context).size.width / 2 - 44,
              decoration: BoxDecoration(
                color: isMingguan ? greenBackgroundColor : greenLightColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  'Semua',
                  style: isMingguan
                      ? GreenRubikTextStyle.copyWith(
                          fontSize: 16,
                        )
                      : WhiteRubikTextStyle.copyWith(
                          fontSize: 16,
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTopStats() {
    return Container(
      height: 78,
      decoration: BoxDecoration(
        color: orangeColor,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 56,
            width: 56,
            margin: EdgeInsets.only(top: 10, left: 5, bottom: 10),
            decoration: BoxDecoration(
              color: darkOrangeColor,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Center(
              child: Text(
                '#2',
                style: WhiteInterTextStyle.copyWith(
                  fontSize: 24,
                  fontWeight: medium,
                ),
              ),
            ),
          ),
          Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width - 170),
            child: Text(
              'Kamu melakukan lebih baik dari 60% player lain!',
              style: WhiteRubikTextStyle.copyWith(
                fontWeight: medium,
                fontSize: 14,
              ),
            ),
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
            '3 Hari lagi',
            style: WhiteInterTextStyle.copyWith(
              fontWeight: medium,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRanks() {
    return leaderboardData.isNotEmpty
        ? Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                leaderboardData.length > 1
                    ? buildRank(
                        2,
                        2,
                        leaderboardData[1]['user'],
                        leaderboardData[1]['skor'].toString(),
                      )
                    : Container(),
                leaderboardData.isNotEmpty
                    ? buildRank(
                        1,
                        1,
                        leaderboardData[0]['user'],
                        leaderboardData[0]['skor'].toString(),
                      )
                    : Container(),
                leaderboardData.length > 2
                    ? buildRank(
                        3,
                        3,
                        leaderboardData[2]['user'],
                        leaderboardData[2]['skor'].toString(),
                      )
                    : Container(),
              ],
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }

  Widget buildRank(int numberAvatar, int numberRank, String name, String point) {
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

  String getImageRankPath(int numberPath) {
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
}
