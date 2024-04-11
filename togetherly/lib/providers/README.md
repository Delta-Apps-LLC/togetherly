# Providers

These classes are responsible for managing the high-level state of major portions of the app. In
particular, they are responsible for interacting with services to obtain and update user data in the
back-end. In some cases, providers may interact with other providers in order to use or transform
the state that those providers are in charge of maintaining.


# Design Guide

A provider may act in one or both of the following two roles:
1. Maintain state.
2. Transform state that is maintained elsewhere.


## Providers that Maintain State

A provider that maintains state and does *not* depend upon the state of other providers is made
available to widgets via a `ChangeNotifierProvider` widget. These providers should extend the
`ChangeNotifier` mixin.

All state should be stored in private fields.

State values should be initialized to a reasonable default, which in some cases may be `null`.

If a provider is responsible for supplying a given piece of state to other parts of the application,
it should expose getters to access that state.

```dart
class SomeProvider with ChangeNotifier {
  int _someNumber;
  int get someNumber => _someNumber;
}
```

Most state should be updated via methods on the provider that represent particular actions (e.g.,
add a value to a list, update a name, etc.).

`notifyListeners` should be called whenever a change is made to any state that might be noticed by
consumers. If several values are to be updated, `notifyListeners` should only be called after all
changes have been applied.

```dart
void doThingAndUpdateSomeState(string value) {
  ...
  someState = value;
  notifyListeners();
}
```

**Non-persistent state** is state which exists only for the current instance of the app.

For non-persistent state, it may make sense to allow consumers to update a state value directly.
If this is the case, a provider should expose a setter that updates the private backing value and
calls `notifyListeners`.

```dart
set someNumber(int value) {
  _someNumber = value;
  notifyListeners();
}
```

**Persistent state** is state which is retrieved from and saved to the back-end database.

The default value for most persistent state should be `null`, indicating that the data has not yet
been loaded.

However, if a value is nullable in the back-end (i.e., may be absent), `null` could indicate either
that the data hasn't been loaded, or that it simply isn't present. To resolve this ambiguity, a
provider should expose a related state value that indicates whether or not a value, set of values,
or the state of the provider as a whole has finished being loaded from the back-end.

```dart
// For a particular field
bool _isSomeNumberReady;
bool get isSomeNumberReady => _isSomeNumberReady;

// For the provider as a whole
bool _isReady;
bool get isReady => _isReady;
```

For persistent state, changes should be done only through async functions that return futures.

If it is possible to compute or estimate the new local state, any relevant local state should
updated right away at the start of the async function, after which `notifyListeners` should be
called.

If necessary, any relevant local state should be refreshed once the async operation has completed.
For example, if an error occurred, the provider should attempt reloading the applicable state to
revert any local changes. As usual, `notifyListeners` should be called after any set of state
changes.

```dart
Future<void> setSomeNumber(int? value) async {
  // Update local state and notify listeners
  _someNumber = value;
  notifyListeners();

  try {
    // Perform some operation through a service to persist the change.
    ...
    // Await the completion of that operation.
    ...
  } on Exception {
    // Attempt to refresh state from the back-end.
    refresh();
    // Notify listeners after refreshing the state.
    notifyListeners();
  }
}
```

A provider may also expose **computed state**. That is, state which is not stored in any field, but
is rather computed from other fields and exposed via a getter. 

In almost all cases, this kind of state should not have an associated setter.

```dart
bool get isSomeNumberOdd => someNumber % 2 == 1;
```

In most cases, state values *should not* be returned by via a Future, as this creates multiple
places at which consumers might have to listen for changes. At most, a method should return a void
Future to communicate the progress of some operation. Once the operation has completed, the result
should be reflected in the updated state of the provider.

This includes scenarios where a result set would otherwise be returned by a query. Instead of
returning that result set directly via the method that initiates the query, the current query and
its results should instead be treated as part of the state.

