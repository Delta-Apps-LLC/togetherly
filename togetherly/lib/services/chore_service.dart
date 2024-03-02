import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:togetherly/models/chore.dart';

class ChoreService {
  static const String _choreTable = "chore";

  Future<List<Chore>> getChores() async {
    var result = await Supabase.instance.client.from(_choreTable).select(
        'id, assignedpersonid, title, description, datedue, points, status');
    return result.map(_mapToChore).toList();
  }

  Future<List<Chore>> getChoreList(int personId) async {
    //Sort List Today, upcoming and overdue
    var result = await Supabase.instance.client
        .from(_choreTable)
        .select(
            'id, assignedpersonid, title, description, datedue, points, status')
        .eq('assignedpersonid', personId);
    return result.map(_mapToChore).toList();
  }

  Future<void> insertChore(Chore chore) async {
    //Service function call and pass chore
    await Supabase.instance.client.from(_choreTable).insert(_choreToMap(chore));
  }

  Future<void> deleteChore(Chore chore) async {
    //await
    await Supabase.instance.client
        .from(_choreTable)
        .delete()
        .match({'id': chore.id});
  }

  Future<void> updateChore(Chore chore) async {
    //Query by choreID
    await Supabase.instance.client
        .from(_choreTable)
        .update(_choreToMap(chore))
        .match({'id': chore.id});
  }

  Chore _mapToChore(Map<String, dynamic> map) => Chore(
        id: map['id'],
        assignedChildId: map['assignedpersonid'],
        title: map['title'],
        description: map['description'],
        dueDate: DateTime.parse(map['datedue']),
        points: map['points'],
        status: map['status'],
        isShared: map['shared'],
      );

  Map<String, dynamic> _choreToMap(Chore chore) => {
        'assignedpersonid': chore.assignedChildId,
        'title': chore.title,
        'description': chore.description,
        'datedue': chore.dueDate,
        'points': chore.points,
        'status': chore.status,
        'shared': chore.isShared,
      };
}
