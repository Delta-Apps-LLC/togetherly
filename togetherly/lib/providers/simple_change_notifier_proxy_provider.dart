import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

/// These classes are copied with modifications from the source code for
/// the ChangeNotifierProxyProvider class and its variants. These mainly serve
/// to simply the constructors for those classes, as they required both a create
/// and an update function without taking advantage of when the previous
/// notifier cannot be null.

typedef SimpleChangeNotifierProxyProviderCreate<T, R> = R Function(
  BuildContext context,
  T value,
);

typedef SimpleChangeNotifierProxyProviderCreate2<T, T2, R> = R Function(
  BuildContext context,
  T value,
  T2 value2,
);

typedef SimpleChangeNotifierProxyProviderCreate3<T, T2, T3, R> = R Function(
  BuildContext context,
  T value,
  T2 value2,
  T3 value3,
);

typedef SimpleChangeNotifierProxyProviderCreate4<T, T2, T3, T4, R> = R Function(
  BuildContext context,
  T value,
  T2 value2,
  T3 value3,
  T4 value4,
);

typedef SimpleChangeNotifierProxyProviderUpdate<T, R> = void Function(
  BuildContext context,
  T value,
  R previous,
);

typedef SimpleChangeNotifierProxyProviderUpdate2<T, T2, R> = void Function(
  BuildContext context,
  T value,
  T2 value2,
  R previous,
);

typedef SimpleChangeNotifierProxyProviderUpdate3<T, T2, T3, R> = void Function(
  BuildContext context,
  T value,
  T2 value2,
  T3 value3,
  R previous,
);

typedef SimpleChangeNotifierProxyProviderUpdate4<T, T2, T3, T4, R> = void
    Function(
  BuildContext context,
  T value,
  T2 value2,
  T3 value3,
  T4 value4,
  R previous,
);

class SimpleChangeNotifierProxyProvider<T, R extends ChangeNotifier?>
    extends ListenableProxyProvider<T, R> {
  SimpleChangeNotifierProxyProvider({
    Key? key,
    required SimpleChangeNotifierProxyProviderCreate<T, R> create,
    required SimpleChangeNotifierProxyProviderUpdate<T, R> update,
    bool? lazy,
    TransitionBuilder? builder,
    Widget? child,
  }) : super(
          key: key,
          update: (context, value, previous) {
            if (previous != null) {
              update(context, value, previous);
              return previous;
            } else {
              return create(context, value);
            }
          },
          dispose: _dispose,
          lazy: lazy,
          builder: builder,
          child: child,
        );

  static void _dispose(BuildContext context, ChangeNotifier? notifier) =>
      notifier?.dispose();
}

class SimpleChangeNotifierProxyProvider2<T, T2, R extends ChangeNotifier?>
    extends ListenableProxyProvider2<T, T2, R> {
  SimpleChangeNotifierProxyProvider2({
    Key? key,
    required SimpleChangeNotifierProxyProviderCreate2<T, T2, R> create,
    required SimpleChangeNotifierProxyProviderUpdate2<T, T2, R> update,
    bool? lazy,
    TransitionBuilder? builder,
    Widget? child,
  }) : super(
          key: key,
          update: (context, value, value2, previous) {
            if (previous != null) {
              update(context, value, value2, previous);
              return previous;
            } else {
              return create(context, value, value2);
            }
          },
          dispose: SimpleChangeNotifierProxyProvider._dispose,
          lazy: lazy,
          builder: builder,
          child: child,
        );
}

class SimpleChangeNotifierProxyProvider3<T, T2, T3, R extends ChangeNotifier?>
    extends ListenableProxyProvider3<T, T2, T3, R> {
  SimpleChangeNotifierProxyProvider3({
    Key? key,
    required SimpleChangeNotifierProxyProviderCreate3<T, T2, T3, R> create,
    required SimpleChangeNotifierProxyProviderUpdate3<T, T2, T3, R> update,
    bool? lazy,
    TransitionBuilder? builder,
    Widget? child,
  }) : super(
          key: key,
          update: (context, value, value2, value3, previous) {
            if (previous != null) {
              update(context, value, value2, value3, previous);
              return previous;
            } else {
              return create(context, value, value2, value3);
            }
          },
          dispose: SimpleChangeNotifierProxyProvider._dispose,
          lazy: lazy,
          builder: builder,
          child: child,
        );
}

class SimpleChangeNotifierProxyProvider4<T, T2, T3, T4,
        R extends ChangeNotifier?>
    extends ListenableProxyProvider4<T, T2, T3, T4, R> {
  SimpleChangeNotifierProxyProvider4({
    Key? key,
    required SimpleChangeNotifierProxyProviderCreate4<T, T2, T3, T4, R> create,
    required SimpleChangeNotifierProxyProviderUpdate4<T, T2, T3, T4, R> update,
    bool? lazy,
    TransitionBuilder? builder,
    Widget? child,
  }) : super(
          key: key,
          update: (context, value, value2, value3, value4, previous) {
            if (previous != null) {
              update(context, value, value2, value3, value4, previous);
              return previous;
            } else {
              return create(context, value, value2, value3, value4);
            }
          },
          dispose: SimpleChangeNotifierProxyProvider._dispose,
          lazy: lazy,
          builder: builder,
          child: child,
        );
}
