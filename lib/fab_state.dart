import 'package:kata/fab_observer.dart';

class FabState {
  final Set<FabObserver> saveHandlers = {};

  FabState();

  Future<void> notifySave() async {
    for (final handler in saveHandlers) {
      await handler.handle();
    }
  }

  void addHandler(FabObserver handler) {
    saveHandlers.add(handler);
  }

  void removeHandler(FabObserver handler) {
    saveHandlers.remove(handler);
  }
}
