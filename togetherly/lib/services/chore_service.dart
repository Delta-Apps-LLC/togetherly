import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:togetherly/models/chore.dart';

class ChoreService {
  static const String _choreTable = "chore";
  static const String _assignmentTable = "assignment";

  Future<List<Chore>> getChoresByFamily(int familyId) async {
    var result = await Supabase.instance.client
        .from('person_chore')
        .select()
        .eq("family_id", familyId);
    return result.map(_mapToChore).toList();
  }

  Future<void> insertChore(int familyId, Chore chore) async {
    //Service function call and pass chore
    await Supabase.instance.client
        .from(_choreTable)
        .insert(_choreToMap(chore, familyId));
  }

  Future<void> deleteChore(Chore chore) async {
    //await
    await Supabase.instance.client
        .from(_choreTable)
        .delete()
        .match({'id': chore.id});
  }

  Future<void> updateChore(Map<String, dynamic> updatedChore) async {
    //Query by choreID
    updatedChore['status'] = _choreStatusToString(updatedChore['status']);
    await Supabase.instance.client
        .from(_assignmentTable)
        .update(updatedChore)
        .match({'chore_id': updatedChore['chore_id']});
  }

  Chore _mapToChore(Map<String, dynamic> map) => Chore(
        id: map['chore_id'],
        title: map['title'],
        description: map['description'],
        dueDate: DateTime.parse(map['date_due']),
        points: map['points'],
        status: _parseChoreStatus(map['status']),
        isShared: map['shared'],
      );

  Map<String, dynamic> _choreToMap(Chore chore, [int? familyId]) => {
        if (familyId != null) 'family_id': familyId,
        'title': chore.title,
        'description': chore.description,
        'date_due': chore.dueDate.toString(),
        'points': chore.points,
        // 'status': _choreStatusToString(chore.status), // removed from chore table
        'shared': chore.isShared,
      };

  ChoreStatus _parseChoreStatus(String status) => switch (status) {
        'assigned' => ChoreStatus.assigned,
        'pending' => ChoreStatus.pending,
        'completed' => ChoreStatus.completed,
        _ => throw FormatException(
            'Unsupported chore status from database "$status"'),
      };

  String _choreStatusToString(ChoreStatus status) => switch (status) {
        ChoreStatus.assigned => 'assigned',
        ChoreStatus.pending => 'pending',
        ChoreStatus.completed => 'completed',
      };
}
