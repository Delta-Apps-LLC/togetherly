import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togetherly/models/reward.dart';
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
      // final provider = Provider.of<RewardProvider>(context, listen: false);
      setState(() => loading = true);
      await Future.delayed(const Duration(seconds: 2));
      setState(() => loading = false);
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
