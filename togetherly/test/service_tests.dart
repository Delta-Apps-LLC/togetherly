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
import 'test_data.dart';

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
  const testData = TestData();

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
  }, skip: "Not yet finished");

  group("ChoreService tests", () {
    late ChoreService choreService;

    setUp(() => choreService = ChoreService(supabaseClient));

    test('getChoresByFamily should return all chores', () async {
      when(selectBuilder.eq('family_id', testData.familyId))
          .thenAnswer((_) => selectBuilder);
      whenExecuted(selectBuilder).thenCompleteWith(Future.value([
        testData.getMapForChore(0, id: 5),
        testData.getMapForChore(0, id: 6)
      ]));

      final expected = [
        testData.getChore(0, id: 5),
        testData.getChore(0, id: 6)
      ];
      final actual = await choreService.getChoresByFamily(testData.familyId);

      expect(actual, expected);
    });

    test('insertChore should insert data and return chore', () async {
      when(filterBuilder.select('*')).thenAnswer((_) => selectBuilder);
      whenExecuted(selectBuilder)
          .thenCompleteWith(Future.value([testData.getMapForChore(0, id: 5)]));

      final expected = testData.getChore(0, id: 5);
      final actual = await choreService.insertChore(
          testData.familyId, testData.getChore(0));

      expect(actual, expected);
      verify(queryBuilder.insert(
          testData.getMapForChore(0, includeFamilyId: true, includeMs: true)));
    });

    test('updateChore should update data', () async {
      when(filterBuilder.match(any)).thenAnswer((_) => filterBuilder);
      whenExecuted(filterBuilder).thenCompleteWith(Future.value());

      await choreService.updateChore(testData.getChore(0, id: 5));

      debugPrint(testData.getMapForChore(0, includeMs: true).toString());
      verify(queryBuilder.update(testData.getMapForChore(0, includeMs: true)));
    });

    test('deleteChore should match against id', () async {
      when(filterBuilder.match(any)).thenAnswer((_) => filterBuilder);
      whenExecuted(filterBuilder).thenCompleteWith(Future.value());

      await choreService.deleteChore(testData.getChore(0, id: 5));

      verify(filterBuilder.match({"id": 5}));
    });
  });

  // TODO: Add similar tests for other services.
}
