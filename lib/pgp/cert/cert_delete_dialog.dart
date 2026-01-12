import 'package:kata/pgp/cert/cert_card.dart';
import 'package:kata/src/rust/api.dart';
import 'package:kata/src/rust/api/pgp/cert.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CertDeleteDialog extends StatelessWidget {
  final PgpCertWithIds identity;
  final BuildContext context;
  const CertDeleteDialog({
    super.key,
    required this.identity,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final PgpApp app = this.context.read();

    return Dialog(
      child: Padding(
        padding: EdgeInsetsGeometry.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Are you sure you want to delete the card ${identity.ids.first}",
              style: theme.textTheme.titleLarge,
            ),
            CertCard(pgpKey: identity, trust: BigInt.from(0)),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => context.pop(),
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () async {
                    if (identity.cert.hasPrivate) {
                      await app.deletePrivateKey(
                        fingerprint: identity.cert.fingerprint,
                      );
                    } else {
                      await app.deleteCert(
                        fingerprint: identity.cert.fingerprint,
                      );
                    }
                    if (context.mounted) context.pop();
                  },
                  child: const Text('Delete it'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
