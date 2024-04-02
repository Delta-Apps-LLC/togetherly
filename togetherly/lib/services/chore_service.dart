import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:togetherly/models/chore.dart';

class ChoreService {
  static const String _choreTable = "chore";

  Future<List<Chore>> getChoresByFamily(int familyId) async {
    var result = await Supabase.instance.client
        .from(_choreTable)
        .select("id, title, description, points, shared, date_due")
        .eq("family_id", familyId);
    return result.map(_mapToChore).toList();
  }

  Future<Chore> insertChore(int familyId, Chore chore) async {
    //Service function call and pass chore
    final newChore = await Supabase.instance.client
        .from(_choreTable)
        .insert(_choreToMap(chore, familyId))
        .select();
    // TODO: Return selected chore from database
    return _mapToChore(newChore[0]);
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
        title: map['title'],
        description: map['description'],
        dueDate: DateTime.parse(map['date_due']),
        points: map['points'],
        isShared: map['shared'],
      );

  Map<String, dynamic> _choreToMap(Chore chore, [int? familyId]) => {
        if (familyId != null) 'family_id': familyId,
        'title': chore.title,
        'description': chore.description,
        'date_due': chore.dueDate.toString(),
        'points': chore.points,
        'shared': chore.isShared,
      };
}
