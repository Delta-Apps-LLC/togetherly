
import '../models/person.dart';
import 'package:togetherly/services/person_service.dart';
import 'base_provider.dart';

class PersonProvider extends BaseProvider {
  final PersonService service;
  final int personId;

  ChoreProvider(this.service, this.personId) {
    log("PersonProvider created!");
    refresh();
  }

  Future<void> addPerson(Person person) async {
    await service.insertPerson(person);
    await refresh();
  }

  Future<void> deletePerson(Person person) async {
    await service.deletePerson(Person);
    await refresh();
  }

  Future<void> updatePerson(Person person) async {
    await service.updatePerson(person);
    await refresh();
  }

  //TODO: When do we need the refresh

  @override
  Future<void> refresh() {
    // TODO: implement refresh
    throw UnimplementedError();
  }
}