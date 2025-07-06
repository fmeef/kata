import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';

abstract class AbstractVerifier extends StatelessWidget {
  abstract final FutureOr<void> Function(BuildContext, Uint8List) onSuccess;
  abstract final FutureOr<void> Function(BuildContext, String) onError;
  const AbstractVerifier({super.key});
}
