

enum FamilyRole {
  PARENT,
  CHILD
  // Add more statuses as needed
}

class Person {
  final int id; //TODO set to auto increment in the database
  final int familyId;
  final String name;
  final FamilyRole role;

  // Add other properties as needed
  const Person({
    required this.familyId,
    required this.name,
    required this.role,
    this.id = 0 //TODO FIX!
  });
}