BAD example:
```dart
Future<Iterable<Thing>> searchForThings(string query) async {
  ...
  return resultSet;
}
```

GOOD example:
```dart
string? _currentQuery;
string? currentQuery get => _currentQuery;

List<Thing>? _currentSearchResults;
Iterable<Thing>? currentSearchResults get => _currentSearchResults;

Future<void> updateQuery(string query) async {
  _currentQuery = query;
  _currentSearchResults = null;
  notifyListeners();
  // Perform the query and await its results.
  ...
  _currentSearchResults = resultSet;
  notifyListeners();
}
```

If a provider maintains any persistent state, it should expose a `refresh` method.

This method refreshes the state of the provider by querying any relevant services.

Once all necessary data has been received, the state stored in the provider should be updated and
notifyListeners should be called.

If present, this method should be called in the constructor to load the initial state of the
provider.

```dart
Future<void> refresh() async {
  _value = await service.getValue();
  notifyListeners();
}
```


## Providers that Transform State

A provider that transforms state (and does not maintain any state of its own) is made available to
widgets via a `ProxyProvider` widget. These providers should **not** extend the `ChangeNotifier`
mixin.

This type of provider should have a **private final field** holding each provider whose state it
depends upon. No other fields should be present, except as explained later in this document.

Transformed (i.e., computed) state values should be made available through **getters** that access
and manipulate any of the relevant state values that are maintained by other providers.

```dart
final OtherProvider _otherProvider;

int someNumberTimesTwo get => _otherProvider.someNumber * 2;
```

If a given piece of computed state is expensive to compute, it may be necessary to store its value
in a private field.

This field should be nullable and should not be explicitly initialized (i.e., it should be left to
initialize to the default value of null).

The only place where this field should be mutated is in the getter that computes the value, where it
should be assigned the resulting value using the `??=` operator (which will compute and save the
value if the field is null, but skip the computation if it isn't).

```dart
int? _someNumberTimesTwo;
int someNumberTimesTwo get => (_someNumberTimesTwo ??= _otherProvider.someNumber * 2);
```

The constructor for a proxy provider should only accept instances of the relevant providers. It
should not initialize any of the cache fields for computed values. If none such fields are even
present in the class, the constructor may be `const`.

```dart
class ExampleProxyProvider {
  final SomeProvider _someProvider;
  
  const ExampleProxyProvider(this._someProvider);
  
  ...
}
```

A proxy provider may expose methods for manipulating the state that it depends upon. However, such
manipulation should only be implemented by calls to public setters and methods of the associated
providers.

```dart
Future<void> updateSomeNumberTimesTwo(int someNumberTimesTwo) async {
  if (someNumberTimesTwo % 2 != 0) {
    // Throw some kind of error.
  }
  await _someProvider.updateSomeNumber(someNumberTimesTwo / 2);
}
```


## Providers that Maintain and Transform State

A provider that both consumes the state of other providers and maintains state of its own is made
available to widgets via a `SimpleChangeNotifierProxyProvider` widget. Like providers that only
maintain state, these providers should extend the `ChangeNotifier` mixin.

In most ways, these providers resemble a combination of the other two kinds of providers.
However, there are a couple of differences:

- The fields which contain other providers should not be final.
- There should be an `updateDependencies` method which accepts a new instance of each of the
  depended-upon providers, stores them in the appropriate private fields, and calls
  `notifyListeners`.

The constructor should still accept instances of each of the depended upon providers in order to
initialize the associated fields.

```dart
class SomeOtherProvider with ChangeNotifier {
  SomeOtherProvider(this._otherProvider);
  
  OtherProvider _otherProvider;
  
  void updateDependencies(OtherProvider otherProvider) {
    _otherProvider = otherProvider;
    notifyListeners();
  }
}
```

None of the state from depended-upon providers should be duplicated in the dependent provider. That
is, `updateDependencies` should not copy state from other providers into the provider's own fields,
nor should any getters simply return the state maintained by other providers without transforming it
in some meaningful way.
