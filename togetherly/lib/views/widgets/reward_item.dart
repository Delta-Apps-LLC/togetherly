import 'package:flutter/material.dart';
import 'package:togetherly/models/reward.dart';
import 'package:togetherly/themes.dart';
import 'package:togetherly/views/widgets/reward_dialog.dart';

class RewardItem extends StatelessWidget {
  const RewardItem({super.key, required this.reward});
  final Reward reward;

  @override
  Widget build(BuildContext context) {
    Future<void> buildDialog(BuildContext context) {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return RewardDialog(reward: reward);
        },
      );
    }

    return InkWell(
      onTap: () => buildDialog(context),
      child: Container(
        padding: const EdgeInsets.all(8),
        height: 130,
        width: MediaQuery.of(context).size.width * 0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.brandLightGray,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              reward.title,
              style: AppTextStyles.brandAccentLarge,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 50,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  reward.description,
                  style: const TextStyle(fontSize: 30),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(
                  Icons.bolt,
                  size: 35,
                  color: AppColors.brandGold,
                ),
                Text(
                  reward.points.toString(),
                  style: AppTextStyles.brandAccentLarge.copyWith(fontSize: 22),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
