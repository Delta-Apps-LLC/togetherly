import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togetherly/models/child.dart';
import 'package:togetherly/providers/person_provider.dart';
import 'package:togetherly/providers/scaffold_provider.dart';
import 'package:togetherly/themes.dart';

class Points extends StatelessWidget {
  const Points({super.key});

  @override
  Widget build(BuildContext context) {
    int? getPoints(PersonProvider personProvider) {
      final scaffoldProvider =
          Provider.of<ScaffoldProvider>(context, listen: false);
      if (personProvider.currentPerson is Child) {
        return (personProvider.currentPerson as Child).totalPoints;
      }
      return scaffoldProvider.childBeingViewed?.totalPoints;
    }

    return Consumer<PersonProvider>(
      builder: (context, personProvider, child) => Center(
        child: SizedBox(
          height: 40,
          width: 80,
          child: PhysicalModel(
            color: AppColors.brandWhite,
            borderRadius: BorderRadius.circular(40),
            elevation: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(
                  Icons.bolt,
                  size: 32,
                  color: AppColors.brandGold,
                ),
                Text(
                  getPoints(personProvider).toString(),
                  style: AppTextStyles.brandAccentLarge.copyWith(fontSize: 22),
                ),
                const SizedBox(
                  width: 8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
