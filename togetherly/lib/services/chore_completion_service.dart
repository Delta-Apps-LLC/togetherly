import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:togetherly/models/chore_completion.dart';

class ChoreCompletionService {
  static const String _completionTable = "chore_completion";
  static const String _familyCompletionView = "family_chore_completion";

  Future<List<ChoreCompletion>> getAssignmentsByFamily(int familyId) async {
    var result = await Supabase.instance.client
        .from(_familyCompletionView)
        .select('id, chore_id, person_id, date_submitted, due_date, is_approved, family_id')
        .eq("family_id", familyId);
    return result.map(_mapToCompletion).toList();
  }

  Future<ChoreCompletion> insertCompletion(ChoreCompletion completion) async {
    return _mapToCompletion(
      (await Supabase.instance.client
          .from(_completionTable)
          .insert(_completionToMap(completion))
          .select())
          .single,
    );
  }

  Future<void> deleteCompletion(ChoreCompletion completion) async {
    await Supabase.instance.client.from(_completionTable).delete().match({
      'id': completion.id,
    });
  }

  Future<void> updateCompletion(ChoreCompletion completion) async {
    await Supabase.instance.client
        .from(_completionTable)
        .update(_completionToMap(completion))
        .match({
      'id': completion.id,
    });
  }

  ChoreCompletion _mapToCompletion(Map<String, dynamic> map) => ChoreCompletion(
    id: map['id'],
    choreId: map['chore_id'],
    childId: map['person_id'],
    dateSubmitted: map['date_submitted'],
    dueDate: map['due_date'],
    isApproved: map['is_approved'],
  );

  Map<String, dynamic> _completionToMap(ChoreCompletion completion) => {
    'id': completion.id,
    'chore_id': completion.choreId,
    'person_id': completion.childId,
    'date_submitted': completion.dateSubmitted,
    'due_date': completion.dueDate,
    'is_approved': completion.isApproved,
  };
}