import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:togetherly/models/assignment.dart';

class AssignmentService {
  static const String _assignmentTable = "assignment";
  static const String _familyAssignmentView = "family_assignment";

  Future<List<Assignment>> getAssignmentsByFamily(int familyId) async {
    var result = await Supabase.instance.client
        .from(_familyAssignmentView)
        .select('person_id, chore_id, status')
        .eq("family_id", familyId);
    return result.map(_mapToAssignment).toList();
  }

  Future<void> insertAssignment(Assignment assignment) async {
    await Supabase.instance.client
        .from(_assignmentTable)
        .insert(_assignmentToMap(assignment));
  }

  Future<void> deleteAssignment(Assignment assignment) async {
    await Supabase.instance.client.from(_assignmentTable).delete().match({
      'person_id': assignment.personId,
      'chore_id': assignment.choreId,
    });
  }

  Future<void> updateAssignment(Assignment assignment) async {
    await Supabase.instance.client
        .from(_assignmentTable)
        .update(_assignmentToMap(assignment))
        .match({
      'person_id': assignment.personId,
      'chore_id': assignment.choreId,
    });
  }

  Assignment _mapToAssignment(Map<String, dynamic> map) => Assignment(
        personId: map['person_id'],
        choreId: map['chore_id'],
        status: _parseStatus(map['status']),
      );

  Map<String, dynamic> _assignmentToMap(Assignment assignment) => {
        'person_id': assignment.personId,
        'chore_id': assignment.choreId,
        'status': _statusToString(assignment.status),
      };

  AssignmentStatus _parseStatus(String status) => switch (status) {
        'assigned' => AssignmentStatus.assigned,
        'pending' => AssignmentStatus.pending,
        'completed' => AssignmentStatus.completed,
        _ => throw FormatException(
            'Unsupported assignment status from database "$status"'),
      };

  String _statusToString(AssignmentStatus status) => switch (status) {
        AssignmentStatus.assigned => 'assigned',
        AssignmentStatus.pending => 'pending',
        AssignmentStatus.completed => 'completed',
      };
}
