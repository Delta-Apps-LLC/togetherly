abstract interface class ExampleService {
  Future<int> getValue();
  Future<void> setValue(int value);
}

class ExampleServiceImpl implements ExampleService {
  int value = 0;

  @override Future<int> getValue() async => value;
  @override Future<void> setValue(int value) async => this.value = value;
}
