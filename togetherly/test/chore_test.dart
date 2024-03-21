import 'package:test/test.dart';
import 'package:togetherly/models/chore.dart';
import 'package:togetherly/services/chore_service.dart';

@GenerateMocks([ChoreService])

void main() {

  test('Chore is added', () {
    Chore testChore = Chore(title: "Dishes", dueDate: DateTime(2024, 12, 28, 6, 0, 0, 0), points: 25, isBonus: false);
    ChoreService service = ChoreService();
    int personId = 12345;
    
    service.addChore(testChore);

    Future<List<Chore>> databaseChore = await service.getChoreList(personId);

    expect(counter.value, 1);
  });
}