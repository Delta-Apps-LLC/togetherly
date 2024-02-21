import 'package:flutter/material.dart';
import 'package:togetherly/models/person.dart';
import 'package:togetherly/themes.dart';
import 'package:togetherly/views/screens/child_home.dart';

class FamilyItem extends StatelessWidget {
  const FamilyItem({super.key, required this.member});
  final Person member;

  Widget getAvatar(Person member) {
    Widget avatar = const Placeholder();
    switch (member.avatar) {
      case 1:
        avatar = Image.asset(
          'assets/images/avatars/bear.png',
          width: 60,
        );
      case 2:
        avatar = Image.asset(
          'assets/images/avatars/cat.png',
          width: 60,
        );
      case 3:
        avatar = Image.asset(
          'assets/images/avatars/dog.png',
          width: 60,
        );
      case 4:
        avatar = Image.asset(
          'assets/images/avatars/panda.png',
          width: 60,
        );
    }
    return avatar;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        // Extract to function above, pass in child information
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const ChildHomePage())))
      },
      child: Container(
        height: 95,
        margin: const EdgeInsets.only(top: 8),
        child: PhysicalModel(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.brandLightGray,
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 6.0, bottom: 6.0, right: 10.0, left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    getAvatar(member),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      member.name,
                      style:
                          AppTextStyles.brandBodyLarge.copyWith(fontSize: 22),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.bolt,
                      size: 35,
                      color: AppColors.brandGold,
                    ),
                    Text(
                      member.points.toString(),
                      style:
                          AppTextStyles.brandAccentLarge.copyWith(fontSize: 22),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      size: 35,
                      color: AppColors.brandBlack,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
