
//TODO Figure out initialization
import '../models/Chore.dart';
import '../models/Person.dart';
import '../services/ChoreService.dart';

class ChoreProvider { //TODO extends ChangeNotifier
  //List<Chore> choreList = [];
  List<Chore> todayList = [];
  List<Chore> upcomingList = [];
  List<Chore> overDueList = [];
  ChoreService service = ChoreService();


  void watchChoreList(){

  }

  Future<void> addChore(Chore chore) async {
    service.addChore(chore);
  }

  Future<void> deleteChore(Chore chore) async {
  //await
    service.deleteChore(chore);

  }

  Future<void> updateChore(Chore newChore) async {
    //Query by choreID
    service.updateChore(newChore);
  }

  Future<List<Chore>> getChoreList(Person person) async{
    //Sort List Today, upcoming and overdue
    List<Chore> choreList = await service.getChoreList(person);
    sortChoresByDueDate(choreList);
    return [];
  }

  void sortChoresByDueDate(List<Chore> choreList) {

  }
}