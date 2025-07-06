import 'dart:async';
import 'dart:typed_data';

import 'package:kata/pgp/sign/abstract_verifier.dart';
import 'package:kata/pgp/sign/import_cert_options.dart';
import 'package:kata/src/rust/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zxing/flutter_zxing.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class VerifyView extends AbstractVerifier {
  const VerifyView({super.key});

  @override
  FutureOr<void> Function(BuildContext, String) get onError =>
      (ctx, v) async {};

  @override
  FutureOr<void> Function(BuildContext, Uint8List) get onSuccess =>
      (ctx, v) async {
        final Logger logger = ctx.read();
        final PgpApp pgpApp = ctx.read();
        final result = await pgpApp.verifyQrAllCerts(content: v);
        logger.d(
          'result ${result.content?.handle} ${result.content?.resource}',
        );
        final opt = ImportCertOptions(
          fingerprint: result.fingerprints.first,
          content: result,
        );
        if (ctx.mounted) {
          if (ctx.canPop()) ctx.pop();
          ctx.push('/import', extra: opt);
        }
      };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ReaderWidget(
            onScan: (image) async {
              if (image.isValid && image.rawBytes != null && context.mounted) {
                await onSuccess(context, image.rawBytes!);
              } else if (context.mounted) {
                await onError(context, image.error ?? "");
              }
            },
          ),
        ),
      ],
    );
  }
}
