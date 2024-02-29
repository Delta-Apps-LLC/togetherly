import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/person.dart';

class PersonService {
  Future<List<Person>> getFamily(int personId) async {
    var result = await Supabase.instance.client.from('Chore')
        .select('id, assignedPerson,title, description, dueDate, points, status')
        .match({ 'id': personId });
    // result might give a list of database rows
    List<Person> family = [];
    result.forEach((map) {
      var person = Person(
          map['id'], map['personId'], map['title'], map['description'],map['dueDate'], map['points'], map['status'], map[shared]);
      family.add(chore);
    });

    return Future<List<Person>>.value(family);
  }

  Future<Person> getPerson(Person person) async {
    var result = await Supabase.instance.client.from('Person')
        .select('id, assignedPerson,title, description, dueDate, points, status')
        .match({ 'id': person.id });
    // result might give a list of database rows
    var person;
    result.forEach((map) {
      person = Person(
          map['id'], map['personId'], map['title'], map['description'],map['dueDate'], map['points'], map['status'], map[shared]);
    });

    return Future<Person>.value(person);
  }

  Future<void> insertPerson(Person person) async {
    //Service function call and pass chore
    await Supabase.instance.client
        .from('Person')
        .insert({
      'title': chore.title,
      'description': chore.description,
      'dateDue': chore.dateDue,
      'points': chore.points,
      'status': chore.status,
      'personId': chore.personId
    });
  }

  Future<void> deletePerson(Person person) async {
    //await
    await Supabase.instance.client
        .from('Person')
        .delete()
        .match({ 'id': person.id });
  }

  Future<void> updatePerson(Person person) async {
    //Query by choreID
    await Supabase.instance.client
        .from('Person')
        .update({
      'title': chore.title,
      'description': chore.description,
      'dateDue': chore.dateDue,
      'points': chore.points,
      'status': chore.status,
      'personId': chore.personId
    })
        .match({ 'id': chore.id });
  }
}