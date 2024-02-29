import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:togetherly/models/chore.dart';


class ChoreService {

  Future<List<Chore>> getChores() async {
    var result = await Supabase.instance.client.from('Chore')
        .select('id, assignedPerson,title, description, dueDate, points, status');
    // result might give a list of database rows
    List<Chore> chores = [];
    result.forEach((map) {
      var chore = Chore(
          map['id'], map['personId'], map['title'], map['description'],map['dueDate'], map['points'], map['status'], map[shared]);
      chores.add(chore);
    });

    return Future<List<Chore>>.value(chores);
  }

  Future<List<Chore>> getChoreList(int personId) async{
    //Sort List Today, upcoming and overdue
    var result = await Supabase.instance.client.from('Chore')
        .select('id, assignedPerson,title, description, dueDate, points, status')
        .eq('personId', personId);
    List<Chore> chores = [];
    result.forEach((map) {
      var chore = Chore(
          map['id'], map['personId'], map['title'], map['description'],map['dueDate'], map['points'], map['status'], map[shared]);
      chores.add(chore);
    });

    return Future<List<Chore>>.value(chores);
  }

  Future<void> addChore(Chore chore) async {
    //Service function call and pass chore
    await supabase
        .from('cities')
        .insert({
      'title': chore.title,
      'description': chore.description,
      'dateDue': chore.dateDue,
      'points': chore.points,
      'status': chore.status,
      'personId': chore.personId
    });
  }

  Future<void> deleteChore(Chore chore) async {
    //await
    await supabase
        .from('cities')
        .delete()
        .match({ 'id': chore.id });
  }

  Future<void> updateChore(Chore newChore) async {
    //Query by choreID
    await supabase
        .from('cities')
        .update({
          'title': chore.title,
          'description': chore.description,
          'dateDue': chore.dateDue,
          'points': chore.points,
          'status': chore.status,
          'personId': chore.personId
        })
        .match({ 'id': chore.id });
  }

}