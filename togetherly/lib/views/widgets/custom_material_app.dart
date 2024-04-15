import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togetherly/providers/app_providers.dart';
import 'package:togetherly/providers/auth_provider.dart';
import 'package:togetherly/views/screens/auth.dart';
import 'package:togetherly/views/screens/login.dart';

class CustomMaterialApp extends StatelessWidget {
  const CustomMaterialApp({super.key, this.page});

  final Widget? page;

  @override
  Widget build(BuildContext context) {
    return AppProviders(
      child: MaterialApp(
          title: 'Togetherly',
          home: Consumer<AuthProvider>(
            builder: (context, authProvider, child) => (authProvider.user == null)
                ? const LoginPage()
                : AuthPage(page: page)
          )),
    );
  }
}
