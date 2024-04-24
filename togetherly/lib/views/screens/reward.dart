import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togetherly/models/child.dart';
import 'package:togetherly/providers/person_provider.dart';
import 'package:togetherly/providers/scaffold_provider.dart';
import 'package:togetherly/themes.dart';
import 'package:togetherly/views/widgets/points.dart';
import 'package:togetherly/views/widgets/reward_grid.dart';

class RewardPage extends StatelessWidget {
  const RewardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ScaffoldProvider>(
      builder: (context, scaffoldProvider, child) => Padding(
        padding: AppWidgetStyles.appPadding,
        child: Consumer<PersonProvider>(
          builder: (context, personProvider, child) => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (personProvider.currentPerson is Child ||
                  scaffoldProvider.childBeingViewed != null)
                const Center(
                  child: Points(),
                ),
              const SizedBox(
                height: 12,
              ),
              const RewardGrid(),
              const SizedBox(
                height: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
