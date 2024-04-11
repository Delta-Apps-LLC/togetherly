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
    final testChore1 = Chore(
      id: 5,
      title: "Title",
      description: "Description",
      dueDate: DateTime(2040),
      points: 42,
      isShared: true,
    );
    final testChore2 = Chore(
      id: 6,
      title: "Title2",
      description: "Description2",
      dueDate: DateTime(2042),
      points: 43,
      isShared: false,
    );

    final testChore1Map = {
      "id": 5,
      "title": "Title",
      "description": "Description",
      "points": 42,
      "shared": true,
      "date_due": "2040-01-01 00:00:00",
    };
    final testChore2Map = {
      "id": 6,
      "title": "Title2",
      "description": "Description2",
      "points": 43,
      "shared": false,
      "date_due": "2042-01-01 00:00:00",
    };

    late ChoreService choreService;
    setUp(() => choreService = ChoreService(supabaseClient));

    test('getChoresByFamily', () async {
      when(filterBuilder.eq('family_id', 12)).thenAnswer((_) => filterBuilder);
      whenExecuted(filterBuilder)
          .thenCompleteWith(Future.value([testChore1Map, testChore2Map]));

      final expected = [testChore1, testChore2];
      final actual = await choreService.getChoresByFamily(12);

      expect(actual, expected);
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
