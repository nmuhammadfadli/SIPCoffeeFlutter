import 'package:flutter/material.dart';
import 'package:login_signup/theme/new_theme.dart';
import 'package:login_signup/widgets/gamification/avatar.dart';

class AvatarCard extends StatefulWidget {
  const AvatarCard({super.key});

  @override
  State<AvatarCard> createState() => _AvatarCardState();
}

class _AvatarCardState extends State<AvatarCard> {
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
                '4',
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
          AvatarProfile(numberAvatar: 1),
          SizedBox(
            width: 2,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Salma',
                style: BlackRubikTextStyle.copyWith(
                    fontWeight: medium, fontSize: 16),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '590 Poin',
                style: GreyRubikTextStyle.copyWith(fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AvatarNonCard extends StatefulWidget {
  const AvatarNonCard({super.key});

  @override
  State<AvatarNonCard> createState() => _AvatarNonCardState();
}

class _AvatarNonCardState extends State<AvatarNonCard> {
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
          AvatarProfile(numberAvatar: 1),
          SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Salma',
                style: BlackRubikTextStyle.copyWith(
                    fontWeight: medium, fontSize: 16),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '590 Poin',
                style: GreyRubikTextStyle.copyWith(fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
