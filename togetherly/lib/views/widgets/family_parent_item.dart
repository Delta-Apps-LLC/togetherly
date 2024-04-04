import 'package:flutter/material.dart';
import 'package:togetherly/models/parent.dart';
import 'package:togetherly/models/person.dart';
import 'package:togetherly/themes.dart';

class FamilyParentItem extends StatelessWidget {
  const FamilyParentItem({super.key, required this.parent});
  final Parent parent;

  Widget getAvatar(Parent parent) {
    String image = switch (parent.icon) {
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
    return Container(
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
                  getAvatar(parent),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    parent.name,
                    style: AppTextStyles.brandBodyLarge.copyWith(fontSize: 22),
                  ),
                ],
              ),
              const Icon(
                Icons.admin_panel_settings,
                color: AppColors.brandBlue,
                size: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
