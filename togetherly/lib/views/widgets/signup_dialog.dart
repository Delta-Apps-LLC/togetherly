import 'package:flutter/material.dart';
import 'package:togetherly/themes.dart';

class SignupDialog extends StatefulWidget {
  const SignupDialog({super.key});

  @override
  State<SignupDialog> createState() => _SignupDialogState();
}

class _SignupDialogState extends State<SignupDialog> {
  bool _loading = false;

  void signup(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Align(
        alignment: Alignment.center,
        child: Text(
          'Signup',
          style: AppTextStyles.brandHeading,
        ),
      ),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[],
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
          onPressed: () => signup(context),
          child: _loading
              ? const CircularProgressIndicator()
              : const Text(
                  'Signup',
                  style: AppTextStyles.brandAccent,
                ),
        ),
      ],
    );
  }
}
