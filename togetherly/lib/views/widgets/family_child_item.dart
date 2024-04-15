import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togetherly/models/child.dart';
import 'package:togetherly/models/person.dart';
import 'package:togetherly/providers/scaffold_provider.dart';
import 'package:togetherly/themes.dart';

class FamilyChildItem extends StatelessWidget {
  const FamilyChildItem({super.key, required this.child});
  final Child child;

  Widget getAvatar(Child child) {
    String image = switch (child.icon) {
      ProfileIcon.bear => 'bear',
      ProfileIcon.cat => 'cat',
      ProfileIcon.chicken => 'chicken',
      ProfileIcon.dog => 'dog',
      ProfileIcon.fish => 'fish',
      ProfileIcon.fox => 'fox',
      ProfileIcon.giraffe => 'giraffe',
      ProfileIcon.gorilla => 'gorilla',
      ProfileIcon.koala => 'koala',
      ProfileIcon.panda => 'panda',
      ProfileIcon.rabbit => 'rabbit',
      ProfileIcon.tiger => 'tiger',
    };
    return Image.asset(
      'assets/images/avatars/$image.png',
      width: 50,
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ScaffoldProvider>(context, listen: false);

    return InkWell(
      onTap: () {
        provider.setScaffoldValues(
            index: null, title: child.name, type: HomePageType.child, childBeingViewed: child);
      },
      child: Container(
        height: 65,
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
                    getAvatar(child),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      child.name,
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
                      child.totalPoints.toString(),
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
