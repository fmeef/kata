import 'dart:io';

import 'package:kata/pgp/cert/active_cert.dart';
import 'package:kata/pgp/cert/cert_card.dart';
import 'package:kata/pgp/sign/file_verify_view.dart';
import 'package:kata/pgp/sign/import_cert_options.dart';
import 'package:kata/src/rust/api.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class SignVerifyDialog extends StatelessWidget {
  final BuildContext context;
  const SignVerifyDialog({super.key, required this.context});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    PgpApp pgpApp = context.read();
    final ActiveCert activeCert = context.read();
    final cert = activeCert.cert;
    Logger logger = context.read();
    return Dialog(
      child: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Current card:', style: theme.textTheme.titleLarge),
            if (cert != null)
              CertCard(pgpKey: cert, trust: BigInt.from(0))
            else
              Center(child: CircularProgressIndicator()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (context.canPop()) {
                      context.pop();
                    }
                    context.push('/share');
                  },
                  child: const Text('Create card'),
                ),
                if (Platform.isAndroid || Platform.isIOS)
                  ElevatedButton(
                    onPressed: () {
                      if (context.canPop()) {
                        context.pop();
                      }
                      context.push('/scan');
                    },
                    child: const Text('Scan card'),
                  )
                else
                  FileVerifyView(
                    onError: (ctx, e) {
                      logger.e('failed to read file $e');
                    },
                    onSuccess: (ctx, v) async {
                      final result = await pgpApp.verifyQrAllCerts(content: v);
                      logger.d('result ${result.key}');
                      final opt = ImportCertOptions(
                        fingerprint: result.fingerprints.first,
                        content: result,
                      );
                      if (context.mounted) {
                        context.pop();
                        context.push('/import', extra: opt);
                      }
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
