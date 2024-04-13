import 'package:togetherly/models/assignment.dart';
import 'package:togetherly/models/child.dart';
import 'package:togetherly/models/chore.dart';
import 'package:togetherly/models/chore_completion.dart';
import 'package:togetherly/models/family.dart';
import 'package:togetherly/models/parent.dart';
import 'package:togetherly/models/person.dart';
import 'package:togetherly/models/reward.dart';
import 'package:togetherly/models/reward_redemption.dart';

abstract class TestDataGenerator<T> {
  final int familyId;

  const TestDataGenerator([this.familyId = 12]);

  T get(int testIndex);

  Map<String, dynamic> getMap(int testIndex);
}

class TestFamilyGenerator extends TestDataGenerator<Family> {
  @override
  Family get(int testIndex, {int? id}) =>
      Family(id: id, name: "Family$testIndex");

  @override
  Map<String, dynamic> getMap(int testIndex, {int? id}) => {
        if (id != null) "id": id,
        "name": "Family$testIndex",
      };
}

class TestChoreGenerator extends TestDataGenerator<Chore> {
  @override
  Chore get(int testIndex, {int? id}) => Chore(
        id: id,
        title: "Title$testIndex",
        description: "Description$testIndex",
        dueDate: DateTime(2040 + testIndex, 2, 3, 4, 5, 6),
        points: 42 + testIndex,
        isShared: testIndex % 2 == 0,
      );

  @override
  Map<String, dynamic> getMap(int testIndex,
          {int? id, bool includeFamilyId = false, includeMs = false}) =>
      {
        if (id != null) "id": id,
        if (includeFamilyId) "family_id": familyId,
        "title": "Title$testIndex",
        "description": "Description$testIndex",
        "points": 42 + testIndex,
        "shared": testIndex % 2 == 0,
        "date_due":
            "${2040 + testIndex}-02-03 04:05:06${includeMs ? '.000' : ''}",
      };
}

class TestAssignmentGenerator extends TestDataGenerator<Assignment> {
  @override
  Assignment get(int testIndex) => Assignment(
        personId: testIndex,
        choreId: testIndex + 1,
        status: AssignmentStatus.values[testIndex % 3],
      );

  @override
  Map<String, dynamic> getMap(int testIndex) => {
        "person_id": testIndex,
        "chore_id": testIndex + 1,
        "status": ["assigned", "pending", "completed"][testIndex % 3],
      };
}

class TestChoreCompletionGenerator extends TestDataGenerator<ChoreCompletion> {
  @override
  ChoreCompletion get(int testIndex, {int? id}) => ChoreCompletion(
        id: id,
        choreId: testIndex,
        childId: testIndex + 1,
        dateSubmitted: DateTime(2040 + testIndex, 2, 3, 4, 5, 6),
        dueDate: DateTime(2041 + testIndex, 2, 3, 4, 5, 6),
        isApproved: testIndex % 2 == 0,
      );

  @override
  Map<String, dynamic> getMap(int testIndex, {int? id, includeMs = false}) => {
        if (id != null) "id": id,
        "chore_id": testIndex,
        "person_id": testIndex + 1,
        "date_submitted":
            "${2040 + testIndex}-02-03 04:05:06${includeMs ? '.000' : ''}",
        "due_date":
            "${2041 + testIndex}-02-03 04:05:06${includeMs ? '.000' : ''}",
        "is_approved": testIndex % 2 == 0,
      };
}

const _profilePicNames = [
  "bear",
  "cat",
  "chicken",
  "dog",
  "fish",
  "fox",
  "giraffe",
  "gorilla",
  "koala",
  "panda",
  "rabbit",
  "tiger"
];

class TestChildGenerator extends TestDataGenerator<Child> {
  @override
  Child get(int testIndex, {int? id}) => Child(
        id: id,
        familyId: familyId,
        pin: "1234${testIndex % 9}",
        name: "Child$testIndex",
        icon: ProfileIcon.values[testIndex % 12],
        totalPoints: testIndex * 10 + 5,
      );

  @override
  Map<String, dynamic> getMap(int testIndex, {int? id}) => {
        if (id != null) "id": id,
        "family_id": familyId,
        "is_parent": false,
        "pin": "1234${testIndex % 9}",
        "name": "Child$testIndex",
        "profile_pic": _profilePicNames[testIndex % 12],
        "total_points": testIndex * 10 + 5,
      };
}

class TestParentGenerator extends TestDataGenerator<Parent> {
  @override
  Parent get(int testIndex, {int? id}) => Parent(
        id: id,
        familyId: familyId,
        pin: "1234${testIndex % 9}",
        name: "Parent$testIndex",
        icon: ProfileIcon.values[testIndex % 12],
      );

  @override
  Map<String, dynamic> getMap(int testIndex, {int? id}) => {
        if (id != null) "id": id,
        "family_id": familyId,
        "is_parent": true,
        "pin": "1234${testIndex % 9}",
        "name": "Parent$testIndex",
        "profile_pic": _profilePicNames[testIndex % 12],
      };
}

class TestRewardGenerator extends TestDataGenerator<Reward> {
  @override
  Reward get(int testIndex, {int? id}) => Reward(
        id: id,
        title: "Title$testIndex",
        description: "Description$testIndex",
        points: 10 + testIndex,
        quantity: 1 + testIndex,
        icon: '🍦🎉🦘🍕🍿🚗'.runes.elementAt(testIndex % 6),
      );

  @override
  Map<String, dynamic> getMap(int testIndex,
          {int? id, bool includeFamilyId = false}) =>
      {
        if (id != null) "id": id,
        if (includeFamilyId) "family_id": familyId,
        "title": "Title$testIndex",
        "description": "Description$testIndex",
        "points": 10 + testIndex,
        "quantity": 1 + testIndex,
        "icon":
            String.fromCharCode('🍦🎉🦘🍕🍿🚗'.runes.elementAt(testIndex % 6)),
      };
}

class TestRewardRedemptionGenerator
    extends TestDataGenerator<RewardRedemption> {
  @override
  RewardRedemption get(int testIndex, {int? id}) => RewardRedemption(
        id: id,
        rewardId: testIndex,
        childId: testIndex + 1,
        quantity: testIndex + 2,
        timestamp: DateTime(2010 + testIndex, 2, 3, 4, 5, 6),
      );

  @override
  Map<String, dynamic> getMap(int testIndex, {int? id, includeMs = false}) => {
        if (id != null) "id": id,
        "reward_id": testIndex,
        "person_id": testIndex + 1,
        "quantity": testIndex + 2,
        "timestamp":
            "${2010 + testIndex}-02-03 04:05:06${includeMs ? '.000' : ''}",
      };
}
