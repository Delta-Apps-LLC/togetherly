
import 'package:flutter/cupertino.dart';

/// An abstract base class for all Providers.
abstract class BaseProvider with ChangeNotifier {
  // A provider should store state in private fields and implement getters for
  // accessing that state. The state should be initialized to a reasonable
  // default, which may be null in some cases.
  //
  // Example:
  //   int _someNumber;
  //   int get someNumber => _someNumber;

  // A provider may also expose a computed state, which is not stored directly
  // in any backing field, but rather is computed from some other set of fields.
  //
  // Example:
  //   bool get isSomeNumberOdd => someNumber % 2 == 1;

  // For persistent state for which a default value could have ambiguous
  // meaning (e.g., null could mean the data simply isn't present), it may
  // be helpful to provide an additional field indicating the state of that
  // field's retrieval.
  // Such a field should be treated like any other piece of state managed by
  // the provider, except it should typically not have a public setter.
  //
  // Example:
  //   bool _isSomeNumberLoaded;
  //   bool get isSomeNumberLoaded => _isSomeNumberLoaded;

  // For non-persistent state that consumers of the class might need to set
  // directly, a provider should provide a simple setter that updates the
  // private backing value and notifies listeners.
  //
  // Example:
  //   set someNumber(int value) {
  //     _someNumber = value;
  //     notifyListeners();
  //   }

  // notifyListeners should be called whenever a change is made to any state
  // that might be noticed by consumers.
  //
  // Example:
  //   void doSomeOtherThing() {
  //     ...
  //     someOtherState = "Hello";
  //     notifyListeners();
  //   }

  // For persistent state, changes should be done only through async functions
  // that return futures. The state stored in the backing field should only be
  // updated to the new value once the async operation has completed
  // successfully. At that point, notifyListeners should also be called.
  //
  // Example:
  //   Future<void> setSomeNumber(int? value) async {
  //     // Perform some operation through a service.
  //     ...
  //     // Await the successful completion of that operation.
  //     ...
  //     _someNumber = value;
  //     notifyListeners();
  //   }

  // In most cases, states and even results should not be returned by via a
  // Future, as this creates multiple places at which consumers might have to
  // listen for changes.
  //
  // Instead, a method can return a void Future to communicate the progress of
  // some query, after which the state of the provider will be updated and any
  // listeners notified.
  //
  // This includes scenarios where a result set would otherwise be returned by
  // a query. Instead of returning that result set directly via the method
  // that initiates the query, it should be accessible via a getter once the
  // query has completed.
  //
  // BAD example:
  //   Future<List<Thing>> searchForThings(string query) async {
  //     ...
  //     return resultSet;
  //   }
  //
  // GOOD example:
  //   List<Thing>? _currentSearchResults;
  //   List<Thing>? currentSearchResults get => _currentSearchResults;
  //
  //   Future<void> searchForThings(string query) async {
  //     ...
  //     _currentSearchResults = resultSet;
  //     notifyListeners();
  //   }
}
