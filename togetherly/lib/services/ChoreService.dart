import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:togetherly/models/Chore.dart';

import '../models/Person.dart';

class ChoreService {

  Future<List<Chore>> getChores() async {
    //TODO FIX select based on column titles
    var result = await Supabase.instance.client.from('Chore')
        .select('id, assignedPerson,title, description, dueDate, points, status');
    // result might give a list of database rows
    List<Chore> chores = [];
    // result.forEach((map) {
    //   var chore = Chore(
    //   map['id'], map['assignedPerson'], map['title'], map['description'],map['dueDate'], map['points'], map['status']);
    //   chores.add(chore);
    // });

    return Future<List<Chore>>.value(chores);
  }

  Future<List<Chore>> getChoreList(Person person) async{
    //Sort List Today, upcoming and overdue
    return [];
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

}