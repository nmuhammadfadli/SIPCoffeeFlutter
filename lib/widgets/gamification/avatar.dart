import 'package:flutter/material.dart';

class AvatarProfile extends StatelessWidget {
  final int numberAvatar;
  const AvatarProfile({
    Key? key,
    required this.numberAvatar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(getImagePath(numberAvatar)),
        ),
      ),
    );
  }

  String getImagePath(int numberAvatar) {
    switch (numberAvatar) {
      case 1:
        return 'assets/images/gamification/ic_avatar1.png';
      case 2:
        return 'assets/images/gamification/ic_avatar2.png';
      case 3:
        return 'assets/images/gamification/ic_avatar3.png';
      case 4:
        return 'assets/images/gamification/ic_avatar4.png';
      case 5:
        return 'assets/images/gamification/ic_avatar5.png';
      case 6:
        return 'assets/images/gamification/ic_avatar6.png';
      default:
        return 'assets/images/gamification/ic_avatar1.png';
    }
  }
}
