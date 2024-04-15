import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togetherly/models/reward.dart';
import 'package:togetherly/providers/person_provider.dart';
import 'package:togetherly/providers/reward_provider.dart';
import 'package:togetherly/themes.dart';

class RewardDialog extends StatefulWidget {
  const RewardDialog({super.key, required this.reward});
  final Reward reward;

  @override
  State<RewardDialog> createState() => _RewardDialogState();
}

class _RewardDialogState extends State<RewardDialog> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    Future<void> redeemReward(BuildContext context) async {
      final rewardProvider =
          Provider.of<RewardProvider>(context, listen: false);
      final personProvider =
          Provider.of<PersonProvider>(context, listen: false);
      if (widget.reward.points > personProvider.currentChild!.totalPoints) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text(
            'You need more points to redeem this reward',
            style: AppTextStyles.brandAccentLarge,
          ),
          duration: const Duration(seconds: 3),
          backgroundColor: AppColors.errorRed,
          behavior: SnackBarBehavior.floating,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.8),
        ));
      } else {
        setState(() => loading = true);
        await rewardProvider.redeemReward(
            widget.reward, 1, personProvider.currentChild!);
        setState(() => loading = false);
        Navigator.of(context).pop();
      }
    }

    return AlertDialog(
      title: Text(
        widget.reward.title,
        style: AppTextStyles.brandHeading,
      ),
      content: Text(
        'Do you want to redeem this reward for ${widget.reward.points.toString()} points?',
        style: AppTextStyles.brandBody,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'Cancel',
            style: AppTextStyles.brandAccent,
          ),
        ),
        ElevatedButton(
          style: AppWidgetStyles.submitButton,
          onPressed: () => redeemReward(context),
          child: loading
              ? const CircularProgressIndicator()
              : const Text(
                  'Redeem',
                  style: AppTextStyles.brandAccent,
                ),
        ),
      ],
    );
  }
}
