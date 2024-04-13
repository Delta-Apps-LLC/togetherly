import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:togetherly/models/child.dart';
import 'package:togetherly/models/parent.dart';
import 'package:togetherly/models/person.dart';
import 'package:togetherly/services/assignment_service.dart';
import 'package:togetherly/services/auth_service.dart';
import 'package:togetherly/services/chore_completion_service.dart';
import 'package:togetherly/services/chore_service.dart';
import 'package:togetherly/services/family_service.dart';
import 'package:togetherly/services/person_service.dart';
import 'package:togetherly/services/reward_redemption_service.dart';
import 'package:togetherly/services/reward_service.dart';

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

  group("AssignmentService tests", () {
    final testData = TestAssignmentGenerator();
    late AssignmentService assignmentService;

    setUp(() => assignmentService = AssignmentService(supabaseClient));

    test('getAssignmentsByFamily should return all assignments', () async {
      when(selectBuilder.eq('family_id', testData.familyId))
          .thenAnswer((_) => selectBuilder);
      whenExecuted(selectBuilder).thenCompleteWith(
          Future.value([testData.getMap(0), testData.getMap(1)]));

      final expected = [testData.get(0), testData.get(1)];
      final actual =
          await assignmentService.getAssignmentsByFamily(testData.familyId);

      expect(actual, expected);
    });

    test('insertAssignment should insert and return assignment', () async {
      when(filterBuilder.select('*')).thenAnswer((_) => selectBuilder);
      whenExecuted(selectBuilder)
          .thenCompleteWith(Future.value([testData.getMap(2)]));

      final expected = testData.get(2);
      final actual = await assignmentService.insertAssignment(testData.get(2));

      expect(actual, expected);
      verify(queryBuilder.insert(testData.getMap(2)));
    });

    test('updateAssignment should update assignment', () async {
      when(filterBuilder.match(any)).thenAnswer((_) => filterBuilder);
      whenExecuted(filterBuilder).thenCompleteWith(Future.value());

      await assignmentService.updateAssignment(testData.get(3));

      verify(queryBuilder.update(testData.getMap(3)));
    });

    test('deleteAssignment should match against id', () async {
      when(filterBuilder.match(any)).thenAnswer((_) => filterBuilder);
      whenExecuted(filterBuilder).thenCompleteWith(Future.value());

      await assignmentService.deleteAssignment(testData.get(4));

      verify(filterBuilder.match({"person_id": 4, "chore_id": 5}));
    });
  });

  group("AuthService tests", () {
    late AuthService authService;

    setUp(() => authService = AuthService(supabaseClient));
  });

  group("ChoreService tests", () {
    final testData = TestChoreGenerator();
    late ChoreService choreService;

    setUp(() => choreService = ChoreService(supabaseClient));

    test('getChoresByFamily should return all chores', () async {
      when(selectBuilder.eq('family_id', testData.familyId))
          .thenAnswer((_) => selectBuilder);
      whenExecuted(selectBuilder).thenCompleteWith(
          Future.value([testData.getMap(0, id: 5), testData.getMap(1, id: 6)]));

      final expected = [testData.get(0, id: 5), testData.get(1, id: 6)];
      final actual = await choreService.getChoresByFamily(testData.familyId);

      expect(actual, expected);
    });

    test('insertChore should insert and return chore', () async {
      when(filterBuilder.select('*')).thenAnswer((_) => selectBuilder);
      whenExecuted(selectBuilder)
          .thenCompleteWith(Future.value([testData.getMap(2, id: 5)]));

      final expected = testData.get(2, id: 5);
      final actual =
          await choreService.insertChore(testData.familyId, testData.get(2));

      expect(actual, expected);
      verify(queryBuilder
          .insert(testData.getMap(2, includeFamilyId: true, includeMs: true)));
    });

    test('updateChore should update chore', () async {
      when(filterBuilder.match(any)).thenAnswer((_) => filterBuilder);
      whenExecuted(filterBuilder).thenCompleteWith(Future.value());

      await choreService.updateChore(testData.get(3, id: 5));

      debugPrint(testData.getMap(3, includeMs: true).toString());
      verify(queryBuilder.update(testData.getMap(3, includeMs: true)));
    });

    test('deleteChore should match against id', () async {
      when(filterBuilder.match(any)).thenAnswer((_) => filterBuilder);
      whenExecuted(filterBuilder).thenCompleteWith(Future.value());

      await choreService.deleteChore(testData.get(4, id: 5));

      verify(filterBuilder.match({"id": 5}));
    });
  });

  group("ChoreCompletionService tests", () {
    final testData = TestChoreCompletionGenerator();
    late ChoreCompletionService completionService;

    setUp(() => completionService = ChoreCompletionService(supabaseClient));

    test('getChoreCompletionsByFamily should return all chore completions',
        () async {
      when(selectBuilder.eq('family_id', testData.familyId))
          .thenAnswer((_) => selectBuilder);
      whenExecuted(selectBuilder).thenCompleteWith(
          Future.value([testData.getMap(0, id: 5), testData.getMap(1, id: 6)]));

      final expected = [testData.get(0, id: 5), testData.get(1, id: 6)];
      final actual = await completionService
          .getChoreCompletionsByFamily(testData.familyId);

      expect(actual, expected);
    });

    test('insertChoreCompletion should insert and return chore completion',
        () async {
      when(filterBuilder.select('*')).thenAnswer((_) => selectBuilder);
      whenExecuted(selectBuilder)
          .thenCompleteWith(Future.value([testData.getMap(2, id: 5)]));

      final expected = testData.get(2, id: 5);
      final actual =
          await completionService.insertChoreCompletion(testData.get(2));

      expect(actual, expected);
      debugPrint(testData.getMap(2, includeMs: true).toString());
      verify(queryBuilder.insert(testData.getMap(2, includeMs: true)));
    });

    test('updateChoreCompletion should update chore completion', () async {
      when(filterBuilder.match(any)).thenAnswer((_) => filterBuilder);
      whenExecuted(filterBuilder).thenCompleteWith(Future.value());

      await completionService.updateChoreCompletion(testData.get(3, id: 5));

      debugPrint(testData.getMap(3, includeMs: true).toString());
      verify(queryBuilder.update(testData.getMap(3, includeMs: true)));
    });

    test('deleteChoreCompletion should match against id', () async {
      when(filterBuilder.match(any)).thenAnswer((_) => filterBuilder);
      whenExecuted(filterBuilder).thenCompleteWith(Future.value());

      await completionService.deleteChoreCompletion(testData.get(4, id: 5));

      verify(filterBuilder.match({"id": 5}));
    });
  });

  group("FamilyService tests", () {
    final testData = TestFamilyGenerator();
    late FamilyService familyService;

    setUp(() => familyService = FamilyService(supabaseClient));

    test('getFamilyName should return family name', () async {
      final singleBuilder = MockPostgrestFilterBuilder<Map<String, dynamic>>();
      when(selectBuilder.eq('id', testData.familyId))
          .thenAnswer((_) => selectBuilder);
      when(selectBuilder.single()).thenAnswer((_) => singleBuilder);
      whenExecuted(singleBuilder)
          .thenCompleteWith(Future.value(testData.getMap(0)));

      final expected = testData.get(0, id: 5).name;
      final actual = await familyService.getFamilyName(testData.familyId);

      expect(actual, expected);
    });

    test('insertFamily should insert and return family', () async {
      when(filterBuilder.select('*')).thenAnswer((_) => selectBuilder);
      whenExecuted(selectBuilder)
          .thenCompleteWith(Future.value([testData.getMap(2, id: 5)]));

      final expected = testData.get(2, id: 5);
      final actual = await familyService.insertFamily(testData.get(2).name);

      expect(actual, expected);
      verify(queryBuilder.insert(testData.getMap(2)));
    });

    test('updateFamilyName should update family name', () async {
      when(filterBuilder.match(any)).thenAnswer((_) => filterBuilder);
      whenExecuted(filterBuilder).thenCompleteWith(Future.value());

      await familyService.updateFamilyName(5, testData.get(3).name);

      debugPrint(testData.getMap(3).toString());
      verify(queryBuilder.update(testData.getMap(3)));
    });

    test('deleteFamily should match against id', () async {
      when(filterBuilder.match(any)).thenAnswer((_) => filterBuilder);
      whenExecuted(filterBuilder).thenCompleteWith(Future.value());

      await familyService.deleteFamily(5);

      verify(filterBuilder.match({"id": 5}));
    });
  });

  group("PersonService tests", () {
    final testChildren = TestChildGenerator();
    final testParents = TestParentGenerator();
    late PersonService personService;
    setUp(() => personService = PersonService(supabaseClient));

    test('getChildren should return all children', () async {
      final result = await personService.getChildren(1);
      debugPrint("$result");
    });

    test('getParents should return all parents', () async {
      final result = await personService.getParents(1);
      debugPrint("$result");
    });

    test('insertChild should insert and return child', () async {
      final result = await personService.insertChild(const Child(
          familyId: 1,
          pin: "1234",
          name: "John",
          icon: ProfileIcon.dog,
          totalPoints: 10));
      debugPrint("$result");
      await personService.deletePerson(result);
    });

    test('insertParent should insert and return parent', () async {
      final result = await personService.insertParent(const Parent(
          familyId: 1, pin: "1234", name: "John", icon: ProfileIcon.dog));
      debugPrint("$result");
      await personService.deletePerson(result);
    });

    test('updateChild should update child', () async {
      await personService.updateChild(const Child(
          familyId: 1,
          pin: "1234",
          name: "John",
          icon: ProfileIcon.dog,
          totalPoints: 10));
    });

    test('updateParent should update parent', () async {
      await personService.updateParent(const Parent(
          familyId: 1, pin: "1234", name: "John", icon: ProfileIcon.dog));
    });

    test('deletePerson should match against id', () async {
      await personService.deletePerson(const Child(
          familyId: 1,
          pin: "1234",
          name: "John",
          icon: ProfileIcon.dog,
          totalPoints: 10));
    });
  }, skip: "Not yet finished");

  group("RewardService tests", () {
    final testData = TestRewardGenerator();
    late RewardService rewardService;

    setUp(() => rewardService = RewardService(supabaseClient));

    test('getRewardsByFamily should return all rewards', () async {
      when(selectBuilder.eq('family_id', testData.familyId))
          .thenAnswer((_) => selectBuilder);
      whenExecuted(selectBuilder).thenCompleteWith(
          Future.value([testData.getMap(0, id: 5), testData.getMap(1, id: 6)]));

      final expected = [testData.get(0, id: 5), testData.get(1, id: 6)];
      final actual = await rewardService.getRewardsByFamily(testData.familyId);

      expect(actual, expected);
    });

    test('insertReward should insert and return reward', () async {
      when(filterBuilder.select('*')).thenAnswer((_) => selectBuilder);
      whenExecuted(selectBuilder)
          .thenCompleteWith(Future.value([testData.getMap(2, id: 5)]));

      final expected = testData.get(2, id: 5);
      final actual =
          await rewardService.insertReward(testData.familyId, testData.get(2));

      expect(actual, expected);
      verify(queryBuilder.insert(testData.getMap(2, includeFamilyId: true)));
    });

    test('updateReward should update reward', () async {
      when(filterBuilder.match(any)).thenAnswer((_) => filterBuilder);
      whenExecuted(filterBuilder).thenCompleteWith(Future.value());

      await rewardService.updateReward(testData.get(3, id: 5));

      debugPrint(testData.getMap(3).toString());
      verify(queryBuilder.update(testData.getMap(3)));
    });

    test('deleteReward should match against id', () async {
      when(filterBuilder.match(any)).thenAnswer((_) => filterBuilder);
      whenExecuted(filterBuilder).thenCompleteWith(Future.value());

      await rewardService.deleteReward(testData.get(4, id: 5));

      verify(filterBuilder.match({"id": 5}));
    });
  });

  group("RewardRedemptionService tests", () {
    final testData = TestRewardRedemptionGenerator();
    late RewardRedemptionService rewardRedemptionService;

    setUp(() =>
        rewardRedemptionService = RewardRedemptionService(supabaseClient));

    test('getRewardRedemptionsByFamily should return all reward redemptions',
        () async {
      when(selectBuilder.eq('family_id', testData.familyId))
          .thenAnswer((_) => selectBuilder);
      whenExecuted(selectBuilder).thenCompleteWith(
          Future.value([testData.getMap(0, id: 5), testData.getMap(1, id: 6)]));

      final expected = [testData.get(0, id: 5), testData.get(1, id: 6)];
      final actual = await rewardRedemptionService
          .getRewardRedemptionsByFamily(testData.familyId);

      expect(actual, expected);
    });

    test('insertRewardRedemption should insert and return reward redemption',
        () async {
      when(filterBuilder.select('*')).thenAnswer((_) => selectBuilder);
      whenExecuted(selectBuilder)
          .thenCompleteWith(Future.value([testData.getMap(2, id: 5)]));

      final expected = testData.get(2, id: 5);
      final actual =
          await rewardRedemptionService.insertRewardRedemption(testData.get(2));

      expect(actual, expected);
      verify(queryBuilder.insert(testData.getMap(2, includeMs: true)));
    });

    test('updateRewardRedemption should update reward redemption', () async {
      when(filterBuilder.match(any)).thenAnswer((_) => filterBuilder);
      whenExecuted(filterBuilder).thenCompleteWith(Future.value());

      await rewardRedemptionService
          .updateRewardRedemption(testData.get(3, id: 5));

      debugPrint(testData.getMap(3, includeMs: true).toString());
      verify(queryBuilder.update(testData.getMap(3, includeMs: true)));
    });

    test('deleteRewardRedemption should match against id', () async {
      when(filterBuilder.match(any)).thenAnswer((_) => filterBuilder);
      whenExecuted(filterBuilder).thenCompleteWith(Future.value());

      await rewardRedemptionService
          .deleteRewardRedemption(testData.get(4, id: 5));

      verify(filterBuilder.match({"id": 5}));
    });
  });
}
