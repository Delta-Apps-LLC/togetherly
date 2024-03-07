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

  // This method is only necessary if a provider talks to services.
  //
  // Refreshes the state by querying any relevant services.
  // After the services have returned all relevant data, the state stored in
  // the provider should be updated and notifyListeners should be called.
  //
  // If present, this method should be called in the constructor to load the
  // initial state of the provider.
  Future<void> refresh() async {
    _value = await service.getValue();
    notifyListeners();
    log("ExampleProvider refreshed!");
  }
}
