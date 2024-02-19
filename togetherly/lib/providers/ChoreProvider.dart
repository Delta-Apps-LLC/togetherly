
//TODO Figure out initialization
import '../models/Chore.dart';
import '../models/Person.dart';

class ChoreProvider { //TODO extends ChangeNotifier
  List<Chore> choreList = [];

  void watchChoreList(){

  }

  Future<void> addChore(Chore chore) async {
    //Service function call and pass chore
  }

  Future<void> deleteChore(Chore chore) async {
  //await
  }

  Future<void> updateChore(Chore newChore) async {
    //Query by choreID
  }

  Future<List<Chore>> getChoreList(Person person) async{
    //Sort List Today, upcoming and overdue
    return [];
  }
}