import 'package:togetherly/models/assignment.dart';
import 'package:togetherly/models/child.dart';
import 'package:togetherly/models/chore.dart';
import 'package:togetherly/models/chore_completion.dart';
import 'package:togetherly/models/family.dart';
import 'package:togetherly/models/parent.dart';
import 'package:togetherly/models/reward.dart';
import 'package:togetherly/models/reward_redemption.dart';

abstract class TestDataGenerator<T> {
  final int familyId;

  const TestDataGenerator([this.familyId = 12]);

  T get(int testIndex);

  Map<String, dynamic> getMap(int testIndex);
}

abstract class TestDataWithIdGenerator<T> extends TestDataGenerator<T> {
  T getWithId(int testIndex, int id);

  Map<String, dynamic> getMapWithId(int testIndex, [bool includeFamilyId = false]);
}

class TestFamilyGenerator extends TestDataWithIdGenerator<Family> {

}

class TestChoreGenerator extends TestDataWithIdGenerator<Chore> {

}

class TestAssignmentGenerator extends TestDataGenerator<Assignment> {

}

class TestChoreCompletionGenerator extends TestDataWithIdGenerator<ChoreCompletion> {

}

class TestChildGenerator extends TestDataWithIdGenerator<Child> {

}

class TestParentGenerator extends TestDataWithIdGenerator<Parent> {

}

class TestRewardGenerator extends TestDataWithIdGenerator<Reward> {

}

class TestRewardRedemptionGenerator extends TestDataWithIdGenerator<RewardRedemption> {

}

class TestData {
  final int familyId;

  const TestData([this.familyId = 12]);

  Chore getChore(int testIndex, {int? id}) => Chore(
    id: id,
    title: "Title$testIndex",
    description: "Description$testIndex",
    dueDate: DateTime(2040 + testIndex),
    points: 42 + testIndex,
    isShared: testIndex % 2 == 0,
  );

  Map<String, dynamic> getMapForChore(int testIndex, {int? id, bool includeFamilyId = false, includeMs = false}) => {
    if (id != null) "id": id,
    if (includeFamilyId) "family_id": familyId,
    "title": "Title$testIndex",
    "description": "Description$testIndex",
    "points": 42 + testIndex,
    "shared": testIndex % 2 == 0,
    "date_due": "${2040 + testIndex}-01-01 00:00:00${includeMs ? '.000' : ''}",
  };


}
