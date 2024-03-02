import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togetherly/models/child.dart';
import 'package:togetherly/models/person.dart';
import 'package:togetherly/providers/scaffold_provider.dart';
import 'package:togetherly/themes.dart';

class FamilyItem extends StatelessWidget {
  final Child member;

  const FamilyItem({super.key, required this.member});

  Widget getAvatar(Person member) {
    Widget avatar = const Placeholder();
    switch (member.icon) {
      case ProfileIcon.bear:
        avatar = Image.asset(
          'assets/images/avatars/bear.png',
          width: 60,
        );
      case ProfileIcon.cat:
        avatar = Image.asset(
          'assets/images/avatars/cat.png',
          width: 60,
        );
      case ProfileIcon.chicken:
      // TODO: Handle this case.
      case ProfileIcon.dog:
        avatar = Image.asset(
          'assets/images/avatars/dog.png',
          width: 60,
        );
      case ProfileIcon.fish:
      // TODO: Handle this case.
      case ProfileIcon.fox:
      // TODO: Handle this case.
      case ProfileIcon.giraffe:
      // TODO: Handle this case.
      case ProfileIcon.gorilla:
      // TODO: Handle this case.
      case ProfileIcon.koala:
      // TODO: Handle this case.
      case ProfileIcon.panda:
        avatar = Image.asset(
          'assets/images/avatars/panda.png',
          width: 60,
        );
      case ProfileIcon.rabbit:
      // TODO: Handle this case.
      case ProfileIcon.tiger:
      // TODO: Handle this case.
    }
    return avatar;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ScaffoldProvider>(context, listen: false);

    return InkWell(
      onTap: () => {
        provider.setAppBarTitle('Chores')
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
