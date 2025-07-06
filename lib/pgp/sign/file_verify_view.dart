import 'dart:async';
import 'dart:typed_data';

import 'package:kata/pgp/sign/abstract_verifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zxing/flutter_zxing.dart';
import 'package:image_picker/image_picker.dart';

class FileVerifyView extends AbstractVerifier {
  final zx = Zxing();
  FileVerifyView({super.key, required this.onError, required this.onSuccess});

  @override
  final FutureOr<void> Function(BuildContext, Uint8List) onSuccess;

  @override
  final FutureOr<void> Function(BuildContext, String) onError;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final XFile? file = await ImagePicker().pickImage(
          source: ImageSource.gallery,
        );
        if (file != null) {
          final DecodeParams params = DecodeParams(
            imageFormat: ImageFormat.rgb,
          );

          final Code result = await zx.readBarcodeImagePath(file, params);
          if (result.isValid && result.rawBytes != null) {
            if (context.mounted) {
              await onSuccess(context, result.rawBytes!);
            }
          } else {
            if (context.mounted) {
              await onError(context, result.error ?? "");
            }
          }
        }
      },
      child: const Text('Pick files'),
    );
  }
}
