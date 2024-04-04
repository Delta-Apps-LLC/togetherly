import 'dart:async';
import 'dart:io';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:togetherly/services/chore_service.dart';
import 'package:togetherly/utilities/env.dart';

import 'chore_service_test.mocks.dart';

@GenerateMocks([SupabaseClient, SupabaseQueryBuilder, PostgrestFilterBuilder])
void main() {
  late MockPostgrestFilterBuilder<List<Map<String, dynamic>>> selectBuilder;
  late ChoreService choreService;

  setUp(() async {
    final supabaseClient = MockSupabaseClient();
    final queryBuilder = MockSupabaseQueryBuilder();
    selectBuilder = MockPostgrestFilterBuilder();

    when(supabaseClient.from(any)).thenAnswer((_) => queryBuilder);
    when(queryBuilder.select(any)).thenAnswer((_) => selectBuilder);

    choreService = ChoreService(supabaseClient);
  });

  test('Get chores by family', () async {
    when(selectBuilder.eq('family_id', 1)).thenAnswer((_) => selectBuilder);
    when(selectBuilder.then(any, onError: anyNamed('onError')))
        .thenAnswer((realInvocation) async {
          final onValue = realInvocation.positionalArguments[0] as FutureOr Function(List<Map<String, dynamic>>);
          // final onError = realInvocation.namedArguments['onError'] as Function?;
          return onValue([]);
    });

    final result = await choreService.getChoresByFamily(1);
    print(result);
  });
}
