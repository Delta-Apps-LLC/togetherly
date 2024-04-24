import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togetherly/providers/auth_provider.dart';
import 'package:togetherly/themes.dart';

class LoginDialog extends StatefulWidget {
  const LoginDialog({super.key});

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool _loading = false;

  void login(BuildContext context) async {
    final provider = Provider.of<AuthProvider>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      setState(() => _loading = true);
      final res = await provider.signIn(_email, _password);
      bool failed = res != null;
      if (failed) {
        print(res.message);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            res.message,
            style: AppTextStyles.brandAccentLarge,
          ),
          duration: const Duration(seconds: 3),
          backgroundColor: AppColors.errorRed,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.85),
        ));
      }
      setState(() => _loading = false);
      failed ? null : Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Align(
        alignment: Alignment.center,
        child: Text(
          'Login',
          style: AppTextStyles.brandHeading,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: _email,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  onChanged: (value) => setState(() => _email = value),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  initialValue: _password,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  onChanged: (value) => setState(() => _password = value),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
              ],
            ),
          )
        ],
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
              ? const CircularProgressIndicator(
                  color: AppColors.brandPurple,
                )
              : const Text(
                  'Login',
                  style: AppTextStyles.brandAccent,
                ),
        ),
      ],
    );
  }
}
