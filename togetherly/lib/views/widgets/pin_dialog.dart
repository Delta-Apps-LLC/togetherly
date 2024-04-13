import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:togetherly/models/person.dart';
import 'package:togetherly/providers/user_identity_provider.dart';
import 'package:togetherly/themes.dart';

class PinDialog extends StatefulWidget {
  const PinDialog({super.key, required this.person});
  final Person person;

  @override
  State<PinDialog> createState() => _PinDialogState();
}

class _PinDialogState extends State<PinDialog> {
  final _formKey = GlobalKey<FormState>();
  String pin = '';
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    void selectProfile() async {
      final userProvider =
          Provider.of<UserIdentityProvider>(context, listen: false);
      if (_formKey.currentState!.validate()) {
        setState(() => _loading = true);
        await userProvider.setPersonId(widget.person.id);
        setState(() => _loading = false);
        Navigator.of(context).pop();
      }
    }

    return AlertDialog(
      title: const Text(
        'Enter Your PIN',
        style: AppTextStyles.brandHeading,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Form(
            key: _formKey,
            child: TextFormField(
              maxLength: 5,
              obscureText: true,
              initialValue: pin,
              decoration: const InputDecoration(
                labelText: 'Enter your PIN',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (value) => setState(() => pin = value.toString()),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your PIN';
                } else if (value != widget.person.pin) {
                  return 'Incorrect PIN';
                }
                return null;
              },
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'Close',
            style: AppTextStyles.brandAccent,
          ),
        ),
        ElevatedButton(
          style: AppWidgetStyles.submitButton,
          onPressed: () => selectProfile(),
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
