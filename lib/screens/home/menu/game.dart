import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:login_signup/screens/home/menu/leaderboard.dart';
import 'package:login_signup/theme/new_theme.dart';
import 'package:login_signup/widgets/gamification/card.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  String currentCategory = 'Tren';

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
            'Game',
            style: WhiteInterTextStyle.copyWith(
              fontWeight: semiBold,
              fontSize: 20,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: whiteBackgroundColor),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: buildBodyPage());
  }

  Widget buildContentCard() {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),
      height: MediaQuery.of(context).size.height / 1.4,
      width: double.infinity,
      decoration: BoxDecoration(
        color: whiteBackgroundColor,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: greenLightColor,
            ),
          ),
          buildTopNavigationToggle(),
          SizedBox(
            height: 24,
          ),
          buildQuizContent(),
          SizedBox(
            height: 24,
          ),
          buildFriendsContent(),
        ],
      ),
    );
  }

  Widget buildBodyPage() {
    return Container(
      height: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSearch(),
          SizedBox(
            height: 30,
          ),
          buildContentCard(),
        ],
      ),
    );
  }

  Widget buildTopNavigationToggle() {
    return Container(
      margin: EdgeInsets.only(
        top: 7,
        left: 7,
        right: 7,
      ),
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () => toggleCategorize('Tren'),
            child: Container(
              child: Center(
                child: Text(
                  'Tren',
                  style: currentCategory == 'Tren'
                      ? TextStyle(
                          color: Colors.green, // Teks hijau jika aktif
                          fontSize: 14,
                        )
                      : TextStyle(
                          color: Colors.grey, // Teks abu-abu jika tidak aktif
                          fontSize: 14,
                        ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              toggleCategorize('Quiz');
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => QuizSelectionPage()),
              // );
            },
            child: Container(
              child: Center(
                child: Text(
                  'Quiz',
                  style: currentCategory == 'Quiz'
                      ? TextStyle(
                          color: Colors.green,
                          fontSize: 14,
                        )
                      : TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          InkWell(
            onTap: () => toggleCategorize('Kategori'),
            child: Container(
              child: Center(
                child: Text(
                  'Kategori',
                  style: currentCategory == 'Kategori'
                      ? TextStyle(
                          color: Colors.green,
                          fontSize: 14,
                        )
                      : TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LeaderboardPage()),
              );
            },
            child: Container(
              child: Center(
                child: Text(
                  'Leaderboard',
                  style: currentCategory == 'Leaderboard'
                      ? TextStyle(
                          color: Colors.green,
                          fontSize: 14,
                        )
                      : TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSearch() {
    return Container(
      height: 56,
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width / 4,
      decoration: BoxDecoration(
        color: greenLightColor,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            color: whiteBackgroundColor,
            size: 24,
          ),
        ],
      ),
    );
  }

  Widget buildQuizContent() {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Quiz',
                style: BlackRubikTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: medium,
                ),
              ),
              Text(
                'Lihat Semua',
                style: GreenRubikTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: medium,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            height: 180,
            child: listBuilderQuiz(),
          ),
        ],
      ),
    );
  }

  Widget listBuilderQuiz() {
    return ListView.builder(
      itemCount: 4,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return buildQuizCard();
      },
    );
  }

  Widget buildQuizCard() {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: greyBackgroundColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Perawatan Kopi',
                style: BlackRubikTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
              ),
              Text(
                'Kopi • 12 Quiz',
                style: GreyRubikTextStyle.copyWith(
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Transform.rotate(
            angle: 3.14,
            child: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: purpleColor,
              size: 12,
            ),
          )
        ],
      ),
    );
  }

  Widget buildFriendsContent() {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Teman',
                style: BlackRubikTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: medium,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            height: 210,
            child: listBuilderAvatar(),
          ),
        ],
      ),
    );
  }

  Widget listBuilderAvatar() {
    return ListView.builder(
      itemCount: 4,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return AvatarNonCard();
      },
    );
  }

  String getImageRankPath(numberPath) {
    switch (numberPath) {
      case 1:
        return 'assets/rank1nd.png';
      case 2:
        return 'assets/rank2nd.png';
      case 3:
        return 'assets/rank3nd.png';
      default:
        return '';
    }
  }

  void toggleCategorize(String category) {
    setState(() {
      currentCategory = category;
    });
  }
}
