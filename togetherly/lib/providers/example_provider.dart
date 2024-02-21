import 'dart:developer';

import 'package:togetherly/providers/base_provider.dart';
import 'package:togetherly/services/example_service.dart';

class ExampleProvider extends BaseProvider {
  final ExampleService service;

  ExampleProvider(this.service) {
    log("ExampleProvider created!");
    refresh();
  }

  int? _value;
  int? get value => _value;

  Future<void> setValue(int value) async {
    await service.setValue(value);
    _value = value;
    notifyListeners();
  }

  @override
  Future<void> refresh() async {
    _value = await service.getValue();
    notifyListeners();
    log("ExampleProvider refreshed!");
  }
}
