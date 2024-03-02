// Simple wrapper class used by copyWith methods to allow optionally specifying
// nullable fields.
// See https://stackoverflow.com/questions/68009392/dart-custom-copywith-method-with-nullable-properties
class Value<T> {
  final T value;
  const Value(this.value);
}
