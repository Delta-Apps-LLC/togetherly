import 'package:flutter/material.dart';
import 'package:togetherly/models/person.dart';
import 'package:togetherly/views/widgets/profile_person.dart';

class ProfileList extends StatelessWidget {
  const ProfileList({super.key, required this.list});
  final List<Person> list;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Wrap(
        spacing: 2,
        runSpacing: 2,
        children: list.map((person) => ProfilePerson(person: person)).toList(),
      ),
    );
  }
}
