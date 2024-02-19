import 'package:flutter/cupertino.dart';
import 'package:togetherly/services/example_service.dart';

class ExampleProvider extends ChangeNotifier {
  final ExampleService service;

  ExampleProvider(this.service);

  int get value => service.getValue();
  set value(int value) {
    service.setValue(value);
    notifyListeners();
  }
}
