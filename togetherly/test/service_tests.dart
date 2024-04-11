import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:togetherly/models/child.dart';
import 'package:togetherly/models/chore.dart';
import 'package:togetherly/models/parent.dart';
import 'package:togetherly/models/person.dart';
import 'package:togetherly/services/chore_service.dart';
import 'package:togetherly/services/person_service.dart';

import 'service_tests.mocks.dart';

@GenerateMocks([SupabaseClient, SupabaseQueryBuilder, PostgrestFilterBuilder])
void main() {
  late MockSupabaseClient supabaseClient;
  late MockPostgrestFilterBuilder<List<Map<String, dynamic>>> filterBuilder;

  setUp(() async {
    supabaseClient = MockSupabaseClient();
    final queryBuilder = MockSupabaseQueryBuilder();
    filterBuilder = MockPostgrestFilterBuilder();

    when(supabaseClient.from(any)).thenAnswer((_) => queryBuilder);
    when(queryBuilder.insert(any)).thenAnswer((_) => filterBuilder);
    when(queryBuilder.select(any)).thenAnswer((_) => filterBuilder);
    when(queryBuilder.update(any)).thenAnswer((_) => filterBuilder);
    when(queryBuilder.delete()).thenAnswer((_) => filterBuilder);
  });

  group("PersonService tests", () {
    late PersonService personService;
    setUp(() => personService = PersonService(supabaseClient));

    test('getChildren', () async {
      final result = await personService.getChildren(1);
      debugPrint("$result");
    });

    test('getParents', () async {
      final result = await personService.getParents(1);
      debugPrint("$result");
    });

    test('insertChild', () async {
      final result = await personService.insertChild(const Child(
          familyId: 1,
          pin: "1234",
          name: "John",
          icon: ProfileIcon.dog,
          totalPoints: 10));
      debugPrint("$result");
      await personService.deletePerson(result);
    });

    test('insertParent', () async {
      final result = await personService.insertParent(const Parent(
          familyId: 1, pin: "1234", name: "John", icon: ProfileIcon.dog));
      debugPrint("$result");
      await personService.deletePerson(result);
    });
  });

  group("ChoreService tests", () {
    late ChoreService choreService;
    setUp(() => choreService = ChoreService(supabaseClient));

    test('getChoresByFamily', () async {
      final result = await choreService.getChoresByFamily(1);
      debugPrint("$result");
    });

    test('insertChore', () async {
      final result = await choreService.insertChore(
          1,
          Chore(
            title: "Test",
            dueDate: DateTime(2030),
            points: 10,
            isShared: true,
          ));
      debugPrint("$result");
      await choreService.deleteChore(result);
    });
  });

  // TODO: Add similar tests for other services.
}
