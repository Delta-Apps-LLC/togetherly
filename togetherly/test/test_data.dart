import 'package:togetherly/models/chore.dart';

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
