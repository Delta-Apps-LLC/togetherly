import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:togetherly/providers/chore_provider.dart';
import 'package:togetherly/providers/scaffold_provider.dart';
import 'package:togetherly/providers/simple_change_notifier_proxy_provider.dart';
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
        // Add to this section any providers that only maintain state.
        // ChangeNotifierProvider<ExampleProvider>(
        //     create: (_) => ExampleProvider(exampleService)),
        ChangeNotifierProvider<ScaffoldProvider>(
            create: (_) => ScaffoldProvider()),
        ChangeNotifierProvider<UserIdentityProvider>(
            create: (_) => UserIdentityProvider()),

        // Add to this section any providers that both maintain their own state
        // and depend upon the state of other providers.
        SimpleChangeNotifierProxyProvider<UserIdentityProvider, ChoreProvider>(
            create: (_, userIdentityProvider) =>
                ChoreProvider(_choreService, userIdentityProvider),
            update: (_, userIdentityProvider, previous) =>
                previous.updateDependencies(userIdentityProvider)),

      ],
      child: widget.child,
    );
  }
}
