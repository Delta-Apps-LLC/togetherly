import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:togetherly/providers/chore_provider.dart';
import 'package:togetherly/providers/reward_provider.dart';
import 'package:togetherly/providers/scaffold_provider.dart';
import 'package:togetherly/providers/simple_change_notifier_proxy_provider.dart';
import 'package:togetherly/providers/user_identity_provider.dart';
import 'package:togetherly/services/chore_service.dart';
import 'package:togetherly/services/reward_service.dart';

class AppProviders extends StatefulWidget {
  final Widget child;

  const AppProviders({required this.child, super.key});

  @override
  State<AppProviders> createState() => _AppProvidersState();
}

class _AppProvidersState extends State<AppProviders> {
  // final ExampleService _exampleService = ExampleServiceImpl();
  final ChoreService _choreService = ChoreService();
  final RewardService _rewardService = RewardService();

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
        // SimpleChangeNotifierProxyProvider<OtherProvider, ExampleProvider>(
        //     create: (_, otherProvider) =>
        //         ExampleProvider(exampleService, otherProvider),
        //     update: (_, otherProvider, previous) =>
        //         previous.updateDependencies(otherProvider)),
        SimpleChangeNotifierProxyProvider<UserIdentityProvider, ChoreProvider>(
            create: (_, userIdentityProvider) =>
                ChoreProvider(_choreService, userIdentityProvider),
            update: (_, userIdentityProvider, previous) =>
                previous.updateDependencies(userIdentityProvider)),
        SimpleChangeNotifierProxyProvider<UserIdentityProvider, RewardProvider>(
          create: (_, userIdentityProvider) =>
              RewardProvider(_rewardService, userIdentityProvider),
          update: (_, userIdentityProvider, previous) =>
              previous.updateDependencies(userIdentityProvider),
        ),

        // Add to this section any providers that only transform the state of
        // other providers.
        // ProxyProvider<OtherProvider, ExampleProvider>(
        //     update: (_, otherProvider, __) =>
        //         ExampleProvider(otherProvider)),
      ],
      child: widget.child,
    );
  }
}
