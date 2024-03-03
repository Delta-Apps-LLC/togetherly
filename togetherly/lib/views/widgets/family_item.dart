import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togetherly/models/child.dart';
import 'package:togetherly/models/person.dart';
import 'package:togetherly/providers/scaffold_provider.dart';
import 'package:togetherly/themes.dart';

class FamilyItem extends StatelessWidget {
  const FamilyItem({super.key, required this.member});
  final Child member;

  Widget getAvatar(Child child) {
    Widget avatar = const Placeholder();
    String image = '';
    switch (member.icon) {
      case ProfileIcon.bear:
        image = 'bear';
        break;
      case ProfileIcon.cat:
        image = 'cat';
        break;
      case ProfileIcon.chicken:
        image = 'bear';
        break;
      case ProfileIcon.dog:
        image = 'dog';
        break;
      case ProfileIcon.fish:
        image = 'fish';
        break;
      case ProfileIcon.fox:
        image = 'fox';
        break;
      case ProfileIcon.giraffe:
        image = 'giraffe';
        break;
      case ProfileIcon.gorilla:
        image = 'gorilla';
        break;
      case ProfileIcon.koala:
        image = 'koala';
        break;
      case ProfileIcon.panda:
        image = 'panda';
        break;
      case ProfileIcon.rabbit:
        image = 'rabbit';
        break;
      case ProfileIcon.tiger:
        image = 'tiger';
        break;
    }
    avatar = Image.asset(
      'assets/images/avatars/$image.png',
      width: 60,
    );
    return avatar;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ScaffoldProvider>(context, listen: false);

    return InkWell(
      onTap: () => {provider.setAppBarTitle('Chores')},
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
                      member.totalPoints.toString(),
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
