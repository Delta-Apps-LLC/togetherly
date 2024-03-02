import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:togetherly/models/chore.dart';

class ChoreService {
  Future<List<Chore>> getChores() async {
    var result = await Supabase.instance.client.from('Chore').select(
        'id, assignedPerson,title, description, dueDate, points, status');
    // result might give a list of database rows
    List<Chore> chores = [];
    result.forEach((map) {
      var chore = Chore(
        id: map['id'],
        assignedChildId: map['personId'],
        title: map['title'],
        description: map['description'],
        dueDate: map['dueDate'],
        points: map['points'],
        status: map['status'],
        isShared: map['shared'],
      );
      chores.add(chore);
    });

    return Future<List<Chore>>.value(chores);
  }

  Future<List<Chore>> getChoreList(int personId) async {
    //Sort List Today, upcoming and overdue
    var result = await Supabase.instance.client
        .from('Chore')
        .select(
            'id, assignedPerson,title, description, dueDate, points, status')
        .eq('personId', personId);
    List<Chore> chores = [];
    result.forEach((map) {
      var chore = Chore(
        id: map['id'],
        assignedChildId: map['personId'],
        title: map['title'],
        description: map['description'],
        dueDate: map['dueDate'],
        points: map['points'],
        status: map['status'],
        isShared: map['shared'],
      );
      chores.add(chore);
    });

    return Future<List<Chore>>.value(chores);
  }

  Future<void> insertChore(Chore chore) async {
    //Service function call and pass chore
    await Supabase.instance.client.from('Chore').insert({
      'title': chore.title,
      'description': chore.description,
      'dateDue': chore.dueDate,
      'points': chore.points,
      'status': chore.status,
      'personId': chore.assignedChildId,
    });
  }

  Future<void> deleteChore(Chore chore) async {
    //await
    await Supabase.instance.client
        .from('Chore')
        .delete()
        .match({'id': chore.id});
  }

  Future<void> updateChore(Chore chore) async {
    //Query by choreID
    await Supabase.instance.client.from('Chore').update({
      'title': chore.title,
      'description': chore.description,
      'dateDue': chore.dueDate,
      'points': chore.points,
      'status': chore.status,
      'personId': chore.assignedChildId,
    }).match({'id': chore.id});
  }
}
