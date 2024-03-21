import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:togetherly/models/chore.dart';
import 'package:togetherly/services/chore_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
    ChoreService mockService = ChoreService();
    const String _choreTable = "chore";

    test('Chore is added', () {
      //when(Supabase.instance.client.from(_choreTable).insert(_choreToMap(testChore))).thenAnswer();

      mockService.insertChore(testChore);

      //verify(Supabase.instance.client.from(_choreTable).insert(_choreToMap(chore))).called(1);
    });
    test('Chore is deleted', () {
      mockService.deleteChore(testChore);

      //verify(mockService.deleteChore(testChore)).called(1);
    });
    test('Chore is updated', () {
      //provider.updateChore(testChore);

      //verify(mockService.updateChore(testChore)).called(1);
    });
    test('Chore is added', () {
      //provider.addChore(testChore);

      //verify(mockService.insertChore(testChore)).called(1);
    });
  });
}