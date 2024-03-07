import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:togetherly/providers/chore_provider.dart';
import 'package:togetherly/providers/scaffold_provider.dart';
import 'package:togetherly/providers/user_identity_provider.dart';
import 'package:togetherly/services/chore_service.dart';

class AppProviders extends StatefulWidget {
  final Widget child;

  const AppProviders({required this.child, super.key});

  @override
  State<AppProviders> createState() => _AppProvidersState();
}

class _AppProvidersState extends State<AppProviders> {
  // final ExampleService _exampleService = ExampleServiceImpl();
  final ChoreService _choreService = ChoreService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Add to this section any providers that maintain app-wide state.
        // ChangeNotifierProvider<ExampleProvider>(
        //     create: (_) => ExampleProvider(exampleService)),
        ChangeNotifierProvider<ScaffoldProvider>(
          create: (_) => ScaffoldProvider()),
        ChangeNotifierProvider<UserIdentityProvider>(
          create: (_) => UserIdentityProvider()),
        ChangeNotifierProvider<ChoreProvider>(
          create: (_) => ChoreProvider(_choreService)),

        // Add to this section any proxy providers that rely upon app-wide state.

      ],
      child: widget.child,
    );
  }
}
