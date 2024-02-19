abstract interface class ExampleService {
  int getValue();
  void setValue(int value);
}

class ExampleServiceImpl implements ExampleService {
  int value = 0;

  @override int getValue() => value;
  @override void setValue(int value) => this.value = value;
}
