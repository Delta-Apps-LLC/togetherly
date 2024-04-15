import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:togetherly/models/family.dart';

class FamilyService {
  Future<String> getFamilyName(int familyId) async {
    var result = await Supabase.instance.client
        .from('family')
        .select('name')
        .match({'id': familyId}).single();

    return Future<String>.value(result['name']);
  }

  Future<Family> insertFamily(String name) async {
    //Service function call and pass chore
    Map<String, dynamic> map = (await Supabase.instance.client
            .from('family')
            .insert({'name': name}).select())
        .single;

    return Family(
      id: map['id'],
      name: map['name'],
    );
  }

  Future<void> deleteFamily(int familyId) async {
    //await
    await Supabase.instance.client
        .from('family')
        .delete()
        .match({'id': familyId});
  }

  Future<void> updateFamilyName(int familyId, String newName) async {
    //Query by choreID
    await Supabase.instance.client
        .from('family')
        .update({'name': newName}).match({'id': familyId});
  }
}
