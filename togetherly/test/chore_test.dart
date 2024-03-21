import 'package:test/test.dart';
//import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:togetherly/models/chore.dart';
import 'package:togetherly/providers/chore_provider.dart';
import 'package:togetherly/providers/user_identity_provider.dart';
import 'package:togetherly/services/chore_service.dart';

//@GenerateMocks([ChoreService])


// Mock class.
class MockService extends Mock implements ChoreService {}

void main() {
  group('Chore Provider Tests', (){
    //setUp(() {
      //Mock these
      Chore testChore = Chore(title: "Dishes", dueDate: DateTime(2024, 12, 28, 6, 0, 0, 0), points: 25, isShared: false);
      ChoreService mockService = MockService();
      //Mock this?
      UserIdentityProvider userIdentityProvider = UserIdentityProvider();


      ChoreProvider provider = ChoreProvider(mockService, userIdentityProvider);
      //int personId = 12345;
    //});
    test('Chore is added', () {

      //when(mockService.insertChore(testChore)).thenAnswer();

      provider.addChore(testChore);

      verify(mockService.insertChore(testChore)).called(1);
    });
    test('Chore is deleted', () {

      provider.deleteChore(testChore);

      verify(mockService.deleteChore(testChore)).called(1);
    });
    test('Chore is updated', () {

      provider.updateChore(testChore);

      verify(mockService.updateChore(testChore)).called(1);
    });
    test('Chore is added', () {

      provider.addChore(testChore);

      verify(mockService.insertChore(testChore)).called(1);
    });
  });

}