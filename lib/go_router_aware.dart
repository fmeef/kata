import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// A mixin that allows a widget to be aware of the current route.
mixin GoRouterAware<T extends StatefulWidget> on State<T> {
  /// The route to be aware of.
  late final Uri _observerLocation;

  /// The current state of the [_observerLocation].
  late _GoRouterAwareState _state;

  /// go router delegate.
  late GoRouterDelegate _delegate;

  /// The context of the widget.
  late BuildContext _context;

  /// The location of the top route
  Uri? _currentLocation;

  @override
  void initState() {
    _context = context;

    final router = GoRouter.of(_context);

    _state = _GoRouterAwareState.topRoute;
    _observerLocation = router.state.uri;
    _delegate = router.routerDelegate;

    _onChange();
    _delegate.addListener(_onChange);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _context = context;
    super.didChangeDependencies();
  }

  void _onChange() {
    _currentLocation = GoRouter.of(_context).state.uri;

    if (_currentLocation == null) {
      return;
    }

    onRoute(_currentLocation!.path.toString());

    /// If the current route is the top route and the current location is the same as the observer location then [_observerLocation] is the top route.
    if (_state.isTopRoute &&
        _sameLocation(_currentLocation!, _observerLocation)) {
      didPush();
      return;
    }

    /// If the current route is pushed next and the current location is the same as the observer location then [_observerLocation] is returned to the top route.
    if (_state.isPushedNext &&
        _sameLocation(_currentLocation!, _observerLocation)) {
      didPopNext();
      _state = _GoRouterAwareState.topRoute;
      return;
    }

    /// If the current route is not the top route and the current location contains the observer location then [_observerLocation] is no longer the top route.
    if (!_sameLocation(_currentLocation!, _observerLocation) &&
        _currentLocation!.path.toString().contains(_observerLocation.path)) {
      _state = _GoRouterAwareState.pushedNext;
      didPushNext();
      return;
    }

    /// If the current route is the top route and the current location does not contain the observer location then [_observerLocation] is popped off.
    if (_state.isTopRoute &&
        !_currentLocation!.path.toString().contains(_observerLocation.path)) {
      didPop();
      _state = _GoRouterAwareState.poppedOff;
      return;
    }
  }

  /// Check if two locations have the same path.
  bool _sameLocation(Uri a, Uri b) {
    return a.path.toString() == b.path.toString();
  }

  void onRoute(String route) {}

  /// Called when the top route has been popped off, and the current route
  /// shows up.
  void didPopNext() {}

  /// Called when the current route has been pushed.
  void didPush() {}

  /// Called when the current route has been popped off.
  void didPop() {}

  /// Called when a new route has been pushed, and the current route is no
  /// longer visible.
  void didPushNext() {}

  @override
  void dispose() {
    _delegate.removeListener(_onChange);
    super.dispose();
  }
}

enum _GoRouterAwareState {
  pushedNext,
  topRoute,
  poppedOff;

  bool get isTopRoute => this == topRoute;
  bool get isPushedNext => this == pushedNext;
  bool get isPoppedOff => this == poppedOff;
}
