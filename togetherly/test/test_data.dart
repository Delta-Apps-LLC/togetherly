import 'package:togetherly/models/assignment.dart';
import 'package:togetherly/models/child.dart';
import 'package:togetherly/models/chore.dart';
import 'package:togetherly/models/chore_completion.dart';
import 'package:togetherly/models/family.dart';
import 'package:togetherly/models/parent.dart';
import 'package:togetherly/models/reward.dart';
import 'package:togetherly/models/reward_redemption.dart';
import 'package:togetherly/utilities/value.dart';

abstract class TestDataGenerator<T> {
  final int familyId;

  const TestDataGenerator([this.familyId = 12]);

  T get(int testIndex);

  Map<String, dynamic> getMap(int testIndex);
}

class TestFamilyGenerator extends TestDataGenerator<Family> {

}

class TestChoreGenerator extends TestDataGenerator<Chore> {
  @override
  Chore get(int testIndex, {int? id}) => Chore(
    id: id,
    title: "Title$testIndex",
    description: "Description$testIndex",
    dueDate: DateTime(2040 + testIndex),
    points: 42 + testIndex,
    isShared: testIndex % 2 == 0,
  );

  @override
  Map<String, dynamic> getMap(int testIndex, {int? id, bool includeFamilyId = false, includeMs = false}) => {
    if (id != null) "id": id,
    if (includeFamilyId) "family_id": familyId,
    "title": "Title$testIndex",
    "description": "Description$testIndex",
    "points": 42 + testIndex,
    "shared": testIndex % 2 == 0,
    "date_due":
    "${2040 + testIndex}-01-01 00:00:00${includeMs ? '.000' : ''}",
  };
}

class TestAssignmentGenerator extends TestDataGenerator<Assignment> {

}

class TestChoreCompletionGenerator extends TestDataGenerator<ChoreCompletion> {

}

class TestChildGenerator extends TestDataGenerator<Child> {

}

class TestParentGenerator extends TestDataGenerator<Parent> {

}

class TestRewardGenerator extends TestDataGenerator<Reward> {

}

class TestRewardRedemptionGenerator extends TestDataGenerator<RewardRedemption> {

}
