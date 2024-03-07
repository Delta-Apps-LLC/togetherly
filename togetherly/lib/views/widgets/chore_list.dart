import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:togetherly/providers/chore_provider.dart';
import 'package:togetherly/providers/user_identity_provider.dart';
import 'package:togetherly/themes.dart';
import 'package:togetherly/views/widgets/chore_item.dart';

class ChoreList extends StatelessWidget {
  const ChoreList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ChoreProvider, UserIdentityProvider>( // TODO: Create proxy provider that takes care of handling these two providers together.
      builder: (context, choreProvider, userIdentityProvider, child) => Column(
        mainAxisAlignment: MainAxisAlignment.start, // Aligns to center
        crossAxisAlignment: CrossAxisAlignment.start, // Aligns to left
        children: <Widget>[
          const Text(
            'Today',
            style: AppTextStyles.brandAccentLarge,
          ),
          Column(
            children: choreProvider
                .choresAssignedToPerson(userIdentityProvider.personId ?? 1) // TODO: Properly respond to not having a person ID
                .map((chore) => ChoreItem(chore: chore)).toList(),
          ),
        ],
      ),
    );
  }
}
