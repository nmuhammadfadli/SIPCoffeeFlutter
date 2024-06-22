import 'package:flutter/material.dart';
import 'package:login_signup/theme/new_theme.dart';
import 'package:login_signup/widgets/gamification/avatar.dart';

class AvatarCard extends StatelessWidget {
  final String name;
  final String score;
  final int rank;
  final int avatarNumber;

  const AvatarCard({
    super.key,
    required this.name,
    required this.score,
    required this.rank,
    required this.avatarNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      width: double.infinity,
      height: 92,
      padding: EdgeInsets.only(
        top: 16,
        left: 16,
        bottom: 16,
        right: MediaQuery.of(context).size.width / 3,
      ),
      decoration: BoxDecoration(
        color: whiteBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: greyBackgroundColor,
            ),
            child: Center(
              child: Text(
                rank.toString(),
                overflow: TextOverflow.ellipsis,
                style: GreenRubikTextStyle.copyWith(
                  fontWeight: medium,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 2,
          ),
          AvatarProfile(numberAvatar: avatarNumber),
          SizedBox(
            width: 2,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: BlackRubikTextStyle.copyWith(
                    fontWeight: medium, fontSize: 16),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '$score Poin',
                style: GreyRubikTextStyle.copyWith(fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AvatarNonCard extends StatelessWidget {
  final String name;
  final String score;
  final int avatarNumber;

  const AvatarNonCard({
    super.key,
    required this.name,
    required this.score,
    required this.avatarNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 75,
      padding: EdgeInsets.only(
        bottom: 16,
        right: MediaQuery.of(context).size.width / 3,
      ),
      decoration: BoxDecoration(
        color: whiteBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 2,
          ),
          AvatarProfile(numberAvatar: avatarNumber),
          SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: BlackRubikTextStyle.copyWith(
                    fontWeight: medium, fontSize: 16),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '$score Poin',
                style: GreyRubikTextStyle.copyWith(fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LahanRankCard extends StatefulWidget {
  final int index;
  final String namaLahan;
  final String poinLahan;
  const LahanRankCard(
      {required this.index,
      required this.namaLahan,
      required this.poinLahan,
      super.key});

  @override
  State<LahanRankCard> createState() => _LahanRankCardState();
}

class _LahanRankCardState extends State<LahanRankCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      width: double.infinity,
      height: 92,
      padding: EdgeInsets.only(
        top: 16,
        left: 16,
        bottom: 16,
        right: MediaQuery.of(context).size.width / 9,
      ),
      decoration: BoxDecoration(
        color: whiteBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: greyBackgroundColor,
            ),
            child: Center(
              child: Text(
                widget.index.toString(),
                style: GreenRubikTextStyle.copyWith(
                  fontWeight: medium,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 2,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.namaLahan,
                style: BlackRubikTextStyle.copyWith(
                    fontWeight: medium, fontSize: 16),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                widget.poinLahan+' Poin',
                style: GreyRubikTextStyle.copyWith(fontSize: 14),
              ),
            ],
          ),
          SizedBox(
            width: 36,
          ),
          Icon(
            Icons.location_on,
            size: 36,
            color: greenBackgroundColor,
          ),
        ],
      ),
    );
  }
}
