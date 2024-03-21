import 'package:flutter/material.dart';
import 'package:togetherly/themes.dart';

class ChildLoginDialog extends StatefulWidget {
  const ChildLoginDialog({super.key});

  @override
  State<ChildLoginDialog> createState() => _ChildLoginDialogState();
}

class _ChildLoginDialogState extends State<ChildLoginDialog> {
  bool _loading = false;

  void login(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Align(
        alignment: Alignment.center,
        child: Text(
          'Child Login',
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
                  'Save',
                  style: AppTextStyles.brandAccent,
                ),
        ),
      ],
    );
  }
}
