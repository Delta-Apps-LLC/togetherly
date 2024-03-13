import 'package:flutter/material.dart';
import 'package:togetherly/themes.dart';
import 'package:togetherly/views/widgets/points.dart';
import 'package:togetherly/views/widgets/reward_grid.dart';

class RewardPage extends StatefulWidget {
  const RewardPage({super.key});

  @override
  State<RewardPage> createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: AppWidgetStyles.appPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        // mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Center(
            child: Points(),
          ),
          SizedBox(
            height: 12,
          ),
          RewardGrid(),
          SizedBox(
            height: 2,
          ),
        ],
      ),
    );
  }
}
