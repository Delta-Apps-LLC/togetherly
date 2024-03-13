import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:togetherly/models/assignment.dart';


class AssignmentService {
  static const String _assignmentTable = "assignment";

  Future<List<Assignment>> getAssignments() async {
    var result = await Supabase.instance.client.from(_assignmentTable).select(
        'person_id, chore_id, status');
    return result.map(_mapToAssignment).toList();
  }

  Future<List<Assignment>> getFamilyAssignments(int familyId) async {
    var result = await Supabase.instance.client.from("family_assignment").select().eq("family_id", familyId);
    return result.map(_mapToAssignment).toList();
  }

  Future<void> insertChore(Assignment assignment) async {
    //Service function call and pass chore
    await Supabase.instance.client.from(_assignmentTable)
        .insert(_assignmentToMap(assignment));
  }

  Future<void> deleteChore(Assignment assignment) async {
    //await
    await Supabase.instance.client
        .from(_assignmentTable)
        .delete()
        .match({
          'person_id': assignment.personId,
          'chore_id': assignment.choreId
        });
  }

  Future<void> updateChore(Assignment assignment) async {
    //Query by choreID
    await Supabase.instance.client
        .from(_assignmentTable)
        .update(_assignmentToMap(assignment))
        .match({
          'person_id': assignment.personId,
          'chore_id': assignment.choreId
        });
  }

  Assignment _mapToAssignment(Map<String, dynamic> map) => Assignment(
      personId: map['person_id'],
      choreId: map['chore_id'],
      status: map['status'],
  );

  Map<String, dynamic> _assignmentToMap(Assignment assignment) => {
    'person_id': assignment.personId,
    'chore_id': assignment.choreId,
    'status': assignment.status,
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