import 'package:flutter_test/flutter_test.dart';
import 'package:togetherly/models/chore.dart';
import 'package:togetherly/services/chore_service.dart';

void main() {
  group('Chore Provider Tests', () {
    //Fix choretest
    Chore testChore = Chore(title: "Dishes",
        dueDate: DateTime(
            2024,
            12,
            28,
            6,
            0,
            0,
            0),
        points: 25,
        isShared: false);
    ChoreService choreService = ChoreService();
    var familyId = 100;

    const String _choreTable = "chore";

    test('Chore is added', () async {

      List<Chore> familyChores = await choreService.getChores(familyId);

      expect(familyChores.length, 0);

      choreService.insertChore(testChore);
      choreService.getChores(familyId);



    });
    test('Chore is deleted', () {

    });
    test('Chore is updated', () {

    });
    test('Chore is added', () {

    });
  });
}