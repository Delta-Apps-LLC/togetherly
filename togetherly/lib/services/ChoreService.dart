import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:togetherly/models/Chore.dart';

class ChoreService {

  Future<List<Chore>> getChores() async {
    var result = await Supabase.instance.client.from('Chore')
        .select('id, name, due, completion, points');
    // result might give a list of database rows
    List<Chore> chores = [];
    result.forEach((map) {
      var chore = Chore();
      chore.dayDue = map['due'];
      chore.completion = map['completion'];
      chore.id = map['id'];
      chore.name = map['name'];
      chore.points = map['points'];
      chores.add(chore);
    });

    return Future<List<Chore>>.value(chores);
  }

}