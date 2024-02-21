import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:togetherly/providers/example_provider.dart';
import 'package:togetherly/services/example_service.dart';

class AppProviders extends StatefulWidget {
  final Widget child;

  const AppProviders({required this.child, super.key});

  @override
  State<AppProviders> createState() => _AppProvidersState();
}

class _AppProvidersState extends State<AppProviders> {
  final ExampleService exampleService = ExampleServiceImpl();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Any additional providers that maintain app-wide state should be added
        // to this list.
        ChangeNotifierProvider<ExampleProvider>(
            create: (_) => ExampleProvider(exampleService))
      ],
      child: widget.child,
    );
  }
}
