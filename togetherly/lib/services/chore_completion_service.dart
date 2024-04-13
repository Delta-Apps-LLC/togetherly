import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:togetherly/models/chore_completion.dart';

class ChoreCompletionService {
  static const String _completionTable = "chore_completion";
  static const String _familyCompletionView = "family_chore_completion";

  ChoreCompletionService([SupabaseClient? supabaseClient])
      : _supabaseClient = supabaseClient ?? Supabase.instance.client;

  final SupabaseClient _supabaseClient;

  Future<List<ChoreCompletion>> getChoreCompletionsByFamily(int familyId) async {
    var result = await _supabaseClient
        .from(_familyCompletionView)
        .select(
            'id, chore_id, person_id, date_submitted, due_date, is_approved')
        .eq("family_id", familyId);
    return result.map(_mapToChoreCompletion).toList();
  }

  Future<ChoreCompletion> insertChoreCompletion(ChoreCompletion completion) async {
    return _mapToChoreCompletion(
      (await _supabaseClient
              .from(_completionTable)
              .insert(_choreCompletionToMap(completion))
              .select())
          .single,
    );
  }

  Future<void> deleteChoreCompletion(ChoreCompletion completion) async {
    await _supabaseClient
        .from(_completionTable)
        .delete()
        .match({'id': completion.id});
  }

  Future<void> updateChoreCompletion(ChoreCompletion completion) async {
    await _supabaseClient
        .from(_completionTable)
        .update(_choreCompletionToMap(completion))
        .match({'id': completion.id});
  }

  ChoreCompletion _mapToChoreCompletion(Map<String, dynamic> map) =>
      ChoreCompletion(
        id: map['id'],
        choreId: map['chore_id'],
        childId: map['person_id'],
        dateSubmitted: DateTime.parse(map['date_submitted']),
        dueDate: DateTime.parse(map['due_date']),
        isApproved: map['is_approved'],
      );

  Map<String, dynamic> _choreCompletionToMap(ChoreCompletion completion) => {
        'chore_id': completion.choreId,
        'person_id': completion.childId,
        'date_submitted': completion.dateSubmitted.toString(),
        'due_date': completion.dueDate.toString(),
        'is_approved': completion.isApproved,
      };
}
