import 'package:togetherly/utilities/value.dart';

class Family {
  final int? id;
  final String name;

  const Family({this.id, required this.name});

  Family copyWith({Value<int?>? id, String? name}) =>
      Family(id: (id ?? Value(this.id)).value, name: name ?? this.name);

  @override
  String toString() => 'Family(id: $id, name: "$name")';
}
