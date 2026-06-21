import 'dart:async';

typedef Handler = FutureOr<void> Function();

class FabObserver {
  final Handler handler;

  const FabObserver({required this.handler});

  FutureOr<void> handle() async {
    await handler();
  }
}
