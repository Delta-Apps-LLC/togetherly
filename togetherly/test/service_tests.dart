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
import 'package:togetherly/utilities/value.dart';

import 'service_tests.mocks.dart';

/// Helper function for stubbing the result of a query.
ThenPostExpectation<T> whenExecuted<T>(MockPostgrestFilterBuilder<T> mock) {
  return ThenPostExpectation(
      when(mock.then(any, onError: anyNamed('onError'))));
}

/// Helper class for stubbing the result of a query.
class ThenPostExpectation<T> {
  final PostExpectation<Future<dynamic>> wrapped;

  ThenPostExpectation(this.wrapped);

  void thenCompleteWith(Future<T> result) {
    wrapped.thenAnswer((realInvocation) async {
      final onValue =
          realInvocation.positionalArguments[0] as FutureOr Function(T);
      final onError = realInvocation.namedArguments['onError'] as Function?;
      return result.then(onValue, onError: onError);
    });
  }
}

@GenerateMocks([SupabaseClient, SupabaseQueryBuilder, PostgrestFilterBuilder])
void main() {
  const testFamilyId = 12;

  late MockSupabaseClient supabaseClient;
  late MockSupabaseQueryBuilder queryBuilder;
  late MockPostgrestFilterBuilder<List<Map<String, dynamic>>> selectBuilder;
  late MockPostgrestFilterBuilder<dynamic> filterBuilder;

  setUp(() async {
    supabaseClient = MockSupabaseClient();
    queryBuilder = MockSupabaseQueryBuilder();
    selectBuilder = MockPostgrestFilterBuilder();
    filterBuilder = MockPostgrestFilterBuilder();

    when(supabaseClient.from(any)).thenAnswer((_) => queryBuilder);
    when(queryBuilder.insert(any)).thenAnswer((_) => filterBuilder);
    when(queryBuilder.select(any)).thenAnswer((_) => selectBuilder);
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

    final testNewChore1 = Chore(
      title: "Title",
      description: "Description",
      dueDate: DateTime(2040),
      points: 42,
      isShared: true,
    );
    final testNewChore2 = Chore(
      title: "Title2",
      description: "Description2",
      dueDate: DateTime(2042),
      points: 43,
      isShared: false,
    );
    final testChore1 = testNewChore1.copyWith(id: const Value(5));
    final testChore2 = testNewChore2.copyWith(id: const Value(6));

    final testNewChore1Map = Map<String, dynamic>.unmodifiable({
      "family_id": testFamilyId,
      "title": "Title",
      "description": "Description",
      "points": 42,
      "shared": true,
      "date_due": "2040-01-01 00:00:00.000",
    });
    final testNewChore2Map = Map<String, dynamic>.unmodifiable({
      "family_id": testFamilyId,
      "title": "Title2",
      "description": "Description2",
      "points": 43,
      "shared": false,
      "date_due": "2042-01-01 00:00:00.000",
    });
    final testChore1Map =
        Map<String, dynamic>.unmodifiable(Map.of(testNewChore1Map)
          ..addAll({"id": 5, "date_due": "2040-01-01 00:00:00"})
          ..remove("family_id"));
    final testChore2Map =
        Map<String, dynamic>.unmodifiable(Map.of(testNewChore2Map)
          ..addAll({"id": 6, "date_due": "2042-01-01 00:00:00"})
          ..remove("family_id"));

    setUp(() => choreService = ChoreService(supabaseClient));

    test('getChoresByFamily should return all chores', () async {
      when(selectBuilder.eq('family_id', testFamilyId))
          .thenAnswer((_) => selectBuilder);
      whenExecuted(selectBuilder)
          .thenCompleteWith(Future.value([testChore1Map, testChore2Map]));

      final expected = [testChore1, testChore2];
      final actual = await choreService.getChoresByFamily(testFamilyId);

      expect(actual, expected);
    });

    test('insertChore should insert data and return chore', () async {
      when(filterBuilder.select('*')).thenAnswer((_) => selectBuilder);
      whenExecuted(selectBuilder)
          .thenCompleteWith(Future.value([testChore1Map]));

      final expected = testChore1;
      final actual = await choreService.insertChore(
          testFamilyId, testChore1.copyWith(id: const Value(null)));

      expect(actual, expected);
      verify(queryBuilder.insert(testNewChore1Map));
    });

    test('deleteChore should match against id', () async {
      when(filterBuilder.match(any)).thenAnswer((_) => filterBuilder);
      whenExecuted(filterBuilder).thenCompleteWith(Future.value());

      await choreService.deleteChore(testChore1);

      verify(filterBuilder.match({"id": 5}));
    });
  });

  // TODO: Add similar tests for other services.
}
