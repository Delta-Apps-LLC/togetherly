import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:togetherly/models/chore.dart';
import 'package:togetherly/services/chore_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
//@GenerateMocks([])
void main() {
  group('Chore Provider Tests', () {

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

    const String _choreTable = "chore";

    test('Chore is added', () {
      when(Supabase.instance.client.from(_choreTable).insert(_choreToMap(testChore))).thenAnswer();

      choreService.insertChore(testChore);

      //verify(Supabase.instance.client.from(_choreTable).insert(_choreToMap(chore))).called(1);
    });
    test('Chore is deleted', () {
      choreService.deleteChore(testChore);

      //verify(choreService.deleteChore(testChore)).called(1);
    });
    test('Chore is updated', () {
      //provider.updateChore(testChore);

      //verify(choreService.updateChore(testChore)).called(1);
    });
    test('Chore to map function', () {
      //provider.addChore(testChore);

      //verify(choreService.insertChore(testChore)).called(1);
    });
  });
}