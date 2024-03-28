import 'package:flutter_test/flutter_test.dart';
import 'package:togetherly/models/chore.dart';
import 'package:togetherly/services/chore_service.dart';

void main() {
  group('Chore Provider Tests', () {


    //Fix choretest
    // Chore testChore = Chore(title: "Dishes",
    //     dueDate: DateTime(
    //         2024,
    //         12,
    //         28,
    //         6,
    //         0,
    //         0,
    //         0),
    //     points: 25,
    //     isShared: false);
    //Chore testChore = Chore()
    ChoreService choreService = ChoreService();
    var familyId = 100;
    var personId = 7;

    const String _choreTable = "chore";

    test('Chore is added', () async {
      //Check family is empty
      List<Chore> familyChores = await choreService.getChores(familyId);

      expect(familyChores.length, 0);

      choreService.insertChore(testChore);

      //Check chore has been added correctly
      choreService.getChores(familyId);

      //Delete chore



    });
    test('Chore is deleted', () async {
      //insert test chore
      //Test its there and then test it is not there
      //delete chore
      //Test that is deleted

    });
    test('Chore is updated', () {
      //add chore
      //update chore
      //test it was updated
      //delete chore
    });
    test('Get family chores', () {
      //add chore
      //get family chore
      //check each chore has correct family id
      //delete chore
    });
  });
}