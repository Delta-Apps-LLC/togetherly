import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:togetherly/providers/auth_provider.dart';
import 'package:togetherly/providers/chore_provider.dart';
import 'package:togetherly/providers/family_provider.dart';
import 'package:togetherly/providers/person_provider.dart';
import 'package:togetherly/providers/reward_provider.dart';
import 'package:togetherly/providers/scaffold_provider.dart';
import 'package:togetherly/providers/simple_change_notifier_proxy_provider.dart';
import 'package:togetherly/providers/user_identity_provider.dart';
import 'package:togetherly/services/auth_service.dart';
import 'package:togetherly/services/assignment_service.dart';
import 'package:togetherly/services/chore_completion_service.dart';
import 'package:togetherly/services/chore_service.dart';
import 'package:togetherly/services/family_service.dart';
import 'package:togetherly/services/person_service.dart';
import 'package:togetherly/services/reward_redemption_service.dart';
import 'package:togetherly/services/reward_service.dart';

class AppProviders extends StatefulWidget {
  final Widget child;

  const AppProviders({required this.child, super.key});

  @override
  State<AppProviders> createState() => _AppProvidersState();
}

class _AppProvidersState extends State<AppProviders> {
  // final ExampleService _exampleService = ExampleServiceImpl();
  final PersonService _personService = PersonService();
  final ChoreService _choreService = ChoreService(Supabase.instance.client);
  final AssignmentService _assignmentService = AssignmentService();
  final ChoreCompletionService _choreCompletionService =
      ChoreCompletionService();
  final RewardService _rewardService = RewardService();
  final RewardRedemptionService _rewardRedemptionService =
      RewardRedemptionService();
  final AuthService _authService = AuthService();
  final FamilyService _familyService = FamilyService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Add to this section any providers that only maintain state.
        // ChangeNotifierProvider<ExampleProvider>(
        //     create: (_) => ExampleProvider(exampleService)),
        ChangeNotifierProvider<ScaffoldProvider>(
            create: (_) => ScaffoldProvider()),
        ChangeNotifierProvider<AuthProvider>(
            create: (_) => AuthProvider(_authService)),

        // Add to this section any providers that both maintain their own state
        // and depend upon the state of other providers.
        // SimpleChangeNotifierProxyProvider<OtherProvider, ExampleProvider>(
        //     create: (_, otherProvider) =>
        //         ExampleProvider(exampleService, otherProvider),
        //     update: (_, otherProvider, previous) =>
        //         previous.updateDependencies(otherProvider)),
        SimpleChangeNotifierProxyProvider<AuthProvider, UserIdentityProvider>(
          create: (_, authProvider) => UserIdentityProvider(authProvider),
          update: (_, authProvider, previous) =>
              previous.updateDependencies(authProvider),
        ),
        SimpleChangeNotifierProxyProvider<UserIdentityProvider, PersonProvider>(
            create: (_, userIdentityProvider) =>
                PersonProvider(_personService, userIdentityProvider),
            update: (_, userIdentityProvider, previous) =>
                previous.updateDependencies(userIdentityProvider)),
        SimpleChangeNotifierProxyProvider<UserIdentityProvider, ChoreProvider>(
            create: (_, userIdentityProvider) => ChoreProvider(
                _choreService,
                _assignmentService,
                _choreCompletionService,
                userIdentityProvider),
            update: (_, userIdentityProvider, previous) =>
                previous.updateDependencies(userIdentityProvider)),
        SimpleChangeNotifierProxyProvider2<UserIdentityProvider, PersonProvider,
            RewardProvider>(
          create: (_, userIdentityProvider, personProvider) => RewardProvider(
              _rewardService,
              _rewardRedemptionService,
              userIdentityProvider,
              personProvider),
          update: (_, userIdentityProvider, personProvider, previous) =>
              previous.updateDependencies(userIdentityProvider, personProvider),
        ),
        SimpleChangeNotifierProxyProvider2<UserIdentityProvider, AuthProvider, FamilyProvider>(
            create: (_, userIdentityProvider, authProvider) => FamilyProvider(
                _familyService, userIdentityProvider, authProvider),
            update: (_, userIdentityProvider, authProvider, previous) =>
                previous.updateDependencies(userIdentityProvider, authProvider)),

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
