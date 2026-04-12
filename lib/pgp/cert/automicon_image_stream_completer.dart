import 'package:flutter/material.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated_io.dart';

class AutomiconImageStreamCompleter extends ImageStreamCompleter {
  final Set<ImageStreamListener> _listeners = {};
  final Set<VoidCallback> _removedCallbacks = {};

  @override
  void addEphemeralErrorListener(ImageErrorListener listener) {}

  @override
  void addListener(ImageStreamListener listener) {
    _listeners.add(listener);
  }

  @override
  void addOnLastListenerRemovedCallback(VoidCallback callback) {
    _removedCallbacks.add(callback);
  }

  @override
  void removeOnLastListenerRemovedCallback(VoidCallback callback) {
    _removedCallbacks.remove(callback);
  }

  @override
  void removeListener(ImageStreamListener listener) {
    _listeners.remove(listener);
  }

  void onResult(Uint8List image) {
    for (final listener in _listeners) {
      //listener.onImage(ImageInfo(image: Image.memory(image)), true);
    }
  }

  @override
  bool get hasListeners => _listeners.isNotEmpty;
}
