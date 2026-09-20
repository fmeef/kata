import 'dart:io';

import 'package:flutter_rust_bridge_hooks/flutter_rust_bridge_hooks.dart';

void main(List<String> args) async {
  await build(args, (input, output) async {
    await FlutterRustBridgeNativeAssetsBuilder(
      cratePath: 'rust',
      extraCargoEnvironmentVariables: {
        'BOTAN_LIB_DIR': Platform.environment['NIX_BOTAN_LIB_DIR'] ?? '',
      },
    ).run(input: input, output: output);
  });
}
