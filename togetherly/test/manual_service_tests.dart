import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:togetherly/services/assignment_service.dart';
import 'package:togetherly/services/chore_completion_service.dart';
import 'package:togetherly/services/chore_service.dart';
import 'package:togetherly/services/family_service.dart';
import 'package:togetherly/services/person_service.dart';
import 'package:togetherly/services/reward_redemption_service.dart';
import 'package:togetherly/services/reward_service.dart';
import 'package:togetherly/utilities/env.dart';

import 'test_data.dart';

/*
These tests are intended to be run manually as a type of integration test, as
they perform actual database read and write operations. These cover a more
limited subset of the functionality of the services, but should be sufficient
to ensure that the services can read and write to the actual database properly.
 */

void main() {
  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    // In automated unit tests, this would be TestWidgetsFlutterBinding.
    WidgetsFlutterBinding.ensureInitialized();
    await Supabase.initialize(
        url: Env.supabaseUrl, anonKey: Env.supabaseAnonKey);
  });

  group("AssignmentService tests", () {
    const testChildren = TestChildGenerator(1);
    const testChores = TestChoreGenerator(1);
    const testData = TestAssignmentGenerator(1);
    late PersonService personService;
    late ChoreService choreService;
    late AssignmentService assignmentService;

    setUp(() {
      personService = PersonService();
      choreService = ChoreService();
      assignmentService = AssignmentService();
    });

    test('getAssignmentsByFamily', () async {
      final result =
          await assignmentService.getAssignmentsByFamily(testData.familyId);
      debugPrint("Result: $result");
    });

    test('insertAssignment', () async {
      final child = await personService.insertChild(testChildren.get(0));
      final chore = await choreService.insertChore(
          testChores.familyId, testChores.get(0));

      final input =
          testData.get(1).copyWith(personId: child.id, choreId: chore.id);
      debugPrint("Input: $input");
      final result = await assignmentService.insertAssignment(input);
      debugPrint("Result: $result");
      await assignmentService.deleteAssignment(result);

      await choreService.deleteChore(chore);
      await personService.deletePerson(child);
    });
  });

  group("ChoreService tests", () {
    const testData = TestChoreGenerator(1);
    late ChoreService choreService;

    setUp(() => choreService = ChoreService());

    test('getChoresByFamily', () async {
      final result = await choreService.getChoresByFamily(testData.familyId);
      debugPrint("Result: $result");
    });

    test('insertChore', () async {
      final input = testData.get(0);
      debugPrint("Input: $input");
      final result = await choreService.insertChore(testData.familyId, input);
      debugPrint("Result: $result");
      await choreService.deleteChore(result);
    });
  });

  group("ChoreCompletionService tests", () {
    const testChildren = TestChildGenerator(1);
    const testChores = TestChoreGenerator(1);
    const testData = TestChoreCompletionGenerator(1);
    late PersonService personService;
    late ChoreService choreService;
    late ChoreCompletionService completionService;

    setUp(() {
      personService = PersonService();
      choreService = ChoreService();
      completionService = ChoreCompletionService();
    });

    test('getChoreCompletionsByFamily', () async {
      final result = await completionService
          .getChoreCompletionsByFamily(testData.familyId);
      debugPrint("Result: $result");
    });

    test('insertAssignment', () async {
      final child = await personService.insertChild(testChildren.get(0));
      final chore = await choreService.insertChore(
          testChores.familyId, testChores.get(0));

      final input =
          testData.get(1).copyWith(childId: child.id, choreId: chore.id);
      debugPrint("Input: $input");
      final result = await completionService.insertChoreCompletion(input);
      debugPrint("Result: $result");
      await completionService.deleteChoreCompletion(result);

      await choreService.deleteChore(chore);
      await personService.deletePerson(child);
    });
  });

  group("FamilyService tests", () {
    const testData = TestFamilyGenerator(1);
    late FamilyService familyService;

    setUp(() => familyService = FamilyService());

    test('getFamilyName', () async {
      final result = await familyService.getFamilyName(testData.familyId);
      debugPrint("Result: $result");
    });

    test('insertFamily', () async {
      final input = testData.get(0).name;
      debugPrint("Input: $input");
      final result = await familyService.insertFamily(input);
      debugPrint("Result: $result");
      await familyService.deleteFamily(result.id!);
    });
  });

  group("PersonService tests", () {
    const testChildren = TestChildGenerator(1);
    const testParents = TestParentGenerator(1);
    late PersonService personService;

    setUp(() => personService = PersonService());

    test('getChildren', () async {
      final result = await personService.getChildren(testChildren.familyId);
      debugPrint("Result: $result");
    });

    test('getParents', () async {
      final result = await personService.getParents(testParents.familyId);
      debugPrint("Result: $result");
    });

    test('insertChild', () async {
      final input = testChildren.get(0);
      debugPrint("Input: $input");
      final result = await personService.insertChild(input);
      debugPrint("Result: $result");
      await personService.deletePerson(result);
    });

    test('insertParent', () async {
      final input = testParents.get(0);
      debugPrint("Input: $input");
      final result = await personService.insertParent(input);
      debugPrint("Result: $result");
      await personService.deletePerson(result);
    });
  });

  group("RewardService tests", () {
    const testData = TestRewardGenerator(1);
    late RewardService rewardService;
    setUp(() => rewardService = RewardService());

    test('getRewardsByFamily', () async {
      final result = await rewardService.getRewardsByFamily(testData.familyId);
      debugPrint("Result: $result");
    });

    test('insertReward', () async {
      final input = testData.get(0);
      debugPrint("Input: $input");
      final result = await rewardService.insertReward(testData.familyId, input);
      debugPrint("Result: $result");
      await rewardService.deleteReward(result);
    });
  });

  group("RewardRedemptionService tests", () {
    const testChildren = TestChildGenerator(1);
    const testRewards = TestRewardGenerator(1);
    const testData = TestRewardRedemptionGenerator(1);
    late PersonService personService;
    late RewardService rewardService;
    late RewardRedemptionService rewardRedemptionService;

    setUp(() {
      personService = PersonService();
      rewardService = RewardService();
      rewardRedemptionService = RewardRedemptionService();
    });

    test('getRewardRedemptionsByFamily', () async {
      final result = await rewardRedemptionService
          .getRewardRedemptionsByFamily(testData.familyId);
      debugPrint("Result: $result");
    });

    test('insertReward', () async {
      final child = await personService.insertChild(testChildren.get(0));
      final reward = await rewardService.insertReward(
          testRewards.familyId, testRewards.get(0));

      final input =
          testData.get(1).copyWith(childId: child.id, rewardId: reward.id);
      debugPrint("Input: $input");
      final result =
          await rewardRedemptionService.insertRewardRedemption(input);
      debugPrint("Result: $result");
      await rewardRedemptionService.deleteRewardRedemption(result);

      await rewardService.deleteReward(reward);
      await personService.deletePerson(child);
    });
  });
}
