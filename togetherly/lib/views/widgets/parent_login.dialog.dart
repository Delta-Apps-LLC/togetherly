import 'package:flutter/material.dart';
import 'package:togetherly/themes.dart';

class ParentLoginDialog extends StatefulWidget {
  const ParentLoginDialog({super.key});

  @override
  State<ParentLoginDialog> createState() => _ParentLoginDialogState();
}

class _ParentLoginDialogState extends State<ParentLoginDialog> {
  bool _loading = false;

  void login(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Align(
        alignment: Alignment.center,
        child: Text(
          'Parent Login',
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
          onPressed: () => login(context),
          child: _loading
              ? const CircularProgressIndicator()
              : const Text(
                  'Login',
                  style: AppTextStyles.brandAccent,
                ),
        ),
      ],
    );
  }
}
